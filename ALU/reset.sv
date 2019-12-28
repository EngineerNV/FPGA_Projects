module reset(input logic clock, rst, output logic rstSync);
	logic intRst;
	always_ff @(posedge clock or negedge rst)
		if(!rst)
		begin 
			intRst <=1'b0;
			rstSync <= 1'b0;
		end 
		else 
			begin
				intRst <= 1'b1;
				rstSync <= intRst;
			end
endmodule 
		