module equal_z(input logic [5:0] A, output logic [5:0] ezero_result);
	always_comb
	begin 
		if(A==0)
			ezero_result <= 6'd1;
		else 
			ezero_result <= 6'd0;
	end 
endmodule