module memory_unit(input logic [14:0] dataIn,
					input logic [3:0] wrAddress, rdAddress,
					input logic wen, ren, clock,
					output logic [14:0] dataOut);
					
logic [14:0] memory [31:0];

always_ff @(posedge clock)
begin
	if(wen)
		memory[wrAddress[2:0]] <= dataIn;
	if(ren)
		dataOut <= memory[rdAddress[2:0]];
end

initial 
begin 
	for(int i=0; i<32; i++)
		memory[i] <= i;
end 

endmodule