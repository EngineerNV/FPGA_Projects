module add(input logic [5:0] A, input logic [5:0] B, output logic [5:0] Add_Result);
	always_comb
	begin 
		Add_Result = A + B;
	end 
endmodule 