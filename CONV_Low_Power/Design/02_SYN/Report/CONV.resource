 
****************************************
Report : resources
Design : CONV
Version: T-2022.03-SP2
Date   : Mon May 19 12:03:50 2025
****************************************


Resource Report for this hierarchy in file
        /home/host/Documents/CGU-EE006-APR/w13_Final/Design/01_RTL/CONV.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_3        | DW01_add       | width=6    | add_111 (CONV.sv:111)      |
| add_x_4        | DW01_add       | width=6    | add_112_aco (CONV.sv:112)  |
| add_x_12       | DW01_inc       | width=4    | add_144_S2 (CONV.sv:144)   |
| add_x_26       | DW01_inc       | width=20   | add_241 (CONV.sv:241)      |
| add_x_30       | DW01_inc       | width=3    | add_261_S2 (CONV.sv:261)   |
| gt_x_40        | DW_cmp         | width=20   | gt_293 (CONV.sv:293)       |
|                |                |            | gt_294 (CONV.sv:294)       |
|                |                |            | gt_295 (CONV.sv:295)       |
| add_x_1        | DW01_inc       | width=6    | add_108 (CONV.sv:108)      |
|                |                |            | add_127 (CONV.sv:127)      |
|                |                |            | add_130 (CONV.sv:130)      |
|                |                |            | add_133_2 (CONV.sv:133)    |
|                |                |            | add_278 (CONV.sv:278)      |
|                |                |            | add_280_2 (CONV.sv:280)    |
| add_x_2        | DW01_inc       | width=6    | add_109 (CONV.sv:109)      |
|                |                |            | add_131 (CONV.sv:131)      |
|                |                |            | add_132 (CONV.sv:132)      |
|                |                |            | add_133 (CONV.sv:133)      |
|                |                |            | add_279 (CONV.sv:279)      |
|                |                |            | add_280 (CONV.sv:280)      |
| sub_x_9        | DW01_dec       | width=6    | sub_125 (CONV.sv:125)      |
|                |                |            | sub_126 (CONV.sv:126)      |
|                |                |            | sub_127 (CONV.sv:127)      |
| sub_x_10       | DW01_dec       | width=6    | sub_125_2 (CONV.sv:125)    |
|                |                |            | sub_128 (CONV.sv:128)      |
|                |                |            | sub_131 (CONV.sv:131)      |
| DP_OP_104_126_5096              |            |                            |
|                | DP_OP_104_126_5096 |        |                            |
| DP_OP_105_127_3513              |            |                            |
|                | DP_OP_105_127_3513 |        |                            |
=============================================================================

Datapath Report for DP_OP_104_126_5096
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_104_126_5096   | add_203_S2 (CONV.sv:203)                            |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 40    |                                          |
| O1    | PO   | Unsigned | 40    | I1 + $unsigned(29'b10011000100000000000000000000) (CONV.sv:203) |
==============================================================================

Datapath Report for DP_OP_105_127_3513
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_105_127_3513   | mult_197 (CONV.sv:197) add_204 (CONV.sv:204)        |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 20    |                                          |
| I2    | PI   | Signed   | 20    |                                          |
| I3    | PI   | Signed   | 40    |                                          |
| T31   | IFO  | Signed   | 40    | I1 * I2 (CONV.sv:197)                    |
| O1    | PO   | Unsigned | 40    | I3 + T31 (CONV.sv:204)                   |
==============================================================================


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_3            | DW01_add         | apparch (area)     |                |
| add_x_4            | DW01_add         | apparch (area)     |                |
| add_x_12           | DW01_inc         | apparch (area)     |                |
| add_x_26           | DW01_inc         | apparch (area)     |                |
| add_x_30           | DW01_inc         | apparch (area)     |                |
| gt_x_40            | DW_cmp           | apparch (area)     |                |
| add_x_1            | DW01_inc         | apparch (area)     |                |
| add_x_2            | DW01_inc         | apparch (area)     |                |
| sub_x_9            | DW01_dec         | apparch (area)     |                |
| sub_x_10           | DW01_dec         | apparch (area)     |                |
| DP_OP_104_126_5096 | DP_OP_104_126_5096 | str (area)       |                |
| DP_OP_105_127_3513 | DP_OP_105_127_3513 | str (area,speed) |                |
|                    |                  | mult_arch: benc_radix4              |
===============================================================================

1
