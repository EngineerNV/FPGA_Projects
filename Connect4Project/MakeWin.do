if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
#vlog -sv -work work -suppress 7061 [pwd]/MemoryBoard.sv
vlog -sv -work work [pwd]/winCheckTEST.sv
vlog -sv -work work [pwd]/testWin.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testWin

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals (including internal) ###
add wave *
add wave dutWin/board
#add wave dutWin/vFlag2
#add wave dutWin/vFlag1
#add wave dutWin/hFlag1
#add wave dutWin/hFlag2

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