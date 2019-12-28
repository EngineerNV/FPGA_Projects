`timescale 1ns/1ns
module testConnect();
// DUT signals
	logic clock = 1'b0, winflag, Player, rst=1'b0, tempV, tempH, tempRD, tempLD, co; 
	logic [2:0] colval;
	logic [1:0] board[6][7];
	logic [4:0] waddr;
	int unsigned r1, r2, r3;
	logic R1, G1, B1, R2, G2, B2, La, En, L=1'b1, E=1'b1, R=1'b1;
	logic [3:0] ABCD;
	//board = dutWin.board;
	//output logic [1:0] board[6][7];
	// Connect device to test
	//winCheck dutWin( .board(board),   
	//			.winflag(winflag1));
	
	Connect4 dutC( .clk(clock), .clko(co), .rst(rst), .L(L), .E(E), .R(R), .ABCD(ABCD), .R1(R1), .G1(G1), .B1(B1), .R2(R2), .G2(G2), .B2(B2), .La(La), .En(En));
	 
	 
	// Generate clock
	always #50 clock <= ~clock;
	
	task pressLeft();
		 
			@(negedge clock);
			L =1'b0;	
			@(posedge clock);
			#2
			L=1'b1;
		 
	endtask

	task pressRight(); 
			@(negedge clock);
			R =1'b0;	
			@(posedge clock);
			#2
			R=1'b1;
	endtask	
	
	task randomLeft();
		r1 = $urandom_range(7,0);
		for(int i=0; i<r1; i++)
		begin 
			@(negedge clock);
			L =1'b0;	
			@(posedge clock);
			#2
			L=1'b1;
		end 
	endtask

	task randomRight();
		r2 = $urandom_range(7,0);
		for(int i=0; i<r2; i++)
		begin 
			@(negedge clock);
			R =1'b0;	
			@(posedge clock);
			#2
			R=1'b1;
		end 
	endtask	
	
	task enter();
		@(negedge clock);
		E=1'b0;
		@(posedge clock);
		#2
		E=1'b1;
	endtask 
	
	
	
	task testV();
		for(int i=0; i<5; i++)
		begin 
		    pressRight(); //shift it to 1st column (col 0)
		    repeat(4) @(negedge clock);
			enter();//drop player 1 in first column
			repeat(1) @(negedge clock);
			pressRight();//shift it to 1st column (col 0)
			repeat(2) @(negedge clock);
			pressRight();//shift it to 2nd column (col 1)
			repeat(2) @(negedge clock);
			enter(); //drop player 2 in second column
			repeat(1) @(negedge clock);
			pressRight();//shift it to 1st column (col 0)
			repeat(2) @(negedge clock);
			pressRight();//shift it to 2nd column (col 1)
			repeat(2) @(negedge clock);
			pressRight();//shift it to 2nd column (col 1)
			repeat(2) @(negedge clock);
			enter(); //drop player 2 in second column
			repeat(1) @(negedge clock);
			pressRight();//shift it to 1st column (col 0)
			repeat(2) @(negedge clock);
			pressRight();//shift it to 2nd column (col 1)
			repeat(2) @(negedge clock);
			pressRight();//shift it to 2nd column (col 1)
			repeat(2) @(negedge clock);
			pressRight();//shift it to 2nd column (col 1)
			repeat(2) @(negedge clock);
			enter(); //drop player 2 in second column
			repeat(4) @(negedge clock);
			
		end 	
		repeat(12) @(negedge clock);
			winflag= dutC.WIN.winflag;
		repeat(2) @(posedge clock);
			#1
			VerT: assert(winflag== 1'd1)
				$display("The Vertical Test player Works!");
				else $display("The Vertical Test player Failed!");
	endtask 
	
	
	task check();
		@(negedge clock);
		tempV = dutC.WIN.ver;
		tempH = dutC.WIN.hor;
		tempLD = dutC.WIN.Rdiag;
		tempRD = dutC.WIN.Ldiag;
		winflag= dutC.WIN.winflag;
		@(posedge clock);
		#1
		if(tempV)
		begin 
			ver1: assert(winflag== 1'd1)
				$display("The Vertical Test player Works!");
				else $display("The Vertical Test player Failed!");
		end 
		else if(tempH)
		begin 
			hor1: assert(winflag== 1'd1)
				$display("The horizontal Test player Works!");
				else $display("The Vertical Test player Failed!");
		end 
		else if(tempLD)
		begin 
			LD1: assert(winflag== 1'd1)
				$display("The left Diagnol Test player Works!");
				else $display("The left diagnol Test player Failed!");
		end 
		else if(tempRD)
		begin 
			RD1: assert(winflag== 1'd1)
				$display("The right Diagnol Test player Works!");
				else $display("The right Diagnol Test player Failed!");
		end 
	endtask 
	
	
	task reset();
		@(negedge clock);
			rst = 1'b0;
		repeat(2) @(negedge clock);
			rst = 1'b1;
	endtask
	
	initial 
	begin 
	
		// for(int i=0; i<10000; i++)
		// begin 
			// randomDiagR();
			// randomDiagL();
			// randomVer();
			// randomHor();
		// end 	
		// testVer(1);
		// reset();
		// testVer(2);
		// reset();
		// testHor(1);
		// reset();
		// testHor(2);
		// reset();
		// testDiagL(1);
		// reset();
		// testDiagR(2);
		// reset();
		// testDiagL(2);
		// reset();
		// testDiagR(1);
		
		testV();
		
		
		$stop;
	end 
endmodule  