module comp(input logic ALUOp_three, ALUOp_one,
			input logic z,v,n,
			output logic [31:0] compout);
	
	always_comb
	begin 
		if( (ALUOp_three == 1'b0) && (ALUOp_one == 1'b0)  ) //CMPEQ
		begin 
			if( z == 1'b1 && v == 1'b0)
			begin 
				compout = 32'd1;
			end 
			else 
			begin 
				compout = 32'd0;
			end 
		end
		else if( (ALUOp_three == 1'b0) && (ALUOp_one == 1'b1) ) //CMPLT
		begin 
			if( (n == 1'b1 && v == 1'b0) || (v== 1'b1 && n== 1'b0) )
			begin 
				compout = 32'd1;
			end 
			else 
			begin 
				compout = 32'd0;
			end
		end 
		else if( (ALUOp_three == 1'b1) ) // CMPLE
		begin 
			if( (n == 1'b1 && v == 1'b0) || (z == 1'b1 && v == 1'b0) || (v== 1'b1 && n== 1'b0)  )
			begin 
				compout = 32'd1;
			end 
			else 
			begin 
				compout = 32'd0;
			end
		
		end 
		else 
		begin 
			compout = 32'd0; 
		end		
	end
	
endmodule 