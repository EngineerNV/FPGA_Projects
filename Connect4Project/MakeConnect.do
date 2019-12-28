if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog -sv -work work -suppress 7061 [pwd]/Memory.sv
vlog -sv -work work [pwd]/winCheck.sv
vlog -sv -work work [pwd]/testConnect.sv
vlog -sv -work work [pwd]/FSM_COL.sv
#vlog -sv -work work [pwd]/Initializer.txt
vlog -sv -work work [pwd]/Edge_Sync.sv
vlog -sv -work work [pwd]/display_FSM.sv
vlog -sv -work work [pwd]/Control.sv
vlog -sv -work work [pwd]/Connect4.sv
vlog -sv -work work [pwd]/clockdivider.sv
vlog -sv -work work [pwd]/testConnect.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testConnect

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals (including internal) ###
add wave *
#add wave /dutC/WIN/board
add wave /dutC/waddr
### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure

# to see all signal names and current values
view signals

### ---------------------------------------------- ###
### Edit run time ###
run 100000000 

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view -undock wave
wave zoomfull