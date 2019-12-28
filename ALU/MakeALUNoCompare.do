      if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog -sv -work work [pwd]/operations.sv
vlog -sv -work work [pwd]/display.sv
vlog -sv -work work [pwd]/add.sv
vlog -sv -work work [pwd]/sub.sv
vlog -sv -work work [pwd]/mag.sv
vlog -sv -work work [pwd]/equal.sv
vlog -sv -work work [pwd]/equal_z.sv
vlog -sv -work work [pwd]/less.sv
vlog -sv -work work [pwd]/greater.sv
vlog -sv -work work [pwd]/reset.sv
vlog -sv -work work [pwd]/overflow.sv
vlog -sv -work work [pwd]/display.sv
vlog -sv -work work [pwd]/seven_seg.sv
vlog -sv -work work [pwd]/sync.sv
vlog -sv -work work [pwd]/full_empty.sv
vlog -sv -work work [pwd]/testALU.sv
vlog -sv -work work [pwd]/ALU.sv
vlog -sv -work work [pwd]/split.sv
vlog -sv -work work [pwd]/control_fsm.sv
vlog -sv -work work -suppress 7061 [pwd]/memory_unit.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testALU

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals (including internal) ###
add wave *
add wave dut_ALU/synButton
### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure

# to see all signal names and current values
view signals

### ---------------------------------------------- ###
### Edit run time ###
run 4000000 

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view -undock wave
wave zoomfull