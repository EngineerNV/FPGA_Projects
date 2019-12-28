`timescale 1ns/1ns
module testOverflow();
// DUT signals
	logic clock = 1'b0;
	logic [5:0] A;
	logic [5:0] B;
	logic [5:0] RESULT; 
	logic overflow; 
	logic [2:0] ADD_SUB;
	// Connect device to test
	overflow dut_Lab4_overflow(.A(A),.B(B), .RESULT(RESULT), .ADD_SUB(ADD_SUB), .OVERFLOW_FLAG(overflow));
	// Generate clock
	always #50 clock <= ~clock;
	
	task PosPlusNeg();
	@(negedge clock);
	ADD_SUB <= 3'b000;
	A <= 6'b010001; // positive 17 
	B <= 6'b101101; // -19
	RESULT <= 6'b111110;
	@(posedge clock);
	#1
		testPPN : assert(overflow == 0)
		$display("SUCCESS There is no Overflow for 17 + -19!");
			else $error("Something went wrong Pos + Neg");
	endtask
	
	task PosPlusPos();
	@(negedge clock);
	ADD_SUB <= 3'b000;
	A <= 6'b010001; // positive 17 
	B <= 6'b010011; // pos 19
	RESULT <= 6'b100100;
	@(posedge clock);
	#1
		testPPP : assert(overflow == 1)
		$display("SUCCESS There is Overflow for 17 + 19!");
			else $error("Something went wrong Pos + Pos");
	endtask
	
	
	task NegPlusNeg();
	@(negedge clock);
	ADD_SUB <= 3'b000;
	A <= 6'b101111; // neg 17 
	B <= 6'b101101; // neg 19
	RESULT <= 6'b011100;
	@(posedge clock);
	#1
		testNPN : assert(overflow == 1)
		$display("SUCCESS There is Overflow for -17 + -19!");
			else $error("Something went wrong Neg + neg");
	endtask
	
	task PosMinusPos();
	@(negedge clock);
	ADD_SUB <= 3'b001;
	A <= 6'b010001; // positive 17 
	B <= 6'b010011; // pos 19
	RESULT <=6'b100100;
	@(posedge clock);
	#1
		testPMP : assert(overflow == 0)
		$display("SUCCESS There is no Overflow for 17 - 19!");
			else $error("Something went wrong Pos - Pos");
	endtask

	task NegMinusNeg();
	@(negedge clock);
	ADD_SUB <= 3'b001;
	A <= 6'b101111; // neg 17 
	B <= 6'b101101; // neg 19
	RESULT <= 6'b000010;
	@(posedge clock);
	#1
		testNMN : assert(overflow == 0)
		$display("SUCCESS There is no Overflow for -17 - -19!");
			else $error("Something went wrong Neg - neg");
	endtask
	
	task PosMinusNeg();
	repeat(2) @(negedge clock);
	ADD_SUB <= 3'b001;
	A <= 6'b010001; // positive 17 
	B <= 6'b101101; // -19
	RESULT <= 6'b100100;
	@(posedge clock);
	#1
		testPMN : assert(overflow == 1)
		$display("SUCCESS There is Overflow for 17 - -19!");
			else $error("Something went wrong Pos - Neg");
	endtask
	
	task NegMinusPos();
	@(negedge clock);
	ADD_SUB <= 3'b001;
	B <= 6'b010001; // positive 17 
	A <= 6'b101101; // -19
	RESULT <= 011100 ;
	@(posedge clock);
	#1
		testNMP : assert(overflow == 1)
		$display("SUCCESS There is Overflow for -19 - 17!");
			else $error("Something went wrong Neg - POS");
	endtask
	
	initial 
	begin 
	PosMinusNeg();
	PosMinusPos();
	PosPlusNeg();
	PosPlusPos();
	NegPlusNeg();
	NegMinusNeg();
	NegMinusPos();
	end 
	
endmodule 