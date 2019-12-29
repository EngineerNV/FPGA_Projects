module beta(input logic clk, reset, irq, MemReadReady, MemWriteDone,
                     input logic [31:0] id, memReadData,
                     output logic [31:0] ia, memAddr, memWriteData,
                     output logic MemRead, MemWrite, MemReadDone, MemHit, MemWriteReady);
	logic [4:0] ALUOp;
	logic ALUSrc, ASel, RegWrite, b_ctrl, MemToReg, z, v, n, stall;
	logic [1:0] ALUb, pc_ctrl, jump, RegDst;
	logic signed [31:0] radata, rbdata, ALUout, wdata, A, B, pad_or_sign, sign_ext, ia_plus4, cache_out;
	
	//program counter 
	pc mod_pc(.clk(clk), .reset(reset), .b_ctrl(b_ctrl), .pc_ctrl(pc_ctrl), .jump(jump), 
		.sign_ext(sign_ext), .id(id), .radata(radata), .ia(ia), .ia_plus4(ia_plus4), .stall(stall));
	//control module for signals
	ctl mod_ctl( .reset(reset), .irq(irq), .sv_bit(ia[31]), .ASel(ASel),
                  .opCode(id[31:26]),
                  .funct(id[5:0]), .b_ctrl(b_ctrl), .z(z), .pc_ctrl(pc_ctrl), .jump(jump),
                  .RegDst(RegDst),.ALUSrc(ALUSrc),.RegWrite(RegWrite),
                  .MemWrite(MemWrite),.MemRead(MemRead),.MemToReg(MemToReg),
                  .ALUOp(ALUOp));
	//cache module 
	cache mod_cache( .clk(clk), .MemReadReady(MemReadReady), .MemRead(MemRead), .memAddr(memAddr), .MemReadData(memReadData), .MemReadDone(MemReadDone), 
		.MemHit(MemHit), .stall(stall), .memData(cache_out), .MemWriteDone(MemWriteDone), .MemWriteReady(MemWriteReady), .MemWrite(MemWrite) );
	
	//register module 			  
	regfile mod_regfile( .clk(clk), .RegWrite(RegWrite), .RegDst(RegDst),
		.ra(id[25:21]), .rb(id[20:16]), .rc(id[15:11]),
		.wdata(wdata),
		.radata(radata), .rbdata(rbdata));
	//ALU 
	alu mod_alu(.A(A), .B(B),
		.ALUOp(ALUOp),
		.Y(ALUout),
		.z(z), .v(v), .n(n));
	
	assign memWriteData = rbdata;
	assign memAddr = ALUout; // ALUout always provides the memAddr for the memory 
	
	//this mux will control what A value the ALU gets, ASel mux 
	always_comb
	begin 
		if(ASel)
		begin 
			A <= ia_plus4;
		end 
		else 
		begin 
			A <= radata;
		end 
	end 
	
	
	//this mux will control what B value the ALU gets 
	always_comb
	begin 
		if(ALUSrc)
		begin 
			B <= pad_or_sign;
		end 
		else
		begin 
			B <= rbdata;
		end 
	end 
	
	//this mux will map out the write data 
	always_comb
	begin 
		if(MemToReg)
		begin
			wdata <= cache_out;//memReadData;
		end 
		else 
		begin 
			wdata <= ALUout;
		end 
	end 
	
	//this mux will provide the control logic for the mux below by using op signals 
	always_comb 
	begin 
		if(id[28:26] >= 3'b100 ) // andi, ori, logical immediates
		begin 
			ALUb <= 2'b01;
		end 
		else if(id[31:29] >= 3'b001)// addi, lw, sw 
		begin 
			ALUb <= 2'b00;
		end 
		else //SLL, SRL etc  
		begin 
			ALUb <= 2'b11;
		end 
	end 
	
	always_comb // sign extension logic  
	begin 
		if(id[15] == 1'b1)
		begin 
			sign_ext <= {16'hFFFF,id[15:0]};
		end 
		else
		begin 
			sign_ext <= {16'b0, id[15:0]};
		end
	end 
	
	// this mux will provide zero padding, and sign extension 
	always_comb
	begin 
		if(ALUb == 2'b00) // sign extension 15:0
		begin 
			pad_or_sign <= sign_ext;
		end
		else if(ALUb == 2'b01) //zero padding 15:0 
		begin
			pad_or_sign <= {16'b0, id[15:0]};
		end 
		else //zero padding 10:6
		begin 
			pad_or_sign <= {27'b0,id[10:6]};
		end 
	end 
endmodule 