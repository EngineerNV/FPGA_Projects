`timescale 1ns/1ns
module TBFSM_col();

logic clk = 1'b0;
logic L = 1'b0;
logic R = 1'b0;
logic [2:0] colval;
logic FSM_rst=1'b1;
logic rst=1'b1;
int temp;
int tim;
int colvalprev;
int check1;

FSM_Col FSM(.clk(clk), .rst(rst), .FSM_rst(FSM_rst), .L(L), .R(R), .colval(colval));
					
always #50 clk<= ~clk;

task Reset();
	@(negedge clk);
	begin
    rst=1'b0;
	end

	@(negedge clk);
	begin
     rst<=1'b1;
	end
endtask

task FSM_Reset();

	@(negedge clk);
	begin
    FSM_rst=1'b0;
	end

	@(negedge clk);
	begin
     FSM_rst<=1'b1;
	end

endtask


task Right();
	@(negedge clk);
	begin
    R=1'b1;
	end

	@(negedge clk);
	begin
     R<=1'b0;
	end
endtask

task Left();

	@(negedge clk);
	begin
    L=1'b1;
	end

	@(negedge clk);
	begin
     L<=1'b0;
	end

endtask






task randomize();

colvalprev=colval;
temp=$urandom_range(0, 1);

@(negedge clk);
if(temp==0)
begin
	R=1'b1;
	L=1'b0;
end
if(temp==1)
begin
	R=1'b0;
	L=1'b1;
end
@(negedge clk)

R=1'b0;
L=1'b0;

repeat(2) @(negedge clk);

if(temp==0&&colvalprev!=6&&colvalprev!=7&&colval==(colvalprev+1))
begin
	check1=1;//its ok
end

else if(temp==0&&colvalprev==6&&colval==colvalprev)
begin
	check1=1; //its ok
end

else if(temp==0&&colvalprev==7&&colval==0)
begin
	check1=1; //its ok
end


else if(temp==1&&colvalprev!=7&&colvalprev!=0&&colval==(colvalprev-1))
begin
	check1=1;//its ok
end

else if(temp==1&&colvalprev==7&&colval==colvalprev)
begin
	check1=1; //its ok
end

else if(temp==1&&colvalprev==0&&colval==0)
begin
	check1=1; //its ok
end
else //error
begin
	check1=0;
end


checkPlacement: assert(check1);


endtask




initial
begin
	
	FSM_Reset();
	/*
	Left(); //no left
	Right();
	Left();// no left
	Right();
	Left();
	Right();
	Right();
	Right();
	Right();
	Right();
	Right();
	Right();
	Right();
	Reset();
	Right();
	Right();
	FSM_Reset();
	*/

	for(int s=0; s<100;s++)
	begin
		randomize();
		repeat(2) @(negedge clk);
	end
	
end

endmodule 