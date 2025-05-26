if {[info exists env(ROOT_PATH)]} {
    puts "ROOT_PATH is: $env(ROOT_PATH)"
    set ROOT_PATH $env(ROOT_PATH)
} else {
    puts "ROOT_PATH is not set"
}

# Create a new project
# project_new lint_proj -force
# set_option top_module booth_mul         ;# Replace with your actual top module
set_app_var enable_lint true
set_option enableSV yes                 ;# Enable SystemVerilog
set_option language_mode mixed             ;# Optional: treat as SystemVerilog


# current_methodology $env(VC_STATIC_HOME)/auxx/monet/tcl/GuideWare/block/rtl_handoff/lint
# current_goal lint_rtl.tcl

analyze -format sverilog -vcs “-f $ROOT_PATH/00_TESTBED/rtl_sim.f”
elaborate boothMUL
check_lint
report_lint
exit -force
