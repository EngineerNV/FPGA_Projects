module winCheckTEST( input logic clk, rst, Player, input logic [2:0] colval,
	input logic [4:0] waddr, output logic winflag);
		 
		int board[6][7];
		logic winV[3][7];
		logic winVcol[3];
		logic ver;
		logic [2:0] col=3'd7;
		logic winH[6][4];
		logic winHcol[6];
		logic hor;
		//logic win2[4][7];	
		
		logic RwinD[3][4];
		logic RwinDcol[3];
		logic Rdiag;
		
		logic LwinD[3][4];
		logic LwinDcol[3];
		logic Ldiag;
		
		//logic [4:0] row; 
		//assign row = ((waddr-11)/4);
		
		always_ff @(posedge clk)
		begin 
			
			
			// if(!rst)
			// begin 
				// for(int i=0; i<6; i++)
				// begin 
					// for(int j=0; j<7; j++)
						// board[i][j] <= 2'd0;
				// end		
			// end 
			/*else */
			if((((waddr-5'd11)/5'd4)<5'd6)&&(((waddr-5'd11)/5'd4)>=0)&&colval!=7)//check if it's out of bounds 
			begin 
				if(Player)
					board[((waddr-5'd11)/5'd4)][colval] <= 1;
				else
					board[((waddr-5'd11)/5'd4)][colval] <= 2;
			end
			
			
		end 
		
		always_comb
		begin
			
			for(int i = 0; i<3; i++)//vertical checking 
			begin 	
				for(int j = 0; j<7; j++)
					winV[i][j]=((board[i][j]==board[i+1][j])&&(board[i+1][j]==board[i+2][j])&&(board[i+2][j]==board[i+3][j])&&(board[i][j]!=2'd0)); 
			end 		
		end 
		always_comb//vertical compressing 
		begin
			for(int i=0; i<3; i++)
				winVcol[i] = (winV[i][0]||winV[i][1]||winV[i][2]||winV[i][3]||winV[i][4]||winV[i][5]||winV[i][6]);
		end 
		always_comb//vertical single variable
		begin 
			ver = (winVcol[0]||winVcol[1]||winVcol[2]); 		
		end
		
		always_comb //horrizontal checking 
		begin 
			for(int i = 0; i<6; i++) 
			begin 	
				for(int j = 0; j<4; j++)
					winH[i][j]=((board[i][j]==board[i][j+1])&&(board[i][j+1]==board[i][j+2])&&(board[i][j+2]==board[i][j+3])&&(board[i][j]!=2'd0)); 
			end
		end 
		always_comb
		begin 
			for(int i=0; i<6 ; i++)
				winHcol[i]= (winH[i][0]||winH[i][1]||winH[i][2]||winH[i][3]);
		end 
		always_comb
		begin
			hor = (winHcol[0]||winHcol[1]||winHcol[2]||winHcol[3]||winHcol[4]||winHcol[5]);
		end
		
		always_comb //diagnol checking right 
		begin 
			for(int i = 0; i<3; i++) 
			begin 	
				for(int j = 0; j<4; j++)
					RwinD[i][j]=((board[i][j]==board[i+1][j+1])&&(board[i+1][j+1]==board[i+2][j+2])&&(board[i+2][j+2]==board[i+3][j+3])&&(board[i][j]!=2'd0)); 
			end
		end 
		
		always_comb
		begin 
			for(int i=0; i <3; i++)
				RwinDcol[i] = (RwinD[i][0]||RwinD[i][1]||RwinD[i][2]||RwinD[i][3]);
		end 
		
		always_comb
		begin 
			Rdiag = (RwinDcol[0]||RwinDcol[1]||RwinDcol[2]);
		end 
		
		always_comb // diagnol checking left 
		begin 
			for(int i = 5; i>2; i--) 
			begin 	
				for(int j = 0; j<4; j++)
					LwinD[5-i][j]=((board[i][j]==board[i-1][j+1])&&(board[i-1][j+1]==board[i-2][j+2])&&(board[i-2][j+2]==board[i-3][j+3])&&(board[i][j]!=2'd0)); 
			end
		end 
		
		always_comb
		begin 
			for(int i=0; i <3; i++)
				LwinDcol[i] = (LwinD[i][0]||LwinD[i][1]||LwinD[i][2]||LwinD[i][3]);
		end 
		
		always_comb
		begin 
			Ldiag = (LwinDcol[0]||LwinDcol[1]||LwinDcol[2]);
		end 
		
		
		always_comb
		begin 
			if(Ldiag||Rdiag||hor||ver)
				winflag=1'b1;
			else 
				winflag=1'b0;
		end 
					
endmodule 