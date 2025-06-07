if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name lib_min\
   -timing\
    [list ${::IMEX::libVar}/mmmc/UDVS_u018mmbc198v.lib]
create_library_set -name lib_max\
   -timing\
    [list ${::IMEX::libVar}/mmmc/UDVS_u018mmwc162v.lib]
create_op_cond -name WC1D62VCOM -library_file ${::IMEX::libVar}/mmmc/UDVS_u018mmwc162v.lib -P 1 -V 1.62 -T 125
create_op_cond -name BC1D98VCOM -library_file ${::IMEX::libVar}/mmmc/UDVS_u018mmbc198v.lib -P 1 -V 1.98 -T -40
create_rc_corner -name RC_best\
   -cap_table ${::IMEX::libVar}/mmmc/u18_ITRI.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC_best/icecaps.tch
create_rc_corner -name RC_worst\
   -cap_table ${::IMEX::libVar}/mmmc/u18_ITRI.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC_best/icecaps.tch
create_delay_corner -name DC_min\
   -library_set lib_min\
   -rc_corner RC_best
create_delay_corner -name DC_max\
   -library_set lib_max\
   -rc_corner RC_worst
create_constraint_mode -name CM_ideal\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/CONV_syn.sdc]
create_constraint_mode -name CM_ideal_cts\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/CONV_syn_cts.sdc]
create_analysis_view -name AV_func_max -constraint_mode CM_ideal -delay_corner DC_max
create_analysis_view -name AV_scan_min -constraint_mode CM_ideal_cts -delay_corner DC_min
create_analysis_view -name AV_scan_max -constraint_mode CM_ideal_cts -delay_corner DC_max
create_analysis_view -name AV_func_min -constraint_mode CM_ideal -delay_corner DC_min
set_analysis_view -setup [list AV_func_max AV_scan_max] -hold [list AV_func_min AV_scan_min]
