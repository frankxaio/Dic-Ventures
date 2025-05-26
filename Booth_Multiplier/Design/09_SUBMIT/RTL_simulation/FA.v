// -----------------------------------------------------------------------
// (C) COPYRIGHT 2023 in ELE, CGU.
// ALL RIGHTS RESVERVED.
// -----------------------------------------------------------------------
// Course:     Digital Integrated Cirucit Design
// Homework:   HW4-FA
// File:       HW3_FA_rtl.v
// Author:     Chih-Feng Wu
// E-mail:     tfengwu@mail.cgu.edu.tw
// TEL:        03-2118800 #3790
// Date:       5/13/2023
// Abstract:   Full-adder
// -----------------------------------------------------------------------

module FA (
  Co,  // Carry-out
  S,  // Sum
  X,
  Y,
  Ci
);  // carry-in

  // I/O signals
  output Co, S;  // Carry-out and Sum
  input X, Y, Ci;  // Inputs including X, Y and Carry-in
  wire Co, S;
  wire X, Y, Ci;
  // internal
  wire S0, C1, C2;

  HA U_HA1 (
    .Co(C1),
    .S (S0),
    .X (X),
    .Y (Y)
  );
  HA U_HA2 (
    .Co(C2),
    .S (S),
    .X (S0),
    .Y (Ci)
  );
  assign Co = (C1 | C2);

endmodule
