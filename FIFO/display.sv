module display(input logic [14:0] dataOut,
output logic [6:0] dataHex3, dataHex2, dataHex1, dataHex0); 
	logic [3:0] dataIn3;
	logic [3:0] dataIn2;
	logic [3:0] dataIn1, dataIn0;
	
	assign dataIn0 = dataOut[3:0];
	assign dataIn1 = dataOut[7:4];
	assign dataIn2 = dataOut[11:8];
	assign dataIn3 = dataOut[14:12];
	
	seven_seg Digit0(.INPUT(dataIn0), .led(dataHex0));
	seven_seg Digit1(.INPUT(dataIn1), .led(dataHex1));
	seven_seg Digit2(.INPUT(dataIn2), .led(dataHex2));
	seven_seg Digit3(.INPUT(dataIn3), .led(dataHex3));
endmodule 