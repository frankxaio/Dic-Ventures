 
****************************************
Report : resources
Design : CONV
Version: T-2022.03-SP2
Date   : Wed Jun  4 00:43:34 2025
****************************************


Resource Report for this hierarchy in file
        /home/host/Documents/DIC-Ventures/CONV_Low_Power/Design/01_RTL/CONV.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_3        | DW01_add       | width=6    | add_111 (CONV.sv:111)      |
| add_x_4        | DW01_add       | width=6    | add_112_aco (CONV.sv:112)  |
| add_x_12       | DW01_inc       | width=4    | add_144_S2 (CONV.sv:144)   |
| add_x_26       | DW01_inc       | width=20   | add_240 (CONV.sv:240)      |
| add_x_30       | DW01_inc       | width=3    | add_260_S2 (CONV.sv:260)   |
| gt_x_40        | DW_cmp         | width=20   | gt_292 (CONV.sv:292)       |
|                |                |            | gt_293 (CONV.sv:293)       |
|                |                |            | gt_294 (CONV.sv:294)       |
| add_x_1        | DW01_inc       | width=6    | add_108 (CONV.sv:108)      |
|                |                |            | add_127 (CONV.sv:127)      |
|                |                |            | add_130 (CONV.sv:130)      |
|                |                |            | add_133_2 (CONV.sv:133)    |
|                |                |            | add_277 (CONV.sv:277)      |
|                |                |            | add_279_2 (CONV.sv:279)    |
| add_x_2        | DW01_inc       | width=6    | add_109 (CONV.sv:109)      |
|                |                |            | add_131 (CONV.sv:131)      |
|                |                |            | add_132 (CONV.sv:132)      |
|                |                |            | add_133 (CONV.sv:133)      |
|                |                |            | add_278 (CONV.sv:278)      |
|                |                |            | add_279 (CONV.sv:279)      |
| sub_x_9        | DW01_dec       | width=6    | sub_125 (CONV.sv:125)      |
|                |                |            | sub_126 (CONV.sv:126)      |
|                |                |            | sub_127 (CONV.sv:127)      |
| sub_x_10       | DW01_dec       | width=6    | sub_125_2 (CONV.sv:125)    |
|                |                |            | sub_128 (CONV.sv:128)      |
|                |                |            | sub_131 (CONV.sv:131)      |
| DP_OP_110_122_9292              |            |                            |
|                | DP_OP_110_122_9292 |        |                            |
=============================================================================

Datapath Report for DP_OP_110_122_9292
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_110_122_9292   | mult_197 (CONV.sv:197) C1672 (CONV.sv:201)          |
|                      | add_202_S2 (CONV.sv:202) add_203 (CONV.sv:203)      |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 20    |                                          |
| I2    | PI   | Signed   | 20    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 40    |                                          |
| T31   | IFO  | Signed   | 40    | I1 * I2 (CONV.sv:197)                    |
| T106  | IFO  | Unsigned | 40    | { I3, I4 } ? $unsigned(29'b10011000100000000000000000000) : T31 (CONV.sv:201) |
| O1    | PO   | Unsigned | 40    | I5 + T106 ( CONV.sv:202 CONV.sv:203 )    |
==============================================================================


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_26           | DW01_inc         | apparch (area)     |                |
| add_x_3            | DW01_add         | apparch (area)     |                |
| add_x_4            | DW01_add         | apparch (area)     |                |
| add_x_12           | DW01_inc         | apparch (area)     |                |
| add_x_30           | DW01_inc         | apparch (area)     |                |
| add_x_1            | DW01_inc         | apparch (area)     |                |
| add_x_2            | DW01_inc         | apparch (area)     |                |
| sub_x_9            | DW01_dec         | apparch (area)     |                |
| sub_x_10           | DW01_dec         | apparch (area)     |                |
| DP_OP_110_122_9292 | DP_OP_110_122_9292 | str (area)       |                |
|                    |                  | mult_arch: benc_radix4              |
===============================================================================


No resource sharing information to report.
 
****************************************
Design : CONV_DW_cmp_0
****************************************

No implementations to report
1
