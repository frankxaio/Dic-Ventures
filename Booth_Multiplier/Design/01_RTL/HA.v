// -----------------------------------------------------------------------
// (C) COPYRIGHT 2023 in ELE, CGU.
// ALL RIGHTS RESVERVED.
// -----------------------------------------------------------------------
// Course:     Digital Integrated Cirucit Design
// Homework:   HW4-HA
// File:       HW3_HA_rtl.v
// Author:     Chih-Feng Wu
// E-mail:     tfengwu@mail.cgu.edu.tw
// TEL:        03-2118800 #3790
// Date:       5/13/2023
// Abstract:   Half-adder
// -----------------------------------------------------------------------


module HA (
  Co,  // Carry-out
  S,  // Sum
  X,
  Y
);

  // I/O signals
  output Co, S;  // Carry-out and Sum
  input X, Y;  // Inputs including X and Y

  assign Co = (X & Y);
  assign S  = (X ^ Y);

endmodule
