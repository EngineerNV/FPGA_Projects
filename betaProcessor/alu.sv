module alu(input logic signed [31:0] A, B,
	input logic [4:0] ALUOp,
	output logic signed [31:0] Y,
	output logic z, v, n);
	//signal declarations
	logic [31:0] boolout, arithout, compout;
	logic signed [31:0] shiftout;
	//Module declatations 
	bool xbool(ALUOp[3:0],A,B,boolout);
	arith xarith(ALUOp[1:0],A,B,arithout,z,v,n);
	comp xcomp(ALUOp[3],ALUOp[1],z,v,n,compout);
	shift xshift(ALUOp[1:0],A,B[4:0],shiftout);
	always_comb
	begin 
		if(ALUOp[4] == 1'b1)//bool
		begin 
			//bool xbool(ALUOp[3:0],A,B,boolout);
			Y = boolout;
		end 
		else if(ALUOp[3:2] == 2'b10) //shift 
		begin
			//shift xshift(ALUOp[1:0],A,B[4:0],shiftout);
			Y = shiftout;
		end
		else if(ALUOp[2] == 1'b1) //CMP 
		begin 
			//arith xarith(ALUOp[1:0],A,B,arithout,z,v,n);
			//comp xcomp(ALUOp[3],ALUOp[1],z,v,n,compout);
			Y = compout;
		end 
		else //add or subtract  
		begin 
			//arith xarith(ALUOp[1:0],A,B,arithout,z,v,n);
			Y = arithout;
		end 
	end
	
	
	//output assignment
	//assign Y= shiftout;
	//assign z= 1'b0;
	//assign v= 1'b0;
	//assign n= 1'b0;
endmodule