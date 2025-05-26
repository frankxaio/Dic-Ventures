// -----------------------------------------------------------------------
// (C) COPYRIGHT 2023 in ELE, CGU.
// ALL RIGHTS RESVERVED.
// -----------------------------------------------------------------------
// Course:     Digital Integrated Cirucit Design
// Homework:   HW4-SMUL_8x8
// File:       HW4_SMUL_8x8_rtl.v
// Author:     Chih-Feng Wu
// E-mail:     tfengwu@mail.cgu.edu.tw
// TEL:        03-2118800 #3790
// Date:       5/13/2023
// Abstract:   Booth Multiplier Design: Signed 8x8 Multiplier
// -----------------------------------------------------------------------

`timescale 1 ns / 1ps
`define DLY #1
`define PWL 16
`define MWL 8

module BoothMUL (
  output [  `PWL:0] P,  // Product (17-bit output)
  input  signed [`MWL-1:0] X,  // Multiplicand
  input  signed [`MWL-1:0] Y   // Multiplier
);

  assign P = X * Y;

endmodule
