module display(input logic [5:0] A, input logic [5:0] B, 
input logic [5:0] RESULT, input logic [2:0] ADD_SUB, 
output logic [5:0] MAG_A, output logic [5:0] MAG_B, output logic [5:0] MAG_RESULT, output logic OVERFLOW_FLAG, 
output logic NEG_A, output logic NEG_B, output logic NEG_RESULT, 
output logic [6:0] A_TENS, output logic [6:0] A_ONES, output logic [6:0] B_TENS, 
output logic [6:0] B_ONES, output logic [6:0] RESULT_TENS, output logic [6:0] RESULT_ONES); 
	logic [3:0] left_digitA;
	logic [3:0] right_digitA;
	logic [3:0] left_digitB;
	logic [3:0] right_digitB;
	logic [3:0] left_digitRESULT;
	logic [3:0] right_digitRESULT;
	
	overflow overRes(.A(A), .B(B), .ADD_SUB(ADD_SUB), 
	.RESULT(RESULT), .OVERFLOW_FLAG(OVERFLOW_FLAG));
	mag magA(.INPUT(A), .MAG_RESULT(MAG_A), .NEG_FLAG(NEG_A));
	mag magB(.INPUT(B), .MAG_RESULT(MAG_B), .NEG_FLAG(NEG_B));
	mag magResult(.INPUT(RESULT), .MAG_RESULT(MAG_RESULT), .NEG_FLAG(NEG_RESULT));
	
	assign left_digitA = MAG_A/10;
	assign right_digitA = MAG_A%10;
	assign left_digitB = MAG_B/10;
	assign right_digitB = MAG_B%10;
	assign left_digitRESULT = MAG_RESULT/10;
	assign right_digitRESULT = MAG_RESULT%10;
	
	seven_seg LDigitA(.INPUT(left_digitA), .led(A_TENS));
	seven_seg RDigitA(.INPUT(right_digitA), .led(A_ONES));
	seven_seg LDigitB(.INPUT(left_digitB), .led(B_TENS));
	seven_seg RDigitB(.INPUT(right_digitB), .led(B_ONES));
	seven_seg LDigitRes(.INPUT(left_digitRESULT), .led(RESULT_TENS));
	seven_seg RDigitRes(.INPUT(right_digitRESULT), .led(RESULT_ONES));
endmodule 