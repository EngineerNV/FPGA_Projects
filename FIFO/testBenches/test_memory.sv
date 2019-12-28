`timescale 1ns/1ns
module test_read_write();
// DUT signals
	logic clock = 1'b0;
	logic wen, ren; 
	logic [14:0] dataOut, data;
	logic [3:0] wrAdd, rdAdd;
	// Connect device to test
	memory_unit dut_mem(.dataIn(data),
					.wrAddress(wrAdd), .rdAddress(rdAdd),
					.wen(wen), .ren(ren), .clock(clock),
					.dataOut(dataOut));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task write(input logic [14:0] w, input logic [3:0] wrd);
		@(negedge clock);//repeat IDLE  
			data <= w;
			wrAdd <= wrd;
			wen <= 1'b1;
		@(negedge clock);
			wen <= 1'b0;
	endtask
	
	task read(input logic [14:0] r, input logic [3:0] rda);
		@(negedge clock);//repeat IDLE  
			data <= r; 
			rdAdd <= rda;
			ren <=1'b1;
		@(negedge clock);
			ren <= 1'b0;
	endtask
	
	
	initial 
	begin 
		write(15'd10, 4'b0000);
		write(15'd11, 4'b0001);
		write(15'd12, 4'b0010);
		
		read(15'd12, 4'b0000);
		read(15'd12, 4'b0001);
		read(15'd12, 4'b0010);
		read(15'd12, 4'b0011);
		read(15'd12, 4'b0100);
		read(15'd12, 4'b0101);
		
	end 
endmodule  