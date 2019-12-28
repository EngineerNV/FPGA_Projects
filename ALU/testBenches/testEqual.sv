`timescale 1ns/1ns
module testEqual();
// DUT signals
	logic clock = 1'b0; 
	
	logic [5:0] A, B, result;
	
	// Connect device to test
	equal dute(.e_result(result),
					.A(A), .B(B));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task testSame();
		@(negedge clock);//repeat IDLE  
			A = 6'd11;
			B = A; 
		@(posedge clock);
			#1
			EqualTest: assert(result== 6'd1)
			$display("The Equal Test Works!");
			else $display("The Equal Test Failed");
			
	endtask
	
	task testDiff();
		@(negedge clock);//repeat IDLE  
			A = 6'd12;
			B = 6'd14; 
		@(posedge clock);
			#1
			DifTest: assert(result== 6'd0)
			$display("The Different Test works!");
			else $display("The Different Test Failed it thought it was equal");
			
	endtask
	
	
	initial 
	begin 
		testSame();
		testSame();
		testDiff();
		testDiff();	
	end 
endmodule  