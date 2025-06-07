source .synopsys_pt.setup

set ROOT_PATH $::env(ROOT_PATH)

# Front-end DC's netlist and WLM
# Back-end Layout's netlist and spef file
set power_enable_analysis TRUE
set power_analysis_mode time_based
set DESIGN "CONV"


echo $DESIGN
read_file -format verilog $ROOT_PATH/02_SYN/Netlist/${DESIGN}_syn.v

current_design $DESIGN
link


# Gate-level
read_sdc $ROOT_PATH/02_SYN/Netlist/${DESIGN}_syn.sdc

# PnR
# read_sdc -load_delay net $ROOT_PATH/verification/pr_sim/LBP_pr.sdf

# read_parasitics -format SPEF -verbose CHIP.spef

# report_timing

## Measure power

read_vcd -strip_path testfixture/u_CONV $ROOT_PATH/03_GATE/${DESIGN}.vcd

# set_input_transition 0.1 [all_input]

# report_switching_activity -list_not_annotated -show_pin

# Check Power
check_power
set_power_analysis_options -waveform_format fsdb -waveform_output power
# set_power_analysis_options -waveform_format fsdb -waveform_output power -waveform_interval 1
update_power

report_power -hierarchy > $DESIGN.power
report_power > $DESIGN.power_summary
report_power

exit
