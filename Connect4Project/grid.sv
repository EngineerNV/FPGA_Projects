module grid(input logic [63:0] dataIn,
					input logic [4:0] wrAddress, rdAddress,
					input logic wen, ren, clock,
					output logic [63:0] dataOut);
					
logic [63:0] memory [31:0];

always_ff @(posedge clock)
begin
	if(wen)
		memory[wrAddress] <= dataIn;
	if(ren)
		dataOut <= memory[rdAddress];
end
endmodule

initial
begin
		$readmemb("Initializer.txt.txt", memory);
end