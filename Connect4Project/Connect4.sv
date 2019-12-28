module Connect4(input logic clk, rst, L, E, R, output logic [3:0] ABCD, output logic R1, G1, B1, R2, G2, B2, La, En, output logic clko);
logic [2:0] colval;
logic Lt, Rt, Et, wen, win1, win2, ren, FSMrst, player, flag;
logic [4:0] waddr, rdaddr;
logic [63:0] Hline, Lline;
logic clk1;


clockdivider clkdiv(.iclk(clk),
                    .clk(clk1));

//---------------------Syncronizers------------------------------

Edge_Sync ES1(.clk(clk1), .rst(rst), .buttonin(L), .button(Lt));
Edge_Sync ES2(.clk(clk1), .rst(rst), .buttonin(R), .button(Rt));
Edge_Sync ES3(.clk(clk1), .rst(rst), .buttonin(E), .button(Et));

//-------------------Coin location FSM---------------------------

FSM_Col FSM1(.clk(clk1), .rst(rst), .FSM_rst(FSMrst), .L(Lt), 
				.R(Rt), .colval(colval));

//-----------------Coin Position Control-------------------------

Control CONTROL1(.clk(clk1), .rst(rst), .E(Et), .flag(flag), .colval(colval), .wen(wen), .win1(win1), .win2(win2), 
			.FSM_rst(FSMrst), .player(player), .waddr(waddr));

//--------------------Memory (32x32x2)---------------------------

Memory MEMORY1(.clk(clk1), .rst(rst), .win1(win1), .win2(win2), .wen(wen), .ren(ren), .Player(player), .colval(colval),
	.waddr(waddr), .rdaddr(rdaddr), .Hdataline(Hline), .Ldataline(Lline));	
	
//------------------------WIN Logic------------------------------

winCheck WIN(.clk(clk1), .rst(rst), .Player(Player), .colval(colval), .waddr(waddr), .winflag(flag));

//-------------------Display Multiplexer-------------------------

display_FSM DISPLAY1(.clk(clk1), .rst(rst), .Hline(Hline), .Lline(Lline), .raddr(rdaddr),
.enable(En), .R1(R1), .G1(G1), .B1(B1), .R2(R2), .G2(G2), .B2(B2), .Latch(La), .ren(ren), .ABCD(ABCD), .clko(clko));


endmodule 