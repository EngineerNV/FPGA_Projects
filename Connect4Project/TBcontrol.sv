`timescale 1ns/1ns
module TBcontrol();

logic clk = 1'b0;
logic E = 1'b0;
logic flag=1'b0;
logic [2:0] colval =3'd0;
logic wen;
logic win1;
logic win2;
logic player;
logic [4:0] waddr;
logic FSM_rst;
int check1=1;
int col0, col1, col2, col3, col4, col5, col6, col7;
logic Player=1'b0;

Control CONT(.clk(clk), .E(E), .flag(flag),
					.colval(colval), 
					.wen(wen), .win1(win1), .win2(win2), .FSM_rst(FSM_rst), .player(player),
					.waddr(waddr));
					
always #50 clk<= ~clk;

task DropCoin(logic [2:0] cellnum); //0 to 6 with 7 being start
	@(negedge clk);
	begin
    colval<=cellnum;
	end
	
	//push ENTER

	@(negedge clk);
	begin
     E<=1'b1;
	end
	
	 @(negedge clk);
	begin
     E<=1'b0;
	end
	 
endtask



task randomizer();

//randomize column value
colval=$urandom_range(0,7);

//push enter
@(negedge clk);
	begin
     E<=1'b1;
	end
if(Player==1'b1)
Player=1'b0;
else if(Player==1'b0)
Player=1'b1;



 


@(negedge clk);
	begin
     E<=1'b0;
	

//increase the coins in that column of test variable
	








case (colval)
	3'd0:
		col1++;
	3'd1:
		col2++;
	3'd2:
		col3++;
	3'd3:
		col4++;
	3'd4:
		col5++;
	3'd5:
		col6++;
	3'd6:
		col7++;
	3'd7:
		col0=0;
	default: col1=0;
	endcase



	if(colval==3'd0)
		begin
			if((col1>6&&waddr==5'd7)||(waddr==(5'd31-(col1-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd1)
		begin
			if((col2>6&&waddr==5'd7)||(waddr==(5'd31-(col2-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd2)
		begin
			if((col3>6&&waddr==5'd7)||(waddr==(5'd31-(col3-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd3)
		begin
			if((col4>6&&waddr==5'd7)||(waddr==(5'd31-(col4-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd4)
		begin
			if((col5>6&&waddr==5'd7)||(waddr==(5'd31-(col5-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd5)
		begin
			if((col6>6&&waddr==5'd7)||(waddr==(5'd31-(col6-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd6)
		begin
			if((col7>6&&waddr==5'd7)||(waddr==(5'd31-(col7-5'd1)*5'd4)))
			check1=1;
			else check1=0;
		end
	else if(colval==3'd7&&(waddr==5'd7))
		begin
			check1=1;
		end
	
	else
		check1=0;


checkmessage: assert(check1);


	end







@(negedge clk);

endtask

initial 
begin
/*
dropCoin(3'd4); //1 in 4th slot should be player 2
	DropCoin(3'd4); //2 in 4th slot should be player 1
	DropCoin(3'd4); //3 in 4th slot should be player 2
	DropCoin(3'd4); //4 in 4th slot should be player 1
	DropCoin(3'd4); //5 in 4th slot should be player 2
	DropCoin(3'd4); //6 in 4th slot should be player 1
	DropCoin(3'd4); //full should be player 2
	DropCoin(3'd3); //1 in 3rd slot should be player 2
	DropCoin(3'd4); //full should be player 1
	DropCoin(3'd4); //full should be player 1
	DropCoin(3'd2); //1 in 2nd slot should be player 1
*/
for(int i=0; i<200; i++)
begin
	randomizer();
	 @(negedge clk);
end
	
end

endmodule 