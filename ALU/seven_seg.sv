module seven_seg(input logic [3:0] INPUT, output logic [6:0] led);
	always_comb 
	begin 
		case(INPUT)
			6'b0000:
				led <= 7'b1000000;//0
			6'b0001:
				led <= 7'b1111001;//1
			6'b0010:
				led <= 7'b0100100;//2
			6'b0011:
				led <= 7'b0110000;//3
			6'b0100:
				led <= 7'b0011001;//4
			6'b0101:
				led <= 7'b0010010;//5
			6'b0110:
				led <= 7'b0000010;//6
			6'b0111:
				led <= 7'b1111000;//7
			6'b1000:
				led <= 7'b0000000;//8
			6'b1001:
				led <= 7'b0010000;//9
			default: led <= 1111111; // nothing
		endcase 
	end
endmodule 