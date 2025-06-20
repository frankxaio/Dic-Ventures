`define CYCLE 50
`define SDFFILE "../02_SYN/Netlist/ATANH_syn.sdf"

// TODO test vector
// TODO


module atanh_tb;


  //-------------------------------------------
  int                fsdbDump;

  //clk / rstn
  logic              clk;
  logic              rstn;

  int                ii;

  logic              trig;
  wire               vld;

  real               tanha;
  reg signed  [8:0] tana_fix;
  wire signed [8:0] a_fix;
  real               a;
  real               a_real;

  real               delt;
  real               delt_a;

  real               err;
  real               max_err;



  //-------------------------------------------
  initial begin
    $fsdbDumpfile("ATNAH.fsdb");
    $fsdbDumpvars(0);
  end


  //-----------------------------------------------------------
  initial begin
    clk = 1'b0;
    forever begin
      #(`CYCLE / 2) clk = ~clk;
    end
  end


  initial begin
    rstn = 0;
    #30 rstn = 1;
  end


  initial begin
    delt     = 0.00390625;  // 1/2^8
    // delt     = 2.441406250000000e-04;  // 1/2^12
    delt_a   = 0.006135923151543;
    tanha    = -1;
    tana_fix = int'(tanha / delt);
    trig     = 0;
    a        = 0;
    err      = 0;
    max_err  = 0;

    @(posedge rstn);
    #30;

    while (tanha < 1) begin
      tana_fix = int'(tanha / delt);
      a_real   = $atanh(tanha);  //  The user is unsure whether SystemVerilog has a tanha

      @(posedge clk);
      trig <= 1;

      fork
        begin
          @(posedge clk);
          trig <= 0;
        end

        begin
          @(negedge vld);
          a = a_fix * delt_a;
          err <= $abs(a_real - a);

          #1;
          if (err > max_err) max_err = err;
        end
      join

      tanha = tanha + delt;
    end

    #100;
    $finish;
  end



  //------------------------------------------------------------
  atanh u_atanh (
    .clk (clk),  //i
    .rstn(rstn), //i

    .trig(trig),  //i
    .vld (vld),   //o

    .tanha   (tana_fix),  //i[16:0]
    .a2_latch(a_fix)      //o[8:0]
  );



endmodule
