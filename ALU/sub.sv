module sub(input logic [5:0] A, input logic [5:0] B, output logic [5:0] SUB_RESULT);
	always_comb 
	begin 
		SUB_RESULT= A + (~(B) + 1'b1); //A - B = A + two's complement B 
	end
endmodule 