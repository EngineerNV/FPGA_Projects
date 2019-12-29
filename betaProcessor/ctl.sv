module ctl(input logic reset, irq, sv_bit, z,
                  input logic [5:0] opCode,
                  input logic [5:0] funct,
                  output logic ALUSrc, RegWrite, b_ctrl, ASel,
				  output logic [1:0] pc_ctrl, jump, RegDst,
                  output logic MemWrite,MemRead,MemToReg,
                  output logic [4:0] ALUOp);
	
	always_comb
	begin 
		if(reset)
		begin
			ASel <= 1'b0;
			ALUOp <= 5'b00000;
			RegDst <= 2'b00;
			RegWrite <= 2'b00;
			ALUSrc <= 1'b0;
			MemWrite <= 1'b0;
			MemRead <= 1'b0;
			MemToReg <= 1'b0;
			pc_ctrl <= 2'b01;
			jump <= 2'b01;
			b_ctrl <= 0;
		end
		else if(irq ==1 && sv_bit==0) //&& sv_bit == 1 )
		begin 
			ALUOp <= 5'b01010;
			RegDst <= 2'b11; // xp 
			RegWrite <= 1'b1;
			ALUSrc <= 1'b0;
			MemWrite <= 1'b0;
			MemRead <= 1'b0;
			MemToReg <= 1'b0;
			pc_ctrl <= 2'd3; // interrupt
			jump <= 2'b01;
			b_ctrl <= 0;
			ASel <= 1'b1;	
		end 
		else
		begin 
			case(opCode)
				6'b0: // r-format	
					case(funct)
						6'b0: //SLL
						begin 
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b01000;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b1;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 	
						6'b000010: //SRL
						begin 
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b01001;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b1;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 	
						6'b000011: //SRA
						begin
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b01011;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b1;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
						6'b101010: //SLT
						begin 
						    ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b00111;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end
						6'b001000: //jump register 
						begin 
						    ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b01010;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'd2;
							b_ctrl <= 0;
						end	
						6'b100000: //ADD
						begin 	
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b00000;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
						6'b100010: //SUB
						begin 	
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b00001;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end
						6'b100100: //AND
						begin 	
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b11000;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
						6'b100101: //OR
						begin 	
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b11110;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
						6'b100110: //XOR
						begin 
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b10110;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
						6'b100111: //NOR
						begin 	
							ASel <= 1'b0;
							pc_ctrl <= 2'd0;
							ALUOp <= 5'b10001;
							RegDst <= 2'b00;
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
						default:
						begin 	
							ASel <= 1'b1;
							pc_ctrl <= 2'd2; // illegal command signal
							RegDst <= 2'b11; //Xp save to Xp 
							RegWrite <= 1'b1;
							ALUSrc <= 1'b0; 
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							MemToReg <= 1'b0;
							ALUOp <= 5'b00000;
							jump <= 2'b01;
							b_ctrl <= 0;
						end 
					endcase 
				
				6'b001000: //addi
				begin	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b00000;
					RegDst <= 2'b01;
					RegWrite <= 1'b1;
					ALUSrc <= 1'b1;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					b_ctrl <= 0;
				end 
				6'b001100: //andi
				begin	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b11000;
					RegDst <= 2'b01;
					RegWrite <= 1'b1;
					ALUSrc <= 1'b1;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					b_ctrl <= 0;
				end 
				6'b001101: //ori
				begin 	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b11110;
					RegDst <= 2'b01;
					RegWrite <= 1'b1;
					ALUSrc <= 1'b1;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					b_ctrl <= 0;
				end 
				6'b001110: //xori
				begin	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b10110;
					RegDst <= 2'b01;
					RegWrite <= 1'b1;
					ALUSrc <= 1'b1;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					b_ctrl <= 0;
				end 
				6'b100011: //load word LW
				begin 	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b00000;
					RegDst <= 2'b01;
					RegWrite <= 1'b1;
					ALUSrc <= 1'b1;
					MemWrite <= 1'b0;
					MemRead <= 1'b1;
					MemToReg <= 1'b1;
					jump <= 2'b01;
					b_ctrl <= 0;
				end 
				6'b101011: //store word SW
				begin 	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b00000;
					RegDst <= 2'b00;
					RegWrite <= 1'b0;
					ALUSrc <= 1'b1;
					MemWrite <= 1'b1;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					b_ctrl <= 0;
				end 
				6'b000100: //Branch Equal
				begin 	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b00001;
					RegDst <= 2'b00;
					RegWrite <= 1'b0;
					ALUSrc <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					if(z == 1'b1)
					begin 
						b_ctrl <= 1'b1;
					end
					else 
					begin 
						b_ctrl <= 1'b0;
					end 
				end
				6'b000101: //Branch Not Equal 
				begin 	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b00001;
					RegDst <= 2'b00;
					RegWrite <= 1'b0;
					ALUSrc <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b01;
					if(z == 1'b1)
					begin 
						b_ctrl <= 1'b0;
					end
					else 
					begin 
						b_ctrl <= 1'b1;
					end
				end
				6'b000010: //Jump 
				begin 	
					ASel <= 1'b0;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b01010;
					RegDst <= 2'b00;
					RegWrite <= 1'b0;
					ALUSrc <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b00;
					b_ctrl <= 0;					
				end
				6'b000011: //Jump and link 
				begin 	
					ASel <= 1'b1;
					pc_ctrl <= 2'd0;
					ALUOp <= 5'b01010;
					RegDst <= 2'b10; // choosing RA
					RegWrite <= 1'b1;
					ALUSrc <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 2'b00; // jump 
					b_ctrl <= 0;
				end
				default: //illegal command
				begin
					ASel <= 1'b1;
					pc_ctrl <= 2'd2; // illegal command signal
					RegDst <= 2'b11; //save to Xp
					RegWrite <= 1'b1;
					ALUSrc <= 1'b0; 
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					MemToReg <= 1'b0;
					ALUOp <= 5'b00000;
					jump <= 2'b01; // dont jump 
					b_ctrl <= 0; 
				end 
			endcase
		end 		
	end 
endmodule 