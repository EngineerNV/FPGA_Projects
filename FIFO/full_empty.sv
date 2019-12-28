module full_empty(input logic wen, ren, clock, 
				output logic full=1'b0, empty=1'b1,
				output logic [3:0] wrAddress=4'd0, rdAddress=4'd0);
		 
		always_ff @(posedge clock)
		begin 
			if(wen)
			begin 
				wrAddress <= wrAddress+4'd1;  	
			end 
			if(ren)
			begin 
				rdAddress <= rdAddress+4'd1;
			end
		end 
		
		always_comb
		begin 
			if(rdAddress == wrAddress)
			begin 
				empty <= 1'b1;
			end 
			else 
				empty <= 1'b0; 
		end	

		always_comb
		begin
			if((rdAddress[2:0] == wrAddress[2:0])&&(rdAddress[3]!=wrAddress[3]))
			begin 
				full <=1'b1;
			end
			else 
				full <=1'b0;
		end
endmodule