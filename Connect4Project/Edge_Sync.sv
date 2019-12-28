module Edge_Sync(input logic clk, rst, buttonin, output logic button);

logic sync1=1, sync2=1, sync3=1;


always_ff @(posedge clk or negedge rst)
begin
	if(!rst)
		begin
			sync1<=1'b1;
			sync1<=1'b1;
			sync1<=1'b1;
		end
	
	else
		begin
			sync1 <= buttonin;
			sync2 <= sync1;
			sync3 <= sync2;
		end
end

assign button = ~sync2&sync3;//active high

endmodule 