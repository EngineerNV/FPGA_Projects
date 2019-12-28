module split(input logic [14:0] data, output logic [2:0] control, 
		output logic [5:0] A, B);
	always_comb
	begin 
		control <= data[14:12];
		A<= data[11:6];
		B<= data[5:0];
	end 	
endmodule 