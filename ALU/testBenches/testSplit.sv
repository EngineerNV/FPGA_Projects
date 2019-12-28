`timescale 1ns/1ns
module testSplit();
// DUT signals
	logic clock = 1'b0; 
	logic [14:0] data;
	logic [5:0] A, B;
	logic [2:0] control;
	// Connect device to test
	split dutSplit(.data(data),
					.control(control),
					.A(A), .B(B));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task randomData();
		@(negedge clock);//repeat IDLE  
			data <= $random(6);
		@(posedge clock);
			#1
			conTest: assert(control==data[14:12])
			$display("The control Variable is correct!");
			else $display("The control varible isn't correct");
			
			ATest: assert(A==data[11:6])
			$display("The A Variable is split correct!");
			else $display("The A varible isn't correct");
			
			BTest: assert(B==data[5:0])
			$display("The B Variable is split correct!");
			else $display("The B varible isn't correct");
	endtask
	
	
	initial 
	begin 
		randomData();
		
	end 
endmodule  