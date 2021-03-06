`timescale 1ns/1ns
module testWin();
// DUT signals
	logic clock = 1'b0, winflag, Player, rst=1'b1; 
	logic [2:0] colval;

	logic [4:0] waddr;
	int unsigned r1, r2, r3;
	//board = dutWin.board;
	//output logic [1:0] board[6][7];
	// Connect device to test
	//winCheck dutWin( .board(board),   
	//			.winflag(winflag1));
	
	winCheckTEST dutWin(.clk(clock), .rst(rst), .Player(Player), .colval(colval),
		.waddr(waddr), .winflag(winflag));
	 
	 
	// Generate clock
	always #50 clock <= ~clock;
	
	task randomVer();
		reset();
		r1 = $urandom_range(6,0);
		r2 = $urandom_range(2,0);
		r3 = $urandom_range(1,0);
		
			@(negedge clock);  
				waddr = r2*4;
				Player=r3;
				colval=r1;	
			@(negedge clock);
				waddr = r2*4+4;
				Player=r3;
				colval=r1;
			@(negedge clock);
				waddr = r2*4+8;
				Player=r3;
				colval=r1;
			@(negedge clock);
				waddr = r2*4+12;
				Player=r3;
				colval=r1;	
				
			repeat(3) @(posedge clock);
				#1
				RandomVer: assert(winflag== 1'd1)
				$display("The Vertical Test player Works! Player:%d row:%d col:%d", r3, r2, r1 );
				else $display("The Vertical Test player Failed! Player:%d row:%d col:%d", r3, r2, r1);
			
	endtask 
	
	task randomHor();
		reset();
		r1 = $urandom_range(3,0);
		r2 = $urandom_range(5,0);
		r3 = $urandom_range(1,0);
		
			@(negedge clock);  
				waddr = r2*4;
				Player=r3;
				colval=r1;	
			@(negedge clock);
				waddr = r2*4;
				Player=r3;
				colval=r1+1;
			@(negedge clock);
				waddr = r2*4;
				Player=r3;
				colval=r1+2;
			@(negedge clock);
				waddr = r2*4;
				Player=r3;
				colval=r1+3;	
				
			repeat(3) @(posedge clock);
				#1
				RandomHor: assert(winflag== 1'd1)
				$display("The Horizontal Test player Works! Player:%d row:%d col:%d", r3, r2, r1 );
				else $display("The Horizontal Test player Failed! Player:%d row:%d col:%d", r3, r2, r1);
			
	endtask
	
	task randomDiagR();
		reset();
		r1 = $urandom_range(3,0);
		r2 = $urandom_range(2,0);
		r3 = $urandom_range(1,0);
		
			@(negedge clock);  
				waddr = r2*4;
				Player=r3;
				colval=r1;	
			@(negedge clock);
				waddr = r2*4+4;
				Player=r3;
				colval=r1+1;
			@(negedge clock);
				waddr = r2*4+8;
				Player=r3;
				colval=r1+2;
			@(negedge clock);
				waddr = r2*4+12;
				Player=r3;
				colval=r1+3;	
				
			repeat(3) @(posedge clock);
				#1
				RandomDiagR: assert(winflag== 1'd1)
				$display("The Diagonal Down Right Test player Works! Player:%d row:%d col:%d", r3, r2, r1 );
				else $display("The Diagonal Down Right Test player Failed! Player:%d row:%d col:%d", r3, r2, r1);
			
	endtask
	
	task randomDiagL();
		reset();
		r1 = $urandom_range(3,0);
		r2 = $urandom_range(5,3);
		r3 = $urandom_range(1,0);
		
			@(negedge clock);  
				waddr = r2*4;
				Player=r3;
				colval=r1;	
			@(negedge clock);
				waddr = r2*4-4;
				Player=r3;
				colval=r1+1;
			@(negedge clock);
				waddr = r2*4-8;
				Player=r3;
				colval=r1+2;
			@(negedge clock);
				waddr = r2*4-12;
				Player=r3;
				colval=r1+3;	
				
			repeat(3) @(posedge clock);
				#1
				RandomDiagL: assert(winflag== 1'd1)
				$display("The Diagonal Up Right Test player Works! Player:%d row:%d col:%d", r3, r2, r1 );
				else $display("The Diagonal Up Right Test player Failed! Player:%d row:%d col:%d", r3, r2, r1);
			
	endtask
	
	task testVer(int player);
		clear();
		if(player==1)
		begin 
			@(negedge clock);  
				waddr = 5'd4;
				Player=1'b1;
				colval=3'd2;
				
			@(negedge clock);
				waddr = 5'd8;
				Player=1'b1;
				colval=3'd2;
			@(negedge clock);
				waddr = 5'd12;
				Player=1'b1;
				colval=3'd2;
			@(negedge clock);
				waddr = 5'd16;
				Player=1'b1;
				colval=3'd2;	
				
			repeat(3) @(posedge clock);
				#1
				Ver: assert(winflag== 1'd1)
				$display("The Vertical Test player1 Works!");
				else $display("The Vertical Test player1 Failed");
		end 
		if(player==2) 
		begin 
			@(negedge clock);  
				waddr = 5'd8;
				Player=1'b0;
				colval=3'd3;
				
			@(negedge clock);
				waddr = 5'd12;
				Player=1'b0;
				colval=3'd3;
			@(negedge clock);
				waddr = 5'd16;
				Player=1'b0;
				colval=3'd3;
			@(negedge clock);
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd3;
			
			repeat(3) @(posedge clock);
				#1
				Ver2: assert(winflag== 1'd1)
				$display("The Vertical Test player2 Works!");
				else $display("The Vertical Test player2 Failed");
		end 
	endtask
	
	task testHor(int player);
		clear();
		if(player==1)
		begin
			@(negedge clock);  
				waddr = 5'd31;
				Player=1'b1;
				colval=3'd3;
			@(negedge clock);
				waddr = 5'd31;
				Player=1'b0;
				colval=3'd4;
			@(negedge clock);
				waddr = 5'd31;
				Player=1'b1;
				colval=3'd5;
			@(negedge clock);
				waddr = 5'd31;
				Player=1'b0;
				colval=3'd6;
			
			repeat(3) @(posedge clock);
				#1
				Hor: assert(winflag== 1'd1)
				$display("The Horizontal Test player1 Works!");
				else $display("The Horizontal Test player1 Failed");
		end 
		else if(player==2) 
		begin 
			@(negedge clock);  
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd0;
				
			@(negedge clock);
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd1;
			@(negedge clock);
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd2;
			@(negedge clock);
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd3;
			
			repeat(3) @(posedge clock);
				#1
				Hor2: assert(winflag== 1'd1)
				$display("The Horizontal Test player2 Works!");
				else $display("The Horizontal Test player2 Failed");
		end	
	endtask
	
	task testDiagR(int player);
		clear();
		if(player==1)
		begin
			@(negedge clock);  
				waddr = 5'd0;
				Player=1'b1;
				colval=3'd0;
				
			@(negedge clock);
				waddr = 5'd4;
				Player=1'b1;
				colval=3'd1;
			@(negedge clock);
				waddr = 5'd8;
				Player=1'b1;
				colval=3'd2;
			@(negedge clock);
				waddr = 5'd12;
				Player=1'b1;
				colval=3'd3;
			
			repeat(3) @(posedge clock);
				#1
				Diag: assert(winflag== 1'd1)
				$display("The Diag R Test player1 Works!");
				else $display("The Diag R Test player1 Failed");
		end 
		if(player==2) 
		begin 
			@(negedge clock);  
				waddr = 5'd8;
				Player=1'b0;
				colval=3'd3;
				
			@(negedge clock);
				waddr = 5'd12;
				Player=1'b0;
				colval=3'd4;
			@(negedge clock);
				waddr = 5'd16;
				Player=1'b0;
				colval=3'd5;
			@(negedge clock);
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd6;
			repeat(3) @(posedge clock);
				#1
				Diag2: assert(winflag== 1'd1)
				$display("The Diag R Test player2 Works!");
				else $display("The Diag R Test player2 Failed");
		end 
	endtask
	
	task testDiagL(int player);
		clear();
		if(player==1)
		begin
			@(negedge clock);  
				waddr = 5'd0;
				Player=1'b1;
				colval=3'd3;
				
			@(negedge clock);
				waddr = 5'd4;
				Player=1'b1;
				colval=3'd2;
			@(negedge clock);
				waddr = 5'd8;
				Player=1'b1;
				colval=3'd1;
			@(negedge clock);
				waddr = 5'd12;
				Player=1'b1;
				colval=3'd0;
			
			repeat(3) @(posedge clock);
				#1
				DiagL: assert(winflag== 1'd1)
				$display("The Diag L Test player1 Works!");
				else $display("The Diag L Test player1 Failed");
		end 
		if(player==2) 
		begin 
			@(negedge clock);  
				waddr = 5'd8;
				Player=1'b0;
				colval=3'd6;
				
			@(negedge clock);
				waddr = 5'd12;
				Player=1'b0;
				colval=3'd5;
			@(negedge clock);
				waddr = 5'd16;
				Player=1'b0;
				colval=3'd4;
			@(negedge clock);
				waddr = 5'd20;
				Player=1'b0;
				colval=3'd3;
			repeat(3) @(posedge clock);
				#1
				Diag2L: assert(winflag== 1'd1)
				$display("The Diag L Test player2 Works!");
				else $display("The Diag L Test player2 Failed");
		end 
	endtask
	
	task clear();
		@(negedge clock);
			for(int row=0; row<6; row++)
			begin
				for(int col=0; col<7; col++)
				begin 
					dutWin.board[row][col]=2'd0;
				end 
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
		testHor(1);

		
		
		$stop;
	end 
endmodule  