`timescale 1ns/1ns
module testFifo();
// DUT signals
	logic clock = 1'b0;
	logic button=1'b1, wren, full, empty, wen, ren; 
	logic [3:0] wrAdd, rdAdd;
	logic [14:0] dataIn;
	logic [6:0] dataHex0, dataHex1, dataHex2, dataHex3;
	// Connect device to test
	fifo dut_testF(.clock(clock), .wren(wren), .button(button), .dataIn(dataIn), 
	.dataHex0(dataHex0), .dataHex1(dataHex1), .dataHex2(dataHex2), .dataHex3(dataHex3), 
	.full(full), .empty(empty));
	// Generate clock
	always #50 clock <= ~clock;
	
	task write(input logic [14:0] d);
		repeat(2) @(negedge clock);//repeat IDLE  
			button<= 1'b0;
			wren <= 1'b1;
			dataIn <= d; 
		repeat(2) @(negedge clock);
			button<= 1'b1;
	endtask
	
	task read();
		repeat(2) @(negedge clock);//repeat IDLE  
			button<= 1'b0;
			wren <= 1'b0;
		repeat(2) @(negedge clock);
			button<= 1'b1;
	endtask
	
	task fullCheck();
		for(int i=0 ; i<9; i++)
			write(15'd7);
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