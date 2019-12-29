module regfile(input logic clk, RegWrite, 
	input logic [1:0] RegDst,
	input logic [4:0] ra, rb, rc,
	input logic [31:0] wdata,
	output logic [31:0] radata, rbdata);
	logic [31:0] mem [31:0];
	
	initial 
	begin
		for(int i = 0; i<32; i++)
			mem[i] =32'd0;
	end 
	
	always_ff @(posedge clk)
	begin 
		
		if(RegWrite)
		begin 
			if(RegDst == 2'd1) // we are using rb at 1 
			begin
				if(rb!=5'd0)
				begin 
					mem[rb] <= wdata;
				end
			end 
			else if(RegDst == 2'd2) // mux value for ra at 2
			begin
				mem[5'd31] <= wdata;
			end 
			else if(RegDst == 2'd3) // mux value for xp 
			begin 
				mem[5'd1] <= wdata;
			end 
			else // we are using rc value at 0
			begin  
				if(rc!=5'd0)
				begin 
					mem[rc] <= wdata;
				end
			end 
		end	
		
	end 
	
	always_comb
	begin 
		radata <= mem[ra];
		rbdata <= mem[rb];
	end 
endmodule 