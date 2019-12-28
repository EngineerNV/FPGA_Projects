module greater(input logic [5:0] A, B, output logic [5:0] greater_result);
	int Atwo;//confirming it is taking in two's compliment  
	int Btwo;
	logic [5:0] temp, temp2;
	assign temp=~(A)+1;
	assign temp2=~(B)+1;
	always_comb
	begin 
		if(A[5]==1)
		begin
			Atwo= -1*(temp);			
		end
		else 
		  Atwo=A;
	end 
	
	always_comb
	begin 
		if(B[5]==1)
		begin 
			Btwo= -1*(temp2);
		end 
		else
			Btwo=B;
	end 
	
	always_comb
	begin 
	
		if(Atwo>Btwo)
			greater_result <= 6'd1;  
		else 
			greater_result <= 6'd0;
	end 
endmodule 