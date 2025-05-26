module booth_pp_gen (
  input  [ 7:0] multiplicand,  // 8-bit multiplicand
  input  [ 3:0] double_X,      // Booth encoding group signals
  input  [ 3:0] invert_X,      // Inversion control bits
  input  [ 3:0] zero_X,        // Zeroing control bits
  output [15:0] pp0,           // 4 partial products (aligned to 16 bits)
  output [15:0] pp1,
  output [15:0] pp2,
  output [15:0] pp3,
  output [15:0] sign_comp      // Sign compensation term
);

  wire [7+1:0] pp_x2  [4];
  wire [7+1:0] pp_set [4];
  wire [7+1:0] pp [4];

  wire [  3:0] E_inv;
  wire [  3:0] E;
  wire [ 15:0] pp_sext[4]; // partial products with sign extension

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : gen_pp
      // 1. Booth operation: choose multiplicand or 0
      assign pp_x2[i] = (double_X[i]) ? {multiplicand, 1'b0} : {multiplicand[7], multiplicand};

      // 2. Optional zeroing
      assign pp_set[i] = (zero_X[i]) ? 9'b0 : pp_x2[i];

      // 3. Booth negation (2's complement)
      assign pp[i] = (invert_X[i]) ? ~pp_set[i] : pp_set[i];

      // 4. Sign extension logic
      assign E_inv[i] = (zero_X[i]) ? invert_X[i] : invert_X[i] ^ multiplicand[7];
      assign E[i] = ~E_inv[i];


      // 5. Final temp partial product
      assign pp_sext[i] = (i == 0) ? { {4{1'b0}}, E[0], E_inv[0], E_inv[0], pp[0]} :
                                    { {5{1'b0}}, 1'b1, E[i], pp[i]};
    end
  endgenerate

  // 6. Shifted and aligned partial products
  assign pp0       = pp_sext[0];
  assign pp1       = {pp_sext[1][13:0], 1'b0, invert_X[0]};
  assign pp2       = {pp_sext[2][11:0], 1'b0, invert_X[1], {2{1'b0}}};
  assign pp3       = {pp_sext[3][9:0], 1'b0, invert_X[2], {4{1'b0}}};

  // 7. Sign compensation
  assign sign_comp = {{9{1'b0}}, invert_X[3], {6{1'b0}}};

endmodule
