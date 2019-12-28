module ALU(input logic clock, wren, button, reset, 
	input logic [14:0] dataIn, 
	output logic NEG_A, NEG_B, NEG_RESULT, OVERFLOW_FLAG,
	output logic [6:0] A_TENS, A_ONES, B_TENS, B_ONES, RESULT_TENS, RESULT_ONES, 
	output logic full, empty, output logic [5:0] RESULT);
	logic synButton, wen, ren, resSyn;
	logic [3:0] rdAdd, wrAdd;
	logic [14:0] dataOut;
	logic [2:0] control;
	logic [5:0] A, B;
	reset res(.clock(clock), .rst(reset), .rstSync(resSyn));
	sync sync1(.clk(clock), .button(button), .reset(resSyn), .fall_edge(synButton));
	full_empty fullem(.wen(wen), .reset(resSyn), .ren(ren), .clock(clock), 
				.full(full), .empty(empty),
				.wrAddress(wrAdd), .rdAddress(rdAdd));
	control_fsm fsm(.clock(clock), .reset(resSyn), .button(synButton), 
		.wren(wren), .full(full), .empty(empty), 
		.wen(wen), .ren(ren));
	memory_unit mem(.dataIn(dataIn),
					.wrAddress(wrAdd), .rdAddress(rdAdd),
					.wen(wen), .ren(ren), .clock(clock),
					.dataOut(dataOut));	
	split sp(.data(dataOut), .control(control), 
		.A(A), .B(B));
	operations op(.clock(clock), .reset(resSyn), .A(A), .B(B), .control(control), .RESULT(RESULT), 
		.OVERFLOW_FLAG(OVERFLOW_FLAG), .NEG_A(NEG_A), .NEG_B(NEG_B), .NEG_RESULT(NEG_RESULT), 
		.A_TENS(A_TENS), .A_ONES(A_ONES), .B_TENS(B_TENS), .B_ONES(B_ONES), .RESULT_TENS(RESULT_TENS), 
		.RESULT_ONES(RESULT_ONES));	
		
endmodule 