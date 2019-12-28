`timescale 1ns/1ns
module testOp();
// DUT signals
	logic clock = 1'b0; 
	logic [5:0] A, B;
	logic [2:0] control;
	logic reset=1'b1;  
    logic [5:0] RESULT_SUB, RESULT_ADD, RESULT_GREAT, RESULT_LESS, RESULT_EQUAL, RESULT_EZERO; 
    logic [5:0] MAG_A, MAG_B, MAG_RESULT; 
	logic OVERFLOW_FLAG; 
    logic NEG_A, NEG_B, NEG_RESULT; 
    logic [6:0] A_TENS, A_ONES, B_TENS, B_ONES, RESULT_TENS, RESULT_ONES;
	// Connect device to test
	operations op(.clock(clock), .A(A), .B(B), .control(control), .reset(reset), .OVERFLOW_FLAG(OVERFLOW_FLAG),
	.NEG_A(NEG_A), .NEG_B(NEG_B), .NEG_RESULT(NEG_RESULT), .A_TENS(A_TENS), .A_ONES(A_ONES), .B_TENS(B_TENS), 
	.B_ONES(B_ONES), .RESULT_TENS(RESULT_TENS), .RESULT_ONES(RESULT_ONES));
	
	
	// Generate clock
	always #50 clock <= ~clock;
	task res();
		@(negedge clock);
		reset <= 1'b0;
		/*repeat(3) @(posedge clock);
		#1
		rese: assert(result== 6'd0)
			$display("Success: Reset Result");
			else $display("Failed: Equal Test gives 1");
	*/
	endtask 
	
	task great();
		@(negedge clock);
		A <= 6'd20;
		B <= 6'd1;
		control <= 3'b101;
		/*@(posedge clock );
		#1
		gre: assert(result== 6'd1)
			$display("Success: Greater than Result");
			else $display("Failed Greater Than");
		*/
	endtask 
	
	task less();
		@(negedge clock);
		A <= 6'd1;
		B <= 6'd20;
		control <= 3'b110;
		/*@(posedge clock );
		#1
		les: assert(result== 6'd1)
			$display("Success: Less than Result");
			else $display("Failed Less Than");
		*/
	endtask
	
	task equal();
		@(negedge clock);
		A <= 6'd1;
		B <= 6'd1;
		control <= 3'b100;
		/*@(posedge clock );
		#1
		equ: assert(result== 6'd1)
			$display("Success: Equal Result");
			else $display("Failed Equal");
		*/
	endtask
	
	task equalz();
		@(negedge clock);
		A <= 6'd0;
		B <= 6'd1;
		control <= 3'b111;
		/*@(posedge clock );
		#1
		eqz: assert(result== 6'd1)
			$display("Success: Equal Zero Result");
			else $display("Failed Zero Equal");
		*/
	endtask
	
	task plus();
		@(negedge clock);
		A <= 6'd0;
		B <= 6'd1;
		control <= 3'b000;
		/*@(posedge clock );
		#1
		pl: assert(result== 6'd1)
			$display("Success: Plus Result");
			else $display("Failed Plus");
		*/
	endtask
	
	task min();
		@(negedge clock);
		A <= 6'd1;
		B <= 6'd1;
		control <= 3'b001;
		/*@(posedge clock );
		#1
		pl: assert(result== 6'd0)
			$display("Success: sub Result");
			else $display("Failed sub");
		*/
	endtask
	
	initial 
	begin 
	min();
	plus();
	equal();
	equalz();
	less();
	great();
	res();
	end
	
	
	
endmodule 