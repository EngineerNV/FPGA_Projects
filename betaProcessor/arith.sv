module arith(input logic [1:0] ALUOp,
	input logic [31:0] A,B,
	output logic [31:0] arithout,
	output logic z,v,n);
	
	always_comb
	begin 
		if(ALUOp[0] == 1'b0) // addition operation
		begin
			arithout = A + B;
			if( (A[31] == B[31]) && (arithout[31] != A[31]) )//there is overflow
			begin 
				v = 1'b1;
				if( arithout == 32'd0 ) // if output was zero
				begin
					z = 1'b1;
					n = 1'b0;
				end
				else // if output was not zero 
				begin 
					z = 1'b0;
					if(arithout[31] == 1'b1)// if the output is negative
					begin 
						n = 1'b1;
					end
					else // if the output is not negative 
					begin 
						n = 1'b0;
					end 
				end 
			end
			else //there is no overflow 
			begin 
				v = 1'b0;
				if( arithout == 32'd0 ) // if output was zero
				begin
					z = 1'b1;
					n = 1'b0;
				end
				else // if output was not zero 
				begin 
					z = 1'b0;
					if(arithout[31] == 1'b1)// if the output is negative
					begin 
						n = 1'b1;
					end
					else // if the output is not negative 
					begin 
						n = 1'b0;
					end 
				end
			end
		end
		else if(ALUOp[0] == 1'b1) //subtract operation
		begin 
			arithout = A + (~(B) + 1);
			if( (A[31] == ~(B[31])) && (arithout[31] != A[31]) )//there is overflow
			begin 
				v = 1'b1;
				if( arithout == 32'd0 ) // if output was zero
				begin
					z = 1'b1;
					n = 1'b0;
				end
				else // if output was not zero 
				begin 
					z = 1'b0;
					if(arithout[31] == 1'b1)// if the output is negative
					begin 
						n = 1'b1;
					end
					else // if the output is not negative 
					begin 
						n = 1'b0;
					end 
				end 
			end
			else //there is no overflow 
			begin 
				v = 1'b0;
				if( arithout == 32'd0 ) // if output was zero
				begin
					z = 1'b1;
					n = 1'b0;
				end
				else // if output was not zero 
				begin 
					z = 1'b0;
					if(arithout[31] == 1'b1)// if the output is negative
					begin 
						n = 1'b1;
					end
					else // if the output is not negative 
					begin 
						n = 1'b0;
					end 
				end
			end
		end
		else // default case
		begin 
			arithout= 32'd0;
			z = 1'b0;
			v = 1'b0;
			n = 1'b0;
		end
	end		
endmodule