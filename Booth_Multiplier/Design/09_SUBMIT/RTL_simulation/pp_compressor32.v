module pp_compressor32 (
  output [15:0] carry_out,
  output [15:0] sum_out,
  input  [15:0] pp_in0,
  input  [15:0] pp_in1,
  input  [15:0] pp_in2
);
  // Internal wires for carry and sum results
  wire [15:0] carry_comb;
  wire [15:0] sum_comb;

  // Generate 16 instances of 4:2 compressor
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_compressors
      FA u_compressor (
        .X (pp_in0[i]),
        .Y (pp_in1[i]),
        .Ci(pp_in2[i]),
        .Co(carry_comb[i]),
        .S (sum_comb[i])
      );
    end
  endgenerate

  // Assign final outputs
  assign sum_out   = sum_comb;
  assign carry_out = carry_comb << 1;


endmodule
