module pc(input logic clk, reset, b_ctrl, stall,  
	input logic [1:0] pc_ctrl, jump, 
	input logic [31:0] sign_ext, id, radata,
	output logic [31:0] ia, ia_plus4); 
	
	logic [31:0] branch_result;
	logic [31:0] jump_result, concat, pc_result;
	
	always_ff @ (posedge clk or posedge reset)
	begin
		if(reset)
		begin 
			ia <= 32'h80000000;
		end 
		else 
		begin 
			ia <= pc_result;
		end 
	end
	
	assign ia_plus4 = ia + 32'd4; // grabing next instruction 
	assign concat = {ia_plus4[31:28],id[25:0],2'd0};
	
	// edits for project 4 - Branch logic Mux (b_ctrl signal) 
	always_comb
	begin 
		if(b_ctrl) // branching  b_ctrl  == 1  next_instruction + sign extend
		begin 
			branch_result <= ia_plus4 + (sign_ext<<2); 
		end 
		else //no branching 
		begin 
			branch_result <= ia_plus4;
		end
	end 
	
	// Jump logic Mux (jump signal)
	always_comb
	begin 
		if(jump == 2'd2) // jump register 
		begin 
			if(ia[31] == 1'b0) //pc bit is 0
			begin 
				jump_result <= {ia[31],radata[30:0]};
			end 
			else // old pc bit is not 0
			begin 
				jump_result <= radata;
			end 
		end 
		else if(jump == 2'd1) // branching  
		begin 
			jump_result <=  branch_result;
		end 
		else // default we use concatenation for regular jump  
		begin 
			jump_result <= concat;
		end 
	end
	//PC mux to IA 
	always_comb
	begin 
		if(stall) // we need to stall instructions 
		begin
			pc_result <= ia;
		end 
		else if(pc_ctrl == 2'd3) // sees xADR interrupt 
		begin 
			pc_result <= 32'h80000008;
		end 
		else if(pc_ctrl == 2'd2) // sees illegal ILL_OP
		begin 
			pc_result <= 32'h80000004;
		end 
		else if(pc_ctrl == 2'd1) // reset set pc 
		begin 
			pc_result <= 32'h80000000;
		end 
		else // pc_ctrl is 0  
		begin 
			pc_result <= jump_result;
		end 
	end 
endmodule