module Control(input logic clk, rst, E, flag,
					input logic [2:0] colval, 
					output logic wen, win1, win2, FSM_rst, player,
					output logic [4:0] waddr);
					
logic [4:0] col0=5'd0;
logic [4:0] col1=5'd0;
logic [4:0] col2=5'd0;
logic [4:0] col3=5'd0;
logic [4:0] col4=5'd0;
logic [4:0] col5=5'd0;
logic [4:0] col6=5'd0;
logic [4:0] col7=5'd6;//always at 6 coins so that it is above all other cells (just in case)
logic Player=1'b1;//1=1st player 0=2nd player

logic [4:0] coltemp;

logic [1:0] temp=2'd0;
	
always_ff @(posedge clk)
begin

if(temp==2'd0)
begin
	case(colval)
	3'd0:
		coltemp=col0;
	3'd1:
		coltemp=col1;
	3'd2:
		coltemp=col2;
	3'd3:
		coltemp=col3;
	3'd4:
		coltemp=col4;
	3'd5:
		coltemp=col5;
	3'd6:
		coltemp=col6;
	3'd7:
		coltemp=col7;
	default: coltemp=col1;
	endcase
end


//if Enter is pushed and the column is not full and the column is not start

	if((E==1'b1)&&(coltemp!=5'd6)&&(colval!=3'd7)&&(temp==2'd0))
		begin
			coltemp = coltemp+5'd1; //the coin column now has one more coin
			
		//how high the coin is in the column
			waddr=5'd31-(coltemp-5'd1)*5'd4;
			
			wen=1'b0;
			FSM_rst=1'b1;
			temp=2'd1;
			case(colval)
				3'd0:
					col0<=col0+5'd1;
				3'd1:
					col1<=col1+5'd1;
				3'd2:
					col2<=col2+5'd1;
				3'd3:
					col3<=col3+5'd1;
				3'd4:
					col4<=col4+5'd1;
				3'd5:
					col5<=col5+5'd1;
				3'd6:
					col6<=col6+5'd1;
				default: col7<=5'd6;
				endcase
				
		end
	else if(temp==2'd1)
	begin
	temp=2'd2;
	FSM_rst=1'b1;
	wen=1'b1;
	end
	else if(temp==2'd2)
	begin
	temp=2'd0;
	FSM_rst=1'b0;
	wen=1'b0;
	if(Player==1'b1)//toggle players after a coin drop
			Player<=1'b0;
			else
			Player<=1'b1;
	end
		
	else
		begin
		col7<=5'd6;
		waddr<=5'd7;//always place the pre-dropped coin at the top of screen
		wen<=1'b1;//enable write
		//send in data 
		FSM_rst<=1'b1;
		end
end

		
always_ff @(posedge clk)
begin

	if(flag==1'b1&&Player==1'b0) //player 1 wins
	begin
		win1<=1'b1;
	end

	else if(flag==1'b1&&Player==1'b1) //player 2 wins
	begin
		win2<=1'b1;
	end
	
	else
	begin
			win1<=1'b0;
			win2<=1'b0;
	end
		
end

assign player=Player;
					
endmodule 