//            in1  in2  in3  in4
//             |    |    |    |
//             v    v    v    v
//           +-------------------+
//           |                   |
//  cout <-- |   4_2 compressor  | <-- Cin
//           |                   |
//           +-------------------+
//                 |      |
//                 |      |
//                 v      v
//                 C      S
// ================================================================
//            in1   in2   in3
//             |     |     |
//             v     v     v
//           +---------------+
//  cout <-  |      FA       |
//           +---------------+
//                      |
//                      |
//                   sum_tmp   in4    ----- Cin
//                      |       |     |
//                      v       v     v
//                     +---------------+
//                     |      FA       |   <-- Second Full Adder
//                     +---------------+
//                        |         |
//                        v         v
//                        C         S

module compress42 (
  input  in1,
  input  in2,
  input  in3,
  input  in4,
  input  Cin,
  output S,
  output C,
  output cout
);

  wire sum_tmp;

  // First Full Adder: adds in1, in2, in3 -> outputs cout and intermediate sum
  FA FA_0 (
    .Co(cout),     // Carry-out of the first FA
    .S (sum_tmp),  // Intermediate sum
    .X (in1),
    .Y (in2),
    .Ci(in3)
  );

  // Second Full Adder: adds sum_tmp, in4, Cin -> outputs C and S
  FA FA_1 (
    .Co(C),        // Final carry output
    .S (S),        // Final sum output
    .X (sum_tmp),
    .Y (in4),
    .Ci(Cin)
  );

endmodule
