module BoothEncoder (
  input  [7:0] Y,         // Multiplicand
  output [3:0] double_X,
  output [3:0] invert_X,
  output [3:0] zero_X
);

  wire [8:0] Y_extend;
  wire [2:0] bits_sel [4];

  assign Y_extend = {Y, 1'b0};

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : gen_bits_select
      assign bits_sel[i] = Y_extend[2*i+2:2*i];
    end
  endgenerate

  genvar j;
  generate
    for (j = 0; j < 4; j = j + 1) begin : gen_control
      assign zero_X[j]   = &bits_sel[j] | &(~bits_sel[j]);  // 111 or 000 => 0
      assign invert_X[j] = bits_sel[j][2];  // 0 => postive X, 1 => negative X
      assign double_X[j] = ~(bits_sel[j][0] ^ bits_sel[j][1]);  // 01 or 10 => 2X
    end
  endgenerate



endmodule
