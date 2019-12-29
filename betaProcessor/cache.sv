module cache(input logic clk, MemReadReady, MemRead, MemWriteDone, MemWrite,
				input logic [31:0] memAddr, MemReadData,  
				output logic MemReadDone, MemHit, stall, MemWriteReady,
				output logic [31:0] memData);
	
	logic valid [127:0];
	logic [6:0] index;
	logic [22:0] tags [127:0];
	logic [31:0] data [127:0];
	
	assign index = memAddr[8:2];
	
	always_ff @(posedge clk)
	begin 
		if(MemRead==1) // if we have a load word instruction 
		begin // testing 
			if(MemHit) // if we have a valid entry and a hit
			begin
				$display("HIT ON MemRead\n");
				memData <= data[index];
				MemReadDone <= 0;
				MemWriteReady <= 0;
			end
			else // we have a miss 
			begin
				$display("MISS ON MemRead\n");
				if(MemReadReady)
				begin 
					// we can read from memory and store to cache 
					memData <= MemReadData;
					tags[index] <= memAddr[31:9];
					data[index] <= MemReadData;
					valid[index] <= 1;	
					MemReadDone <=1;
					MemWriteReady <= 0;
				end 
				else 
				begin
					MemReadDone <= 0;
					MemWriteReady <=0;
				end 
			end 
		end
		else if(MemWrite==1)
		begin 
			if(MemHit) // if we have a valid entry and a hit
			begin 
				memData <= data[index]; 
				MemReadDone <= 0;
				MemWriteReady <= 0;
				$display("HIT ON MemWrite\n");
			end
			else // we have a miss 
			begin
				if(MemWriteDone)
				begin 
					$display("MISS ON MemWrite\n");
					// we can read from memory and store to cache 
					memData <= MemReadData;
					tags[index] <= memAddr[31:9];
					data[index] <= MemReadData;
					valid[index] <= 1;	
					MemReadDone <=0;
					MemWriteReady <= 1;
					
				end 
				else 
				begin
					MemReadDone <= 0;
					MemWriteReady <=0;
				end
			end
		end 
		else
		begin
			MemReadDone <= 0;
			MemWriteReady <=0;
		end
	end
	
	/*always_comb
	begin 
		if(MemRead )
		begin 
			
		end 
	end */ 
	
	
	assign stall = (MemRead & (MemReadReady | (!MemHit & !MemReadReady))) || (MemWrite & (MemWriteDone | (!MemHit & !MemWriteDone))) ;
	
	always_comb
	begin 
		if(tags[index] == memAddr[31:9] && valid[index])
		begin 
			MemHit <=1;
		end
		else 
		begin 
			MemHit <=0;
		end 
	end 
endmodule 