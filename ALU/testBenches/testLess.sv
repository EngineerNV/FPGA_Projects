`timescale 1ns/1ns
module testLess();
// DUT signals
	logic clock = 1'b0; 
	
	logic [5:0] A, B, result;
	
	// Connect device to test
	less dut_less(.less_result(result),
					.A(A), .B(B));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task equalTest();
		@(negedge clock);//repeat IDLE  
			A = $random(6);
			B = A; 
		@(posedge clock);
			#1
			EquTest: assert(result== 6'd0)
			$display("Success: Equal number dont give 1!");
			else $display("Failed: Equal Test gives 1");
			
	endtask
	
	task testG();
		@(negedge clock);//repeat IDLE  
			A = $urandom_range(20,10);
			B = $urandom_range(9,0); 
		@(posedge clock);
			#1
			DifTest: assert(result== 6'd0)
			$display("Success: The Greater Test works! gives false");
			else $display("Failed: The greater Test gives true");
			
	endtask
	
	task testL();
		@(negedge clock);//repeat IDLE  
			A = $urandom_range(9,0);
			B = $urandom_range(20,10); 
		@(posedge clock);
			#1
			Lt: assert(result== 6'd1)
			$display("Success: The Less Test works give true!");
			else $display("Failed: The less Test Failed gave false");
			
	endtask
	
	task testN();
		@(negedge clock);//repeat IDLE  
			A = (~(6'd12)+1'b1);
			B = 6'd11; 
		@(posedge clock);
			#1
			DifN: assert(result== 6'd1)
			$display("Success: The neg A test gave True !");
			else $display("Failed The neg A Test Failed it thought it was false");
			
	endtask
	
	task testN2();
		@(negedge clock);//repeat IDLE  
			B = (~(6'd12)+1'b1);
			A = 6'd11; 
		@(posedge clock);
			#1
			DifN: assert(result== 6'd0)
			$display("Success: The neg B test gave False !");
			else $display("Failed The neg B Test Failed it thought it was true");
			
	endtask
	
	initial 
	begin 
		testN();
		testN2();
		testL();
		equalTest();
		testG();	
	end 
endmodule  