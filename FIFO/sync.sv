module sync(input logic clk, button, output logic fall_edge);
logic in_ff1;
logic in_ff2;
logic sync;
always_ff @(posedge clk)
begin 
	in_ff1 <= button;
	in_ff2 <= in_ff1;
	sync <= in_ff2; 
end
always_comb
begin 
fall_edge = (~in_ff2) & sync;
end  
endmodule 