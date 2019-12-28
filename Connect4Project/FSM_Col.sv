module FSM_Col(input logic clk, rst, FSM_rst, L, R, output logic [2:0] colval);

typedef enum logic [3:0] {start, C0, C1, C2, C3, C4, C5, C6} statetype;
statetype state, nextstate;

always_ff @(posedge clk or negedge rst or negedge FSM_rst)
		begin
			if(!rst||!FSM_rst)
			begin
				state <= start;
			end
			else
				state <= nextstate;
		end
always_comb begin
	case(state)
	
		start: 
			if(R==1'b1)
				nextstate=C0;
			else 
				nextstate=start;
		C0:
			if(L==1'b1)
				nextstate=C0;
			else if(R==1'b1)
				nextstate=C1;
			else
				nextstate=C0;
		C1:
			if(L==1'b1)
				nextstate=C0;
			else if(R==1'b1)
				nextstate=C2;
			else
				nextstate=C1;
		C2:
			if(L==1'b1)
				nextstate=C1;
			else if(R==1'b1)
				nextstate=C3;
			else
				nextstate=C2;
		C3:
			if(L==1'b1)
				nextstate=C2;
			else if(R==1'b1)
				nextstate=C4;
			else
				nextstate=C3;
		C4:
			if(L==1'b1)
				nextstate=C3;
			else if(R==1'b1)
				nextstate=C5;
			else
				nextstate=C4;
		C5:
			if(L==1'b1)
				nextstate=C4;
			else if(R==1'b1)
				nextstate=C6;
			else
				nextstate=C5;
		
		C6:
			if(L==1'b1)
				nextstate=C5;
			else if(R==1'b1)
				nextstate=C6;
			else
				nextstate=C6;
	
	
		default: nextstate=start;
	endcase
end

always_comb
begin
case(state)
	start:
		colval<=3'd7;
	C0:
		colval<=3'd0;
	C1:
		colval<=3'd1;
	C2:
		colval<=3'd2;
	C3:
		colval<=3'd3;
	C4:
		colval<=3'd4;
	C5:
		colval<=3'd5;
	C6:
		colval<=3'd6;
	default: colval<=3'd7;
endcase
end
endmodule
