module equal(input logic [5:0] A, B, output logic [5:0] e_result);
	always_comb
	begin 
		if(A==B)
			e_result <= 6'd1;
		else 
			e_result <= 6'd0;
	end 
endmodule