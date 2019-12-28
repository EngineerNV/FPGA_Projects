      if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/sub.sv
vlog -sv -work work [pwd]/testSub.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testSub



### ---------------------------------------------- ###
### Edit run time ###
run 2000 


vlog -sv -work work [pwd]/add.sv
vlog -sv -work work [pwd]/testAdd.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testAdd

### ---------------------------------------------- ###





### ---------------------------------------------- ###
### Edit run time ###
run 2000 

vlog -sv -work work [pwd]/testEqual.sv
vlog -sv -work work [pwd]/equal.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testEqual

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals (including internal) ###



### ---------------------------------------------- ###
### Edit run time ###
run 3000 

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog -sv -work work [pwd]/testEqual_z.sv
vlog -sv -work work [pwd]/equal_z.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testEqual_z

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals (including internal) ###



### ---------------------------------------------- ###
### Edit run time ###
run 3000 

vlog -sv -work work [pwd]/testGreater.sv
vlog -sv -work work [pwd]/greater.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testGreater


### ---------------------------------------------- ###
### Edit run time ###
run 3000 

vlog -sv -work work [pwd]/testLess.sv
vlog -sv -work work [pwd]/less.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim testLess


### ---------------------------------------------- ###
### Edit run time ###
run 3000 




### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog +cover=bcesfx -sv -work work [pwd]/operations.sv
vlog +cover=bcesfx -sv -work work [pwd]/display.sv
vlog +cover=bcesfx -sv -work work [pwd]/add.sv
vlog +cover=bcesfx -sv -work work [pwd]/sub.sv
vlog +cover=bcesfx -sv -work work [pwd]/mag.sv
vlog +cover=bcesfx -sv -work work [pwd]/equal.sv
vlog +cover=bcesfx -sv -work work [pwd]/equal_z.sv
vlog +cover=bcesfx -sv -work work [pwd]/less.sv
vlog +cover=bcesfx -sv -work work [pwd]/greater.sv
vlog +cover=bcesfx -sv -work work [pwd]/reset.sv
vlog +cover=bcesfx -sv -work work [pwd]/overflow.sv
vlog +cover=bcesfx -sv -work work [pwd]/display.sv
vlog +cover=bcesfx -sv -work work [pwd]/seven_seg.sv
vlog +cover=bcesfx -sv -work work [pwd]/sync.sv
vlog +cover=bcesfx -sv -work work [pwd]/full_empty.sv
vlog -sv -work work [pwd]/testALU.sv
vlog +cover=bcesfx -sv -work work [pwd]/ALU.sv
vlog +cover=bcesfx -sv -work work [pwd]/split.sv
vlog +cover=bcesfx -sv -work work [pwd]/control_fsm.sv
vlog +cover=bcesfx -sv -work work -suppress 7061 [pwd]/memory_unit.sv
### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim -coverage testALU

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