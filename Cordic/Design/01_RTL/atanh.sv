//tana:  17=1+8+8
//atany: 11=1+1+10
// fixed point: Q1.15
// TODO when cnt = 4 iteration more once
// TODO tt replaced with a tanh LUT
// TODO iteration formula update for hyperbolic rotation
// TODO


module atanh (
  input                    clk,
  input                    rstn,
  input                    trig,
  input  signed     [8:0] tanha,
  output logic               vld,
  output logic signed [8:0] a2_latch
);

  //-----------------------------------------
  logic        [ 4:0] cnt;
  logic               vld_pre;
  logic        [19:0] tt;
  logic signed [26:0] tmp1;
  logic        [26:0] tmp2;

  logic        [26:0] x;
  logic signed [26:0] tanha2;
  logic signed [20:0] a;

  logic signed [ 9:0] a2_tmp;
  logic signed [ 8:0] a2;


  // control  -----------------------------------------
  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) cnt <= 5'd0;
    else begin
      if (trig) cnt <= 5'd1;
      // The number of iterations is 19,
      // but it is written as 21 because the 4th, 13th iteration requires one extra cycle.
      else if (cnt == 5'd21) cnt <= 5'd0;
      else if (cnt > 5'd0) cnt <= cnt + 5'd1;
    end
  end


  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) vld_pre <= 1'b0;
    else vld_pre <= (cnt == 5'd21);
  end


  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) vld <= 1'b0;
    else vld <= vld_pre;
  end



  //data -----------------------------------------
  always_comb begin
    case (cnt)
      5'd00:   tt = 20'd0;  // cnt=0
      5'd01:   tt = 20'd366686;  // itr 1
      5'd02:   tt = 20'd170499;  // itr 2
      5'd03:   tt = 20'd83882;  // itr 3
      5'd04:   tt = 20'd41776;  // itr 4
      5'd05:   tt = 20'd41776;  // itr 4 repeat
      5'd06:   tt = 20'd20868;  // itr 5
      5'd07:   tt = 20'd10431;  // itr 6
      5'd08:   tt = 20'd5215;  // itr 7
      5'd09:   tt = 20'd2608;  // itr 8
      5'd10:   tt = 20'd1304;  // itr 9
      5'd11:   tt = 20'd652;  // itr 10
      5'd12:   tt = 20'd326;  // itr 11
      5'd13:   tt = 20'd163;  // itr 12
      5'd14:   tt = 20'd81;  // itr 13
      5'd15:   tt = 20'd81;  // itr 13 repeat
      5'd16:   tt = 20'd41;  // itr 14
      5'd17:   tt = 20'd20;  // itr 15
      5'd18:   tt = 20'd10;  // itr 16
      5'd19:   tt = 20'd5;  // itr 17
      5'd20:   tt = 20'd3;  // itr 18
      5'd21:   tt = 20'd1;  // itr 19
      default: tt = 20'd0;
    endcase
  end


  always_comb begin
    case (cnt)
      5'd00:   tmp1 = 27'd0;  // cnt=0
      5'd01:   tmp1 = tanha2 >>> 1;  // itr 1
      5'd02:   tmp1 = tanha2 >>> 2;  // itr 2
      5'd03:   tmp1 = tanha2 >>> 3;  // itr 3
      5'd04:   tmp1 = tanha2 >>> 4;  // itr 4
      5'd05:   tmp1 = tanha2 >>> 4;  // itr 4 repeat
      5'd06:   tmp1 = tanha2 >>> 5;  // itr 5
      5'd07:   tmp1 = tanha2 >>> 6;  // itr 6
      5'd08:   tmp1 = tanha2 >>> 7;  // itr 7
      5'd09:   tmp1 = tanha2 >>> 8;  // itr 8
      5'd10:   tmp1 = tanha2 >>> 9;  // itr 9
      5'd11:   tmp1 = tanha2 >>> 10;  // itr 10
      5'd12:   tmp1 = tanha2 >>> 11;  // itr 11
      5'd13:   tmp1 = tanha2 >>> 12;  // itr 12
      5'd14:   tmp1 = tanha2 >>> 13;  // itr 13
      5'd15:   tmp1 = tanha2 >>> 13;  // itr 13 repeat
      5'd16:   tmp1 = tanha2 >>> 14;  // itr 14
      5'd17:   tmp1 = tanha2 >>> 15;  // itr 15
      5'd18:   tmp1 = tanha2 >>> 16;  // itr 16
      5'd19:   tmp1 = tanha2 >>> 17;  // itr 17
      5'd20:   tmp1 = tanha2 >>> 18;  // itr 18
      5'd21:   tmp1 = tanha2 >>> 19;  // itr 19
      default: tmp1 = 27'd0;
    endcase
  end

  always_comb begin
    case (cnt)
      5'd00:   tmp2 = 27'd0;  // cnt=0
      5'd01:   tmp2 = x >> 1;  // itr 1
      5'd02:   tmp2 = x >> 2;  // itr 2
      5'd03:   tmp2 = x >> 3;  // itr 3
      5'd04:   tmp2 = x >> 4;  // itr 4
      5'd05:   tmp2 = x >> 4;  // itr 4 repeat
      5'd06:   tmp2 = x >> 5;  // itr 5
      5'd07:   tmp2 = x >> 6;  // itr 6
      5'd08:   tmp2 = x >> 7;  // itr 7
      5'd09:   tmp2 = x >> 8;  // itr 8
      5'd10:   tmp2 = x >> 9;  // itr 9
      5'd11:   tmp2 = x >> 10;  // itr 10
      5'd12:   tmp2 = x >> 11;  // itr 11
      5'd13:   tmp2 = x >> 12;  // itr 12
      5'd14:   tmp2 = x >> 13;  // itr 13
      5'd15:   tmp2 = x >> 13;  // itr 13 repeat
      5'd16:   tmp2 = x >> 14;  // itr 14
      5'd17:   tmp2 = x >> 15;  // itr 15
      5'd18:   tmp2 = x >> 16;  // itr 16
      5'd19:   tmp2 = x >> 17;  // itr 17
      5'd20:   tmp2 = x >> 18;  // itr 18
      5'd21:   tmp2 = x >> 19;  // itr 19
      default: tmp2 = 27'd0;
    endcase
  end




  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      x      <= 27'd0;
      tanha2 <= 27'd0;
      a      <= 21'd0;
    end else begin
      if (cnt == 5'd0) begin
        x      <= 27'd262144;
        tanha2 <= tanha <<< 10;
        a      <= 21'd0;
      end else begin
        if (!tanha2[26]) begin
          x      <= signed'({1'b0, x}) - tmp1;
          tanha2 <= tanha2 - signed'({1'b0, tmp2});
          a      <= a + signed'({1'b0, tt});
        end else begin
          x      <= signed'({1'b0, x}) + tmp1;
          tanha2 <= tanha2 + signed'({1'b0, tmp2});
          a      <= a - signed'({1'b0, tt});
        end
      end
    end
  end


  // assign a2_tmp = (a >>> 11) + signed'(10'd1);
  // assign a2     = a2_tmp >>> 1;
  assign a2 = a >>> 12;


  always @(posedge clk or negedge rstn) begin
    if (!rstn) a2_latch <= 9'd0;
    else if (vld_pre) a2_latch <= a2;
  end


endmodule


