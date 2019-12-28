module mag(input logic [5:0] INPUT, output logic [5:0] MAG_RESULT, output logic NEG_FLAG);
	always_comb 
	begin 
		case(INPUT[5])
			1'b0:
			begin 
				MAG_RESULT <= INPUT;
				NEG_FLAG <= 1'b0; 
			end	
			1'b1:
			begin 
				MAG_RESULT <= (~INPUT+1);
				NEG_FLAG <= 1'b1;
			end
			default: 
			begin 	
				MAG_RESULT <= 6'b000000;
				NEG_FLAG <= 1; //impossible case a negative zero. If something goes wrong it will display this 
			end 
		endcase 
	end
endmodule 