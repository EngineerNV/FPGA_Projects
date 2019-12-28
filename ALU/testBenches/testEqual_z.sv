`timescale 1ns/1ns
module testEqual_z();
// DUT signals
	logic clock = 1'b0; 
	
	logic [5:0] A, result;
	
	// Connect device to test
	equal_z dutz(.ezero_result(result),
					.A(A));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task testZ();
		@(negedge clock);//repeat IDLE  
			A = 0; 
		@(posedge clock);
			#1
			EqualTest: assert(result== 6'd1)
			$display("The Equal Test Works!");
			else $display("The Equal Test Failed");
			
	endtask
	
	task testNotZ();
		@(negedge clock);//repeat IDLE  
			A = $urandom_range(89,12); 
		@(posedge clock);
			#1
			DifTest: assert(result== 6'd0)
			$display("The Different Test works!");
			else $display("The Different Test Failed it thought it was equal");
			
	endtask
	
	
	initial 
	begin 
		testZ();
		testZ();
		testNotZ();
		testNotZ();	
	end 
endmodule  