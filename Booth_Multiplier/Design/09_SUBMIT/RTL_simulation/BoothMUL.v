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
  output [`PWL-1:0] P,  // Product (17-bit output)
  input  [`MWL-1:0] X,  // Multiplicand
  input  [`MWL-1:0] Y   // Multiplier
);

  // Internal signals
  wire [3:0] double_X;
  wire [3:0] invert_X;
  wire [3:0] zero_X;

  wire [15:0] pp0, pp1, pp2, pp3;
  wire [15:0] sign_comp;  // Sign compensation term

  wire [15:0] carry_out;
  wire [15:0] sum_out;

  wire [15:0] sum_out32;
  wire [15:0] carry_out32;

  // Step 1: Booth Encoding
  BoothEncoder u_BoothEncoder (
    .Y       (Y),
    .double_X(double_X),
    .invert_X(invert_X),
    .zero_X  (zero_X)
  );


  // Step 2: Generate partial products
  booth_pp_gen u_booth_pp_gen (
    .pp0         (pp0),
    .pp1         (pp1),
    .pp2         (pp2),
    .pp3         (pp3),
    .sign_comp   (sign_comp),
    .multiplicand(X),
    .double_X    (double_X),
    .invert_X    (invert_X),
    .zero_X      (zero_X)
  );

  // Step 3: Compress partial products
  pp_compressor42 u_pp_compressor42 (
    .pp_in0   (pp0),
    .pp_in1   (pp1),
    .pp_in2   (pp2),
    .pp_in3   (pp3),
    .carry_out(carry_out),
    .sum_out  (sum_out)
  );

  // Step 4
  pp_compressor32 u_pp_compressor32 (
    .carry_out(carry_out32),
    .sum_out  (sum_out32),
    .pp_in0   (sum_out),
    .pp_in1   (carry_out),
    .pp_in2   (sign_comp)
  );

  cla_16 u_cla_16 (
    .A   (sum_out32),
    .B   (carry_out32),
    .Cin (1'b0),
    .Sum (P[15:0]),
    .Cout()
  );

endmodule
