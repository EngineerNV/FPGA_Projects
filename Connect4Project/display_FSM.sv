module display_FSM(input logic clk, rst, input logic [63:0] Hline, Lline, output logic [4:0] raddr,
output logic enable, R1, G1, B1, R2, G2, B2, Latch, ren, output logic [3:0] ABCD, output logic clko);

logic [4:0] rdaddr=5'd0;
logic [2:0] temp1, temp2;



logic incr_flag;

int i, index;

assign raddr=rdaddr;
		

//first 16 switches set first 4 LEDs for H line and 4 LEDs for low line

typedef enum logic [5:0] {idle, 

Bit0, Bit1, Bit2, Bit3, Bit4, Bit5, Bit6, Bit7, Bit8, Bit9, Bit10, Bit11, 
Bit12, Bit13, Bit14, Bit15, Bit16, Bit17, Bit18, Bit19, Bit20, Bit21, 
Bit22, Bit23, Bit24, Bit25, Bit26, Bit27, Bit28, Bit29, Bit30, Bit31,  

			Dissable, Incriment, Latchon, Enable, Pause1, Pause2, Pause3, Pause4} statetype;

statetype state, nextstate;

always_ff @(posedge clk or negedge rst)
		begin
			if(!rst)
			begin
				state <= idle;
			end
			else
				state <= nextstate;
		end
always_comb begin
	case(state)
	
		idle: 
				nextstate=Bit0;
				
		Bit0:
				nextstate=Bit1;
		Bit1:
				nextstate=Bit2;
		Bit2:
				nextstate=Bit3;
		Bit3:
				nextstate=Bit4;
		Bit4:
				nextstate=Bit5;
		Bit5:
				nextstate=Bit6;
		Bit6:
				nextstate=Bit7;
		Bit7:
				nextstate=Bit8;
		Bit8:
				nextstate=Bit9;
		Bit9:
				nextstate=Bit10;
		Bit10:
				nextstate=Bit11;
		Bit11:
				nextstate=Bit12;
		Bit12:
				nextstate=Bit13;
		Bit13:
				nextstate=Bit14;
		Bit14:
				nextstate=Bit15;
		Bit15:
				nextstate=Bit16;
		Bit16:
				nextstate=Bit17;
		Bit17:
				nextstate=Bit18;
		Bit18:
				nextstate=Bit19;
		Bit19:
				nextstate=Bit20;
		Bit20:
				nextstate=Bit21;
		Bit21:
				nextstate=Bit22;
		Bit22:
				nextstate=Bit23;
		Bit23:		
				nextstate=Bit24;
		Bit24:
				nextstate=Bit25;		
		Bit25:
				nextstate=Bit26;
		Bit26:
				nextstate=Bit27;
		Bit27:
				nextstate=Bit28;
		Bit28:
				nextstate=Bit29;
		Bit29:
				nextstate=Bit30;
		Bit30:
				nextstate=Bit31;
		Bit31:
				nextstate=Dissable;
		Dissable:
				nextstate=Incriment;
		Incriment:
				nextstate=Latchon;
		Latchon:
				nextstate=Enable;
		Enable:
				nextstate=Pause1;
		Pause1:
				nextstate=Pause2;
		Pause2:
				nextstate=Pause3;
		Pause3:
				nextstate=Pause4;
		Pause4:
				nextstate=Bit0;
	
		default: nextstate=idle;
	endcase
end

always_comb
begin
case(state)
	idle:
	begin
		enable<=1'b1;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=62;
		ren=1'b1;
	end


	Bit0:
	begin

		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=62;
		ren=1'b1;
	end

	
	Bit1:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=60;
		ren=1'b1;
	end

	Bit2:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=58;
		ren=1'b1;
	end

	Bit3:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=56;
		ren=1'b1;
	end

	Bit4:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=54;
		ren=1'b1;
	end

	Bit5:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=52;
		ren=1'b1;
	end

	Bit6:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=50;
		ren=1'b1;
	end

	Bit7:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=48;
		ren=1'b1;
	end

	Bit8:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=46;
		ren=1'b1;
	end

	Bit9:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=44;
		ren=1'b1;
	end

	Bit10:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=42;
		ren=1'b1;
	end

	Bit11:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=40;
		ren=1'b1;
	end

	Bit12:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=38;
		ren=1'b1;
	end

	Bit13:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=36;
		ren=1'b1;
	end

	Bit14:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=34;
		ren=1'b1;
	end

	Bit15:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=32;
		ren=1'b1;
	end
	
	Bit16:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=30;
			ren=1'b1;
	end

	Bit17:
	begin
		enable<=1'b0;  
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=28;
		ren=1'b1;
	end

	Bit18:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=26;
	ren=1'b1;
	end

	Bit19:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=24;
		ren=1'b1;
	end

	Bit20:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=22;
		ren=1'b1;
	end

	Bit21:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=20;
		ren=1'b1;
	end


	Bit22:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=18;
		ren=1'b1;
	end

	Bit23:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=16;
		ren=1'b1;
	end

	Bit24:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=14;
		ren=1'b1;
	end

	
	Bit25:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=12;
		ren=1'b1;
	end

	Bit26:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=10;
		ren=1'b1;
	end

	Bit27:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=8;
		ren=1'b1;
	end

	Bit28:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=6;
		ren=1'b1;
	end

	
	Bit29:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=4;
		ren=1'b1;
	end

	Bit30:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=2;
		ren=1'b1;
	end

	Bit31:
	begin
		enable<=1'b0;   
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=0;
		ren=1'b1;
	end	
	
	Dissable:
	begin
		enable<=1'b1;
		Latch<=1'b0;
		incr_flag<=1'b1;
		index<=7;
		ren=1'b0;
	end
	
	Incriment:
	begin
		enable<=1'b1;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b0;
	end
	
	Latchon:
	begin
		enable<=1'b1;
		Latch<=1'b1;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b0;
	end

	Enable:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b1;
	end
	
	Pause1:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b1;
	end
	
	Pause2:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b1;
	end
	
	Pause3:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b1;
	end
	
	Pause4:
	begin
		enable<=1'b0;
		Latch<=1'b0;
		incr_flag<=1'b0;
		index<=7;
		ren=1'b1;
	end
	
			default: begin
							enable<=1'b0;
							Latch<=1'b0;
							incr_flag<=1'b0;
							index<=62;
							ren=1'b0;
						end
endcase
end

//incrimenter


assign ABCD=rdaddr-5'd1;


always_ff @(posedge clk)
begin

	if(incr_flag==1'b1)
	begin
		if(rdaddr<5'd15)
		rdaddr<=rdaddr+5'd1;
		else
		rdaddr<=5'd0;

			
		end
end

always_comb
begin
if(index!=7)
clko<=~clk;
else
clko<=1'b0;
end


assign temp1[1]=Hline[index+1];
assign temp1[0]=Hline[index];
assign temp2[1]=Lline[index+1];
assign temp2[0]=Lline[index];

always_comb
begin
	if(index==7)
	begin
		temp1[2]<=1'b1;
		temp2[2]<=1'b1;
	end
	
	else
	begin
		temp1[2]<=1'b0;
		temp2[2]<=1'b0;
	end
end

always_comb
begin

			case(temp1)
			2'd0:
				begin
					R1<=1'b0;
					G1<=1'b0;
					B1<=1'b0;
				end
			2'd1:
				begin
					R1<=1'b0;
					G1<=1'b0;
					B1<=1'b1;
				end
			2'd2:
				begin
					R1<=1'b1;
					G1<=1'b0;
					B1<=1'b0;
				end
			2'd3:
				begin
					R1<=1'b1;
					G1<=1'b1;
					B1<=1'b1;
				end
				default: begin
							R1<=1'b0;//default we get green pixel :O
							G1<=1'b0;
							B1<=1'b0;
							end
				endcase

end

//set data lines for low line
always_comb
begin
			case(temp2)
			2'd0:
				begin
					R2<=1'b0;
					G2<=1'b0;
					B2<=1'b0;
				end
			2'd1:
				begin
					R2<=1'b0;
					G2<=1'b0;
					B2<=1'b1;
				end
			2'd2:
				begin
					R2<=1'b1;
					G2<=1'b0;
					B2<=1'b0;
				end
			2'd3:
				begin
					R2<=1'b1;
					G2<=1'b1;
					B2<=1'b1;
				end
				default: begin
							R2<=1'b0;//default we get green pixel :O
							G2<=1'b0;
							B2<=1'b0;
							end
				endcase
end

endmodule

