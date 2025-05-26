module cla_16 (
  input  [15:0] A,
  input  [15:0] B,
  input         Cin,
  output [15:0] Sum,
  output        Cout
);

  wire [3:0] C;  // Carry between blocks
  wire [3:0] G, P;  // Group generate/propagate from 4-bit CLA blocks

  // Block carry generation
  assign C[0] = Cin;
  assign C[1] = G[0] | (P[0] & C[0]);
  assign C[2] = G[1] | (P[1] & C[1]);
  assign C[3] = G[2] | (P[2] & C[2]);
  assign Cout = G[3] | (P[3] & C[3]);

  // Instantiate four 4-bit CLA blocks
  cla_4 cla0 (
    .A    (A[3:0]),
    .B    (B[3:0]),
    .Cin  (C[0]),
    .Sum  (Sum[3:0]),
    .Cout (),
    .G_out(G[0]),
    .P_out(P[0])
  );
  cla_4 cla1 (
    .A    (A[7:4]),
    .B    (B[7:4]),
    .Cin  (C[1]),
    .Sum  (Sum[7:4]),
    .Cout (),
    .G_out(G[1]),
    .P_out(P[1])
  );
  cla_4 cla2 (
    .A    (A[11:8]),
    .B    (B[11:8]),
    .Cin  (C[2]),
    .Sum  (Sum[11:8]),
    .Cout (),
    .G_out(G[2]),
    .P_out(P[2])
  );
  cla_4 cla3 (
    .A    (A[15:12]),
    .B    (B[15:12]),
    .Cin  (C[3]),
    .Sum  (Sum[15:12]),
    .Cout (),
    .G_out(G[3]),
    .P_out(P[3])
  );

endmodule

module cla_4 (
  input  [3:0] A,
  input  [3:0] B,
  input        Cin,
  output [3:0] Sum,
  output       Cout,
  output       G_out,
  output       P_out   // Group Generate and Propagate
);

  wire [3:0] G, P;  // Bitwise generate and propagate
  wire [3:0] C;  // Internal carry

  assign G     = A & B;
  assign P     = A ^ B;

  assign C[0]  = Cin;
  assign C[1]  = G[0] | (P[0] & C[0]);
  assign C[2]  = G[1] | (P[1] & C[1]);
  assign C[3]  = G[2] | (P[2] & C[2]);
  assign Cout  = G[3] | (P[3] & C[3]);

  assign Sum   = P ^ C;

  // Group generate and propagate for hierarchical CLA
  assign G_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
  assign P_out = P[3] & P[2] & P[1] & P[0];

endmodule

