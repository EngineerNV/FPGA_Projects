module overflow(input logic [5:0] A, input logic [5:0] B, input logic [2:0] ADD_SUB, 
	input logic [5:0] RESULT, output logic OVERFLOW_FLAG); 	
	logic [5:0] B_Sub; 
	always_comb
	begin
		if(ADD_SUB == 3'b001) // if it is subtraction 
		begin 
			B_Sub <= (~B+1);	
		end
		else 
			B_Sub <= B;
	end
	always_comb 
	begin  	
		if((B_Sub[5] == A[5])&&(B_Sub[5] != RESULT[5])&&(ADD_SUB==3'b000 || ADD_SUB==3'b001)) // if the A and B input are both pos/neg and Result isnt 
			begin 
				OVERFLOW_FLAG = 1'b1; 
			end 
		else 
			begin 
				OVERFLOW_FLAG = 1'b0;
			end
	end 
endmodule 
		