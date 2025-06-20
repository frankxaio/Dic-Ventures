
// `timescale 1ns / 10ps

module CONV (
  output logic        busy,
  output logic [11:0] iaddr,     //* request address of image data
  output logic        cwr,       //* write enable
  output logic [11:0] caddr_wr,  //* write address of data
  output logic [19:0] cdata_wr,  //* write data
  output logic        crd,       //* read enable
  output logic [11:0] caddr_rd,  //* read address of data
  output logic [ 2:0] csel,      //* 3'b000: X, 3'b001: Access MEML0, 3'b011: Access MEML1
  input               clk,
  input               reset,
  input        [19:0] idata,     //* image data input
  input        [19:0] cdata_rd,  //* read caddr_rd of data
  input               ready      //* image data ready
);

  // ===========================================
  // PRELOAD
  // ===========================================
  // Kernel
  // 4 bits integer, 16 bits fraction
  // +--------+--------+--------+
  // | 0A89E  | 092D5  | 06D43  |
  // +--------+--------+--------+
  // | 01004  | F8F71  | F6E54  |
  // +--------+--------+--------+
  // | FA6D7  | FC834  | FAC19  |
  // +--------+--------+--------+
  logic signed [19:0] KERNEL[9];
  assign KERNEL = '{
          20'h0A89E,
          20'h092D5,
          20'h06D43,
          20'h01004,
          20'hF8F71,
          20'hF6E54,
          20'hFA6D7,
          20'hFC834,
          20'hFAC19
      };

  // Bias
  // Convolutioon result is 40 bits
  // 8 bits integer, 32 bits fraction
  // 20 bits of bias is 01310 (Q4.16)
  logic signed [39:0] BIAS;
  assign BIAS = 40'h00_1310_0000;

  //========================================
  // Internal Signals
  //========================================

  // Coordinates for a 64x64 image
  logic [5:0] row, col;  //* tracks current row and column indices

  // Captured input signal for convolution
  logic signed [19:0] idata_r;  //* holds one tap of input data

  // Convolution operations
  logic signed [39:0] conv_mul;  //* multiplication result (double width)
  logic signed [39:0] conv_mac;  //* accumulate multiplication results + bias
  logic        [19:0] conv_res;  //* final 20-bit convolution output

  // Convolution state counters
  logic        [ 3:0] ST_CONV_cnt;  //* main convolution counter
  logic        [ 3:0] ST_CONV_cnt_r;  //* registered version of convolution counter

  // Holds the kernel data for current convolution tap
  logic signed [19:0] kernel_wire;  //* selected kernel coefficient

  // Max-pool state counters
  logic        [ 2:0] ST_MAXPOOL_cnt;  //* main max-pool counter
  logic        [ 2:0] ST_MAXPOOL_cnt_r;  //* registered version of max-pool counter

  // Final output from max-pool
  logic        [19:0] maxpool_res;  //* 20-bit maximum pooled result


  // ===========================================
  // FSM State
  // ===========================================
  typedef enum logic [2:0] {
    ST_IDLE          = 3'b000,
    ST_CONV          = 3'b001,
    ST_WR_MEM_L0     = 3'b011,
    ST_CHECK_CONV    = 3'b010,
    ST_MAXPOOL       = 3'b110,
    ST_WR_MEM_L1     = 3'b111,
    ST_CHECK_MAXPOOL = 3'b101,
    ST_DONE          = 3'b100
  } state_t;

  state_t cs, ns;



  // ===========================================
  // row[5:0], col[5:0] counter
  // ===========================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      row <= 0;
      col <= 0;
    end else if (cs == ST_WR_MEM_L0) begin
      col <= col + 1'd1;
      row <= (col == 63) ? row + 1'd1 : row;
    end else if (cs == ST_WR_MEM_L1) begin
      col <= col + 2'd2;
      row <= (col == 62) ? row + 2'd2 : row;
    end
  end

  // ===========================================
  // Request Data
  // ===========================================
  // addr = row * 63 + col == {row, col}

  always_ff @(posedge clk) begin
    if (ns == ST_CONV) begin
      unique case (ST_CONV_cnt)
        // Directly using {row-1, col-1}... will cause an error
        4'd0:    iaddr[11:0] <= {row[5:0] - 1'b1, col[5:0] - 1'b1};
        4'd1:    iaddr[11:0] <= {row[5:0] - 1'b1, col[5:0]};
        4'd2:    iaddr[11:0] <= {row[5:0] - 1'b1, col[5:0] + 1'b1};
        4'd3:    iaddr[11:0] <= {row[5:0], col[5:0] - 1'b1};
        4'd4:    iaddr[11:0] <= {row[5:0], col[5:0]};
        4'd5:    iaddr[11:0] <= {row[5:0], col[5:0] + 1'b1};
        4'd6:    iaddr[11:0] <= {row[5:0] + 1'b1, col[5:0] - 1'b1};
        4'd7:    iaddr[11:0] <= {row[5:0] + 1'b1, col[5:0]};
        4'd8:    iaddr[11:0] <= {row[5:0] + 1'b1, col[5:0] + 1'b1};
        default: iaddr[11:0] <= iaddr[11:0];
      endcase
    end
  end

  // ===========================================
  // ST_CONV_counter
  // ===========================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) ST_CONV_cnt <= 0;
    else if (ns == ST_CONV) ST_CONV_cnt <= ST_CONV_cnt + 1'b1;
    else if (ns == ST_CHECK_CONV) ST_CONV_cnt <= 0;
    else ST_CONV_cnt <= ST_CONV_cnt;
  end

  // ===========================================
  // Convolution Calculation
  // ===========================================
  // zero-padding selection
  always_ff @(posedge clk) begin
    if (cs == ST_CONV) begin
      unique case (ST_CONV_cnt_r)
        4'd0:    idata_r <= (row == 0 || col == 0) ? 0 : idata;
        4'd1:    idata_r <= (row == 0) ? 0 : idata;
        4'd2:    idata_r <= (row == 0 || col == 63) ? 0 : idata;
        4'd3:    idata_r <= (col == 0) ? 0 : idata;
        4'd4:    idata_r <= idata;
        4'd5:    idata_r <= (col == 63) ? 0 : idata;
        4'd6:    idata_r <= (row == 63 || col == 0) ? 0 : idata;
        4'd7:    idata_r <= (row == 63) ? 0 : idata;
        4'd8:    idata_r <= (row == 63 || col == 63) ? 0 : idata;
        default: idata_r <= idata_r;
      endcase
    end
  end

  // ======timestamps 0======
  // ST_CONV_cnt == 0;
  // idata_r  = x;
  // ======timestamps 1======
  // ST_CONV_cnt == 1;
  // idata_r = (row == 0 || col == 0) ? 0 : idata
  // kernel = KERNEL[0] = KERNEL[ST_CONV_cnt-1]
  always_ff @(posedge clk) begin
    if (ns == ST_CONV) ST_CONV_cnt_r <= ST_CONV_cnt;
    // ST_CONV_cnt_r <= ST_CONV_cnt;
  end

  always_comb begin
    unique case (ST_CONV_cnt_r)
      4'd1:    kernel_wire = KERNEL[0];
      4'd2:    kernel_wire = KERNEL[1];
      4'd3:    kernel_wire = KERNEL[2];
      4'd4:    kernel_wire = KERNEL[3];
      4'd5:    kernel_wire = KERNEL[4];
      4'd6:    kernel_wire = KERNEL[5];
      4'd7:    kernel_wire = KERNEL[6];
      4'd8:    kernel_wire = KERNEL[7];
      4'd9:    kernel_wire = KERNEL[8];
      default: kernel_wire = 20'b0;
    endcase
  end

  assign conv_mul = idata_r * kernel_wire;

  always_ff @(posedge clk) begin
    if (cs == ST_CONV)
      if (ST_CONV_cnt_r == 0) conv_mac <= '0;
      else if (ST_CONV_cnt_r == 4'd10) conv_mac <= conv_mac + BIAS;
      else conv_mac <= conv_mac + conv_mul;
  end


  // ===========================================
  // csel
  // ===========================================
  always_comb begin
    if (cs == ST_WR_MEM_L0) csel = 3'b001;  // write MEM_L0
    else if (cs == ST_MAXPOOL) csel = 3'b001;  // read MEM_L0
    else if (cs == ST_WR_MEM_L1) csel = 3'b011;  // write MEM_L1
    else csel = 0;
  end


  // ===========================================
  // cwr, caddr_wr, cdata_wr
  // ===========================================
  //        cwr,       write enable
  // [11:0] caddr_wr,  write address of data
  // [19:0] cdata_wr,  write data
  always_ff @(posedge clk) begin
    if (ns == ST_WR_MEM_L0) cwr <= 1;
    else if (ns == ST_WR_MEM_L1) cwr <= 1;
    else cwr <= 0;
  end

  always_ff @(posedge clk) begin
    if (ns == ST_WR_MEM_L0) caddr_wr <= {row, col};
    else if (ns == ST_WR_MEM_L1) caddr_wr <= {2'b00, {row[5:1], col[5:1]}};
    // row/2 and col/2 is address of maxpool processing
  end



  // conv_mac is 40 bits, 0-31 bits are fraction, 32-39 bits are integer
  // Rounding off at the 17th position after the decimal point
  assign conv_res = (conv_mac[15]) ?
                    {conv_mac[35:32],conv_mac[31:16]} + 1 :
                    {conv_mac[35:32],conv_mac[31:16]};

  // cdata_wr
  always_comb begin
    if (cs == ST_WR_MEM_L0) cdata_wr = conv_mac[39] ? 0 : conv_res;
    else if (cs == ST_WR_MEM_L1) cdata_wr = maxpool_res;
    else cdata_wr = 0;
  end


  // ===========================================
  // read memory
  // ===========================================
  // output logic        crd,        read enable
  // output logic [11:0] caddr_rd,   read address of data
  // input        [19:0] cdata_rd,   read caddr_rd of data

  always_ff @(posedge clk) begin
    if (ns == ST_MAXPOOL) ST_MAXPOOL_cnt <= ST_MAXPOOL_cnt + 1;
    else ST_MAXPOOL_cnt <= 0;
  end

  always_ff @(posedge clk) begin
    ST_MAXPOOL_cnt_r <= ST_MAXPOOL_cnt;
  end

  always_ff @(posedge clk) begin
    if (ns == ST_MAXPOOL) crd <= 1;
    else crd <= 0;
  end

  always_ff @(posedge clk) begin
    if (ns == ST_MAXPOOL) begin
      unique case (ST_MAXPOOL_cnt)
        2'd0:    caddr_rd <= {row, col};
        2'd1:    caddr_rd <= {row, col + 1'b1};
        2'd2:    caddr_rd <= {row + 1'b1, col};
        2'd3:    caddr_rd <= {row + 1'b1, col + 1'b1};
        default: caddr_rd <= caddr_rd;
      endcase
    end
  end

  // ===========================================
  // MAXPOOL
  // ===========================================
  always_ff @(posedge clk) begin
    if (cs == ST_MAXPOOL) begin
      unique case (ST_MAXPOOL_cnt_r)
        2'd0:    maxpool_res <= cdata_rd;
        2'd1:    maxpool_res <= (cdata_rd > maxpool_res) ? cdata_rd : maxpool_res;
        2'd2:    maxpool_res <= (cdata_rd > maxpool_res) ? cdata_rd : maxpool_res;
        2'd3:    maxpool_res <= (cdata_rd > maxpool_res) ? cdata_rd : maxpool_res;
        default: maxpool_res <= maxpool_res;
      endcase
    end
  end


  // ===========================================
  // FSM
  // ===========================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) cs <= ST_IDLE;
    else cs <= ns;
  end

  // next state logic
  always_comb begin
    case (cs)
      ST_IDLE:          ns = (ready) ? ST_CONV : ST_IDLE;
      ST_CONV:          ns = (ST_CONV_cnt_r == 4'd10) ? ST_WR_MEM_L0 : ST_CONV;
      ST_WR_MEM_L0:     ns = ST_CHECK_CONV;
      ST_CHECK_CONV:    ns = (row == 0 && col == 0) ? ST_MAXPOOL : ST_CONV;
      ST_MAXPOOL:       ns = (ST_MAXPOOL_cnt == 4) ? ST_WR_MEM_L1 : ST_MAXPOOL;
      ST_WR_MEM_L1:     ns = ST_CHECK_MAXPOOL;
      ST_CHECK_MAXPOOL: ns = (row == 0 && col == 0) ? ST_DONE : ST_MAXPOOL;
      default:          ns = ST_IDLE;
    endcase

  end

  // output logic
  assign busy = (cs != ST_IDLE);

endmodule




