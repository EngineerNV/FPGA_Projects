module operations(input logic clock, reset, input logic [5:0] A, input logic [5:0] B, input logic [2:0] control, 
output logic [5:0] RESULT, output logic OVERFLOW_FLAG, 
output logic NEG_A, output logic NEG_B, output logic NEG_RESULT, 
output logic [6:0] A_TENS, A_ONES, B_TENS, B_ONES, RESULT_TENS, RESULT_ONES);
	logic [5:0] RESULT_SUB, RESULT_ADD, RESULT_GREAT, RESULT_LESS, RESULT_EQUAL, RESULT_EZERO;
	logic [5:0] MAG_A, MAG_B, MAG_RESULT;
	//use all modules for always_FF block below 
	add add1(.A(A), .B(B), .Add_Result(RESULT_ADD));
	sub sub1(.A(A), .B(B), .SUB_RESULT(RESULT_SUB));
	greater g1(.A(A), .B(B), .greater_result(RESULT_GREAT));
	less	l1(.A(A), .B(B), .less_result(RESULT_LESS));
	equal	e1(.A(A), .B(B), .e_result(RESULT_EQUAL));
	equal_z ez(.A(A), .ezero_result(RESULT_EZERO));
	
	always_ff @(posedge clock or negedge reset)
	begin
		if(!reset)
		begin 
			RESULT <= 6'd0;
		end 
		else
		begin 	
			if(control == 3'b000)
				RESULT <= RESULT_ADD;
			else if(control == 3'b001)
				RESULT <= RESULT_SUB;
			else if(control == 3'b100)
				RESULT <= RESULT_EQUAL;
			else if(control == 3'b101)
				RESULT <= RESULT_GREAT;
			else if(control == 3'b110)
				RESULT <= RESULT_LESS;
			else if(control == 3'b111)	
				RESULT <= RESULT_EZERO;
		end 		
	end 
	
	
	display displayMini(.A(A), .B(B), 
	.RESULT(RESULT), .ADD_SUB(control), 
	.MAG_A(MAG_A), .MAG_B(MAG_B), .MAG_RESULT(MAG_RESULT), .OVERFLOW_FLAG(OVERFLOW_FLAG), 
	.NEG_A(NEG_A), .NEG_B(NEG_B), .NEG_RESULT(NEG_RESULT), 
	.A_TENS(A_TENS), .A_ONES(A_ONES), .B_TENS(B_TENS), 
	.B_ONES(B_ONES), .RESULT_TENS(RESULT_TENS), .RESULT_ONES(RESULT_ONES));
endmodule	