module pp_compressor42 (
  input  [15:0] pp_in0,
  input  [15:0] pp_in1,
  input  [15:0] pp_in2,
  input  [15:0] pp_in3,
  output [15:0] carry_out,
  output [15:0] sum_out
);

  // Internal wires for carry and sum results
  wire [15:0] carry_comb;
  wire [15:0] sum_comb;
  wire [15:0] carry_temp;
  wire [16:0] carry_chain;

  // Initialize LSB carry-in to 0
  assign carry_chain = {carry_temp, 1'b0};

  // Generate 16 instances of 4:2 compressor
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_compressors
      compress42 u_compressor (
        .in1 (pp_in0[i]),
        .in2 (pp_in1[i]),
        .in3 (pp_in2[i]),
        .in4 (pp_in3[i]),
        .Cin (carry_chain[i]),
        .cout(carry_chain[i+1]),
        .C   (carry_comb[i]),
        .S   (sum_comb[i])
      );
    end
  endgenerate

  // Assign final outputs
  assign sum_out   = sum_comb;
  assign carry_out = carry_comb << 1;  // Shift left to align carry bits,
                                       // At this point, carry_out[15] will have no value,
                                       // so the MSB can be directly truncated.

endmodule
