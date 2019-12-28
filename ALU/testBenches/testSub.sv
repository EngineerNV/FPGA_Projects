`timescale 1ns/1ns
module testSub();
// DUT signals
	logic clock = 1'b0;
	logic [5:0] A; 
	logic [5:0] B; 
	logic [5:0] RESULT; 
	// Connect device to test
	sub dut_Lab4_Sub(.A(A),.B(B),.SUB_RESULT(RESULT));
	// Generate clock
	always #50 clock <= ~clock;
	
	task subIt(input logic [5:0] A_in, input logic [5:0] B_in);
		@(negedge clock);
		A<= A_in;
		B<= B_in;
		@(posedge clock)
		#1 
			testSub: assert(RESULT == (A+(~B+1'b1)))
			$display("It worked! Result is %b %b %b %b %b %b", RESULT[5], RESULT[4], RESULT[3], RESULT[2], RESULT[1], RESULT[0]);
				else $error("Did not sub correctly");	
	endtask

	initial 
	begin
		repeat(2) @(posedge clock);
		subIt(6'b010011, 6'b101111); // 19 - -17  overflow
		repeat(2) @(posedge clock);
		subIt(6'b011001, 6'b011001); // 25 - 25 should be 00000 
		repeat(2) @(posedge clock);
		subIt(6'b101101, 6'b010001); // -19 -17 guaranteed over flow 
	end 
endmodule 		