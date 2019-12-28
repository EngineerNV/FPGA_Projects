`timescale 1ns/1ns
module testAdd();
// DUT signals
	logic clock = 1'b0;
	logic [5:0] A; 
	logic [5:0] B; 
	logic [5:0] RESULT; 
	
	// Connect device to test
	add dut_Lab4_Add(.A(A),.B(B),.Add_Result(RESULT));
	// Generate clock
	always #50 clock <= ~clock;
	
	task addIt(input logic [5:0] A_in, input logic [5:0] B_in);
		@(negedge clock);
		A<= A_in;
		B<= B_in;
		@(posedge clock)
		#1 
			testAdd: assert(RESULT == (A+B))
			$display("It worked! Result is %b %b %b %b %b %b", RESULT[5], RESULT[4], RESULT[3], RESULT[2], RESULT[1], RESULT[0]);
				else $error("Did not add correctly");	
	endtask

	initial 
	begin 
		repeat(2) @(posedge clock);
		addIt(6'b000001, 6'b101111 ); // 1 + -17  no overflow
		repeat(2) @(posedge clock);
		addIt(6'b011001, 6'b011001); // 25 + 25 overflow bound to happen 
		repeat(2) @(posedge clock);
		addIt(6'b101101, 6'b101111); // -19 + -17 guaranteed over flow 
	end 
endmodule		