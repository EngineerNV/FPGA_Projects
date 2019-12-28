module Memory(input logic clk, rst, win1, win2, wen, ren, Player, input logic [2:0] colval,
	input logic [4:0] waddr, rdaddr, output logic [63:0] Hdataline, Ldataline);

logic [63:0] memory[31:0];//column then row
logic [5:0] column=6'd0; //6 bits for 64 bit wide entry
logic [1:0] player;


//initialize zeros and grid
initial
begin
		$readmemb("Initializer.txt.txt", memory);
end


always_comb
begin
	if(Player==1'b1)
		player<=2'd1;
	else
		player<=2'd2;
end

always_comb
begin
	case(colval)
		3'd0://column 1
			column<=6'd48;
		3'd1://column2
			column<=6'd40;
		3'd2:
			column<=6'd32;
		3'd3:
			column<=6'd24;
		3'd4:
			column<=6'd16;
		3'd5:
			column<=6'd8;
		3'd6:
			column<=6'd0;
		3'd7://start
			column<=6'd56;
			default: column<=6'd0;
	endcase
end

//columns bit to update	can be 48, 40, 32, 24, 16, 8, 0
//rows bit to update		can be 7, 11, 15, 19, 23, 27, 31

//---------------fills 6x3 memory cell for each "coin"----------------------

logic [4:0] waddr1, waddr2;
assign waddr1=waddr-5'd1;
assign waddr2=waddr-5'd2;
logic [5:0] col1, col2, col3, col4, col5;
assign col1=column+6'd1;
assign col2=column+6'd2;
assign col3=column+6'd3;
assign col4=column+6'd4;
assign col5=column+6'd5;


always_ff @(posedge clk)
	begin

		if(wen)
			begin
				//end column
				
				//bottom right cell
				memory[waddr] [column] <= player [0];
				memory[waddr] [col1] <= player [1];
				
				//bottom middle cell
				memory[waddr] [col2] <= player [0];
				memory[waddr] [col3] <= player [1];
				
				//bottom left cell
				memory[waddr] [col4] <= player [0];
				memory[waddr] [col5] <= player [1];
				
				//middle right cell
				memory[waddr1] [column] <= player [0];
				memory[waddr1] [col1] <= player [1];
				
				//middle middle cell
				memory[waddr1] [col2] <= player [0];
				memory[waddr1] [col3] <= player [1];
				
				//middle left cell
				memory[waddr1] [col4] <= player [0];
				memory[waddr1] [col5] <= player [1];
			
				//bottom right cell
				memory[waddr2] [column] <= player [0];
				memory[waddr2] [col1] <= player [1];
				
				//bottom middle cell
				memory[waddr2] [col2] <= player [0];
				memory[waddr2] [col3] <= player [1];
				
				//bottom left cell
				memory[waddr2] [col4] <= player [0];
				memory[waddr2] [col5] <= player [1];
			end
			
		if(ren)
			begin
				Hdataline <= memory[rdaddr]; //read upperline
				Ldataline <= memory[rdaddr+5'd16];//read lower line
			end


end



endmodule 
