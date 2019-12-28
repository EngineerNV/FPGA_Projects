`timescale 1ns/1ns
module TBdisplay();

logic clk = 1'b0;
logic rst = 1'b1;
logic [63:0] Hline, Lline;
logic [4:0] raddr;
logic enable;
logic Latch;
logic R1, G1, B1, R2, G2, B2;
logic ren;
logic [3:0] ABCD;


display_FSM Disp(.clk(clk), .rst(rst), .Hline(Hline), .Lline(Lline), .raddr(raddr),
.enable(enable), .R1(R1), .G1(G1), .B1(B1), .R2(R2), .G2(G2), .B2(B2), .Latch(Latch), .ren(ren), .ABCD(ABCD));

always #50 clk<= ~clk;

task write();
	@(negedge clk);
	begin
    Hline<=64'h1A;
	 Lline<=64'h1B;
	end
	 
endtask

initial
begin

for(int i=0; i<40; i++)
begin
	write();
	@(negedge clk);
end

end 


endmodule 