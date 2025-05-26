// -----------------------------------------------------------------------
// (C) COPYRIGHT 2023 in ELE, CGU.
// ALL RIGHTS RESVERVED.
// -----------------------------------------------------------------------
// Course:     Digital Integrated Cirucit Design
// Homework:   HW4
// File:       HW4_SMUL_8x8_rtb.v
// Author:     Chih-Feng Wu
// E-mail:     tfengwu@mail.cgu.edu.tw
// TEL:        03-2118800 #3790
// Date:       3/14/2023
// Abstract:   Booth Multiplier Design: Signed 8x8 Multiplier
// -----------------------------------------------------------------------

`timescale 1ns / 1ps

`define DLY #1
`define PWL 16
`define MWL 8
`define SDFFILE "../02_SYN/Netlist/BoothMUL_syn.sdf"

module BoothMUL_tb;

  // I/O signals
  wire signed [`PWL:0] P;
  reg signed [`MWL-1:0] X, Y;
  reg signed [`PWL:0] TRUE_OUT;
  // Integer variables
  integer i, j, outfile, PAT_ERROR;


  BoothMUL DUT (
    .P(P),  // Product
    .X(X),  // Multiplicand
    .Y(Y)
  );

  `ifdef GATE
    initial $sdf_annotate(`SDFFILE, DUT);
  `endif

  // Dump fsdb file
  initial begin
    $fsdbDumpfile("BoothMUL.fsdb");
    $fsdbDumpvars(0, "+mda");
  end

  // Input pattern assignment and open file for writing error message
  initial begin

    outfile = $fopen("../01_RTL/SIM_OUT.txt");
    if (!outfile) begin
      $display("The output can NOT be opened. !!!");
      $finish;
    end
  end

  initial begin
    // Initial the related variables (int) and signals (reg and wire)
    #0 PAT_ERROR = 0;
    i        = 0;
    j        = 0;
    TRUE_OUT = 0;
    X        = (`MWL'hFF);  // `WL'hFF; -1
    Y        = (`MWL'h56);  // `WL'h56; 86

    // Testing
    #40 X = (`MWL'hFF);  // -1
    Y = (`MWL'hFF);  // -1
    #40 X = (`MWL'hFF);  // -1
    Y = (`MWL'h00);  // 0
    #40 X = (`MWL'h00);  // 0
    Y = (`MWL'hFF);  // -1
    #40 X = (`MWL'h7F);  // 127
    Y = (`MWL'h01);  // 1
    #40 X = (`MWL'h01);  // 1
    Y = (`MWL'h7F);  // 127
    #40 X = (`MWL'h7F);  // 127
    Y = (`MWL'h7F);  // 127
    #40 X = (`MWL'h80);  // -128
    Y = (`MWL'h80);  // -128
    #40 X = (`MWL'h80);  // -128
    Y = (`MWL'h7F);  //  127
    #40 X = (`MWL'h7F);  //  127
    Y = (`MWL'h80);  // -128
    #40 X = (`MWL'h01);  //   1
    Y = (`MWL'hFF);  //  -1
    #40 X = (`MWL'hFF);  //  -1
    Y = (`MWL'h01);  //   1

    // All patterns testing
    for (i = -128; i <= 127; i = i + 1) begin
      X = i;
      for (j = -128; j <= 127; j = j + 1) begin
        Y = j;
        #39 TRUE_OUT = X * Y;
        #1
        if (P[15:0] !== TRUE_OUT[15:0]) begin
          PAT_ERROR = PAT_ERROR + 1;
        end
      end
    end

    #20
    if (!PAT_ERROR) $display("\n // Congratulations!! Your Verilog Code is correct!!\n");
    else
      $display(
          "\n // Your Verilog Code has %d errors. \nPlease read SIM_OUT.txt for details.\n",
          PAT_ERROR
      );

    $fclose(outfile);
    #20 $finish;

  end  // initial

endmodule
