`timescale 1ns/1ns
module TBmem();

logic [63:0] Hdataline, Ldataline;
logic [4:0] rdaddr=5'd0;
logic [4:0] waddr=5'd0;
logic wen=1'b0;
logic ren=1'b0;
logic Player=1'b0;
logic clk=1'b0;
logic [2:0] colval=3'd0;
Memory Mem(.clk(clk), .wen(wen), .ren(ren), .Player(Player), .colval(colval),
	.waddr(waddr), .rdaddr(rdaddr), .Hdataline(Hdataline), .Ldataline(Ldataline));


always #50 clk<= ~clk;

initial
begin

@(negedge clk);
ren<=1'b0;
wen<=1'b1;
colval<=3'b010; //3rd column
Player<=1'b1;  //10 data
@(negedge clk);
waddr<=5'b11111; //bottom row


@(negedge clk);
rdaddr<=5'b01111; //should get 3rd column with 01 on Lline b01111
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;



@(negedge clk);
rdaddr<=5'b01110; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;
@(negedge clk);
rdaddr<=5'b01101; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;
@(negedge clk);
rdaddr<=5'b01100; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;



















@(negedge clk);
ren<=1'b0;
wen<=1'b1;
colval<=3'b010; //3rd column
Player<=1'b0;  //01 data
@(negedge clk);
waddr<=5'b00111; //7th row

/*
@(negedge clk);
rdaddr<=5'b00111; //should get 3rd column with 01 on Lline b01111
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;



@(negedge clk);
rdaddr<=5'b00110; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;
@(negedge clk);
rdaddr<=5'b00101; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;
@(negedge clk);
rdaddr<=5'b00100; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;

*/





@(negedge clk);
ren<=1'b0;
wen<=1'b1;
colval<=3'b111; //7th column
Player<=1'b0;  //01 data
@(negedge clk);
waddr<=5'b00111; //7th row


@(negedge clk);
rdaddr<=5'b00111; //should get 3rd column with 01 on Lline b01111
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;



@(negedge clk);
rdaddr<=5'b00110; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;
@(negedge clk);
rdaddr<=5'b00101; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;
@(negedge clk);
rdaddr<=5'b00100; //should get 3rd column with 01 on Lline
repeat(4) @(negedge clk);
ren<=1'b1;
wen<=1'b0;
@(negedge clk);
ren<=1'b0;
wen<=1'b0;

end
	
endmodule 
