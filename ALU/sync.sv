module sync(input logic clk, button, reset, output logic fall_edge);
logic in_ff1;
logic in_ff2, sync;
always_ff @(posedge clk or negedge reset)
begin 
	if(!reset)
	begin
		in_ff1 <= 1'b0;
		in_ff2 <= 1'b0;
		sync <= 1'b0;
	end 
	else 
	begin 
		in_ff1 <= button;
		in_ff2 <= in_ff1;
		sync <= in_ff2;
	end
end
always_comb
begin 
fall_edge = (~in_ff2) & sync;
end  
endmodule 