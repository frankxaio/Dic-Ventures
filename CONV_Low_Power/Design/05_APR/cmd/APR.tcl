
# ==============================
# Initial Design  With Mode 180nm
# ==============================
setDesignMode -process 180
set restore_db_stop_at_design_in_memory 0

set init_lef_file {/cad/CBDK/CBDK_UMC018_ITRI_v0.8/CIC/SOCE/lef/UDVS_u018mm.lef /cad/CBDK/CBDK_UMC018_ITRI_v0.8/CIC/SOCE/lef/U018IOCUP.lef}
set init_gnd_net VSS
set init_pwr_net VDD
set init_verilog ./layout/netlist/LBP_syn_v1.v
set init_top_cell LBP
set init_mmmc_file ./layout/mmmc/mmmc.view
init_design

# ==============================
# Connnect Global Net
# ==============================
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename *
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename *

# ==============================
# Floorplan
# ==============================
# ratio, utilization, core to left side, core to right side, core to top side, core to bottom side
floorPlan  -r 1 0.65 20.0 20.0 20.0 20.0

# ==============================
# Add Ring
# ==============================
addRing -nets {VDD VSS} -follow core \
-layer {bottom ME4 top ME4 right ME3 left ME3} -width 3 -spacing 2 \
-use_wire_group 1 -use_wire_group_bits 1 \
-use_interleaving_wire_group 1

addRing -nets {VDD VSS} -follow core \
-layer {bottom ME6 top ME6 right ME5 left ME5} -width 3 -spacing 2 \
-use_wire_group 1 -use_wire_group_bits 1 \
-use_interleaving_wire_group 1


