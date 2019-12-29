module shift(input logic [1:0] ALUOp,
			input logic signed [31:0] A,
			input logic [4:0] B,
			output logic signed [31:0] shiftout);
	always_comb
	begin
		if(ALUOp == 2'b00)//left shift logical
		begin
			shiftout = (A << B);
		end
		else if(ALUOp == 2'b01) // right shift logical 
		begin
			shiftout = (A >> B);
		end
		else if(ALUOp == 2'b11) //shift right and sign extend 
		begin 
			shiftout = (A >>> B);
		end
		else  //no shifting 
		begin 
			shiftout = A;
		end 
	end
endmodule 