module bool(input logic [3:0] ALUOp, 
		input logic [31:0] A,B,
		output logic [31:0] boolout);
	always_comb
	begin 
		if (ALUOp == 4'b1010)//A
		begin
			boolout = A;		
		end
		else if (ALUOp == 4'b1000)//AND
		begin
			boolout = A & B;
		end 
		else if (ALUOp == 4'b0001)//NOR
		begin 
			boolout = ~(A|B); 
		end
		else if (ALUOp == 4'b1110) //OR
		begin
			boolout = (A|B);
		end
		else if (ALUOp == 4'b1001) //XNOR
		begin 
			boolout = ~(A^B);
		end 
		else if (ALUOp == 4'b0110) //XOR
		begin 
			boolout = (A^B);
		end
		else 
		begin 
			boolout = 32'd0;
		end  
	end

endmodule 