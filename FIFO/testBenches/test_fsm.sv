`timescale 1ns/1ns
module test_fsm();
// DUT signals
	logic clock = 1'b0;
	logic button=1'b0, wren=1'b0, full=1'b0, empty=1'b0, wen, ren; 
	// Connect device to test
	control_fsm dut_fsm(.clock(clock), .button(button), .wren(wren), .full(full), .empty(empty), 
	.wen(wen), .ren(ren));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task write(input logic button1, full1, empty1);
		@(negedge clock);//repeat IDLE  
			button<= button1;
			wren <= 1'b1;
			full <= full1;
			empty <= empty1;
	endtask
	
	task read(input logic button1, full1, empty1);
		@(negedge clock);//repeat IDLE  
			button<= button1;
			wren <= 1'b0;
			full <= full1;
			empty <= empty1;
 
	endtask
	
	initial 
	begin 
		write(1'b1, 1'b0, 1'b0); // write when full=0 and empty=0 button =1 
		write(1'b0, 1'b0, 1'b0); // write when full=0 and empty=0 button =0
		write(1'b1, 1'b1, 1'b0); // write when full=1 and empty=0 button =1
		write(1'b1, 1'b1, 1'b1); // write when full=1 and empty=1 button =1
		write(1'b1, 1'b0, 1'b1); // write when full=0 and empty=1 button =1
		read(1'b1, 1'b1, 1'b0); // read when full=1 and empty=0 button =1;
		read(1'b1, 1'b0, 1'b0); // read when full=0 and empty=0 button =1 
		read(1'b0, 1'b0, 1'b0); // read when full=0 and empty=0 button =0
		read(1'b1, 1'b1, 1'b1); // read when full=1 and empty=1 button =1
		read(1'b1, 1'b0, 1'b1); // read when full=0 and empty=1 button =1
		$stop;
	end 
endmodule  