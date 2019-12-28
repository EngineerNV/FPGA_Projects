`timescale 1ns/1ns
module test_read_write();
// DUT signals
	logic clock = 1'b0;
	logic button=1'b0, wren, full, empty, wen, ren; 
	logic [3:0] wrAdd, rdAdd;
	// Connect device to test
	control_fsm dut_fsm(.clock(clock), .button(button), .wren(wren), .full(full), .empty(empty), 
	.wen(wen), .ren(ren));
	full_empty dut_fe(.wen(wen), .ren(ren), .clock(clock), 
				.full(full), .empty(empty),
				.wrAddress(wrAdd), .rdAddress(rdAdd));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task write();
		@(negedge clock);//repeat IDLE  
			button<= 1'b1;
			wren <= 1'b1;
		@(negedge clock);
			button<= 1'b0;
	endtask
	
	task read();
		@(negedge clock);//repeat IDLE  
			button<= 1'b1;
			wren <= 1'b0;
		@(negedge clock);
			button<= 1'b0;
	endtask
	
	task fullCheck();
		for(int i=0 ; i<9; i++)
			write();
		@(posedge clock);
		#1
		fullish : assert(full == 1'b1)
			$display("it worked! system is full");
			else $display("write incremented even though it was full");		
		
	endtask
	
	task emptyCheck();
		for(int i=0; i<9; i++)
			read();
		@(posedge clock);
		#1
		emptish : assert(empty == 1'b1)
			$display("it worked! system is empty");
			else $display("read incremented even though it was empty");
	endtask		
	
	initial 
	begin 
		fullCheck();
		emptyCheck();
		
	end 
endmodule  