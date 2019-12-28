module fifo(input logic clock, wren, button, 
	input logic [14:0] dataIn, 
	output logic [6:0] dataHex0, dataHex1, dataHex2, dataHex3, 
	output logic full, empty);
	logic synButton, wen, ren;
	logic [3:0] rdAdd, wrAdd;
	logic [14:0] dataOut;
	sync sync1(.clk(clock), .button(button), .fall_edge(synButton));
	full_empty fullem(.wen(wen), .ren(ren), .clock(clock), 
				.full(full), .empty(empty),
				.wrAddress(wrAdd), .rdAddress(rdAdd));
	control_fsm fsm(.clock(clock), .button(synButton), 
		.wren(wren), .full(full), .empty(empty), 
		.wen(wen), .ren(ren));
	memory_unit mem(.dataIn(dataIn),
					.wrAddress(wrAdd), .rdAddress(rdAdd),
					.wen(wen), .ren(ren), .clock(clock),
					.dataOut(dataOut));	
	display show(.dataOut(dataOut),
		.dataHex3(dataHex3), .dataHex2(dataHex2), 
		.dataHex1(dataHex1), .dataHex0(dataHex0));
		
endmodule 