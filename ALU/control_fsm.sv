module control_fsm(input logic clock, button, wren, full, empty, reset, 
	output logic wen, ren);
	typedef enum logic [1:0]	{IDLE, WRITE, READ}	statetype;
	statetype state=IDLE, nextstate;
	
	always_ff @(posedge clock or negedge reset)
	begin
		if(!reset)
			state<=IDLE;
		else 	
			state <= nextstate;
	end
	
	always_comb
	begin 
		case(state)
			IDLE:
				if(button==1 && empty==0 && wren==0)
					nextstate = READ;
				else if(button==1 && full==0 && wren==1)
					nextstate = WRITE;
				else
					nextstate = IDLE;
			WRITE:
				if(button==1 && empty==0 && wren==0)
					nextstate = READ;
				else if(button==1 && full==0 && wren==1)
					nextstate = WRITE;
				else
					nextstate = IDLE;
			READ:
				if(button==1 && empty==0 && wren==0)
					nextstate = READ;
				else if(button==1 && full==0 && wren==1)
					nextstate = WRITE;
				else
					nextstate = IDLE;
					
			default: nextstate = IDLE;
		endcase 
	end 
	
	always_comb
	begin 
		if(state==IDLE)
			begin 
				wen<=1'b0;
				ren<=1'b0;
			end
		else if(state==WRITE) 
			begin 
				wen<=1'b1;
				ren<=1'b0;
			end	
		else if(state==READ)
			begin 
				wen<=1'b0;
				ren<=1'b1;
			end 
		else 
			begin 
				wen<=1'b0;
				ren<=1'b0;
			end 
	end	
endmodule 