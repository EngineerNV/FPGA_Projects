`timescale 1ns/1ns
module testALU();
// DUT signals
	logic clock = 1'b0, wren, button=1'b1, reset=1'b1, NEG_A, NEG_B, NEG_RESULT, OVERFLOW_FLAG, full, empty; 
	logic [14:0] data;
	logic [5:0] A, B, RESULT, tempA, tempB, temp, temp2;
	logic [2:0] control, tempC;
	logic [6:0] A_TENS, A_ONES, B_TENS, B_ONES, RESULT_TENS, RESULT_ONES;
	int fileHandle = $fopen("testlog.txt", "w"), fileHandle2 = $fopen("ResultCheck.txt", "w"), wrd, rd=0;
	int unsigned range, range2, temp4;
	int Atwo;//confirming it is taking in two's compliment  
	int Btwo;
	// Connect device to test
	 ALU dut_ALU(.clock(clock), .wren(wren), .button(button), .reset(reset), 
	.dataIn(data), .NEG_A(NEG_A), .NEG_B(NEG_B), .NEG_RESULT(NEG_RESULT), .OVERFLOW_FLAG(OVERFLOW_FLAG),
	.A_TENS(A_TENS), .A_ONES(A_ONES), .B_TENS(B_TENS), .B_ONES(B_ONES), .RESULT_TENS(RESULT_TENS), .RESULT_ONES(RESULT_ONES), 
	.full(full), .empty(empty), .RESULT(RESULT));
	
	// Generate clock
	always #50 clock <= ~clock;
	
	task pressbutton(input logic wr);
		range = $urandom_range(6,3);
		wren = wr;
		repeat (range) @(negedge clock);
		button = 1'b0;//pressing the button
		
		repeat(range) @(negedge clock);
		button = 1'b1;	
	endtask 
	
	
	task writeData(input int i);
		$fdisplay(fileHandle,"Performing Write");
		@(negedge clock);  
			A = $urandom_range(64,0);
			//A = temp;
			B = $urandom_range(64,0);
			//B = temp2;
			control = $urandom_range(7,0);
			//control = temp3;
			data[14:12] = control;
			data[11:6] = A;
			data[5:0]  = B; 
			pressbutton(1'b1);
			repeat(2) @(posedge clock);
			#1	
			case(control)
				3'd0:
					$fdisplay(fileHandle,"CASE:%d A:%b + B:%b ", i, A, B);
				3'd1:
					$fdisplay(fileHandle,"CASE:%d A:%b - B:%b ", i, A, B);
				3'd4:
					$fdisplay(fileHandle,"CASE:%d A:%b == B:%b ", i, A, B);		
				3'd5:
					$fdisplay(fileHandle,"CASE:%d A:%b > B:%b ", i, A, B);
				3'd6:
					$fdisplay(fileHandle,"CASE:%d A:%b < B:%b ", i, A, B);
				3'd7:
					$fdisplay(fileHandle,"CASE:%d A:%b == 0 ", i, A, B);
				default: 
					$fdisplay(fileHandle,"CASE:%d A:%b B:%b Invalid OP", i, A, B);
			endcase 
	endtask
	
	task readData(input int i);
		$fdisplay(fileHandle,"Performing Read");
		@(negedge clock);
			pressbutton(1'b0);
		repeat(2) @(posedge clock);
			#1
			$fdisplay(fileHandle,"CASE:%d RESULT:%b", i, RESULT);
			tempA=dut_ALU.A;
			tempB=dut_ALU.B;
			tempC= dut_ALU.control;
			
				if(3'd0==tempC)
				begin 
					//$fdisplay(fileHandle2,"CASE:%d A:%b + B:%b ", i, tempA, tempB);
					plus: assert(RESULT==(tempA+tempB))
					$display("The result for addition was correct CASE:%d A:%b + B:%b ", i, tempA, tempB);
					else $display("The result for addition was incorrect! CASE:%d A:%b + B:%b ", i, tempA, tempB);
				end 
				else if(3'd1 == tempC)
				begin 
					//$fdisplay(fileHandle2,"CASE:%d A:%b - B:%b ", i, tempA, tempB);
					sub: assert(RESULT==(tempA+(~(tempB)+1'b1)))
					$display("The result for subtraction was correct CASE:%d A:%b - B:%b ", i, tempA, tempB);
					else $display("The result for addition was incorrect! CASE:%d A:%b - B:%b ", i, tempA, tempB);
				end 
				else if(3'd4 == tempC)
				begin 
					//$fdisplay(fileHandle2,"CASE:%d A:%b == B:%b ", i, tempA, tempB);
					if(tempA == tempB)
					begin 
						ifequal: assert(RESULT==6'd1)
						$display("The result for equals was correct CASE:%d A:%b == B:%b ", i, tempA, tempB);
						else $display("The result for equals was incorrect! CASE:%d A:%b == B:%b ", i, tempA, tempB);
					end 
					else 
					begin 
						ifNequal: assert(RESULT==6'd0)
						$display("The result for not equals was correct CASE:%d A:%b == B:%b ", i, tempA, tempB);
						else $display("The result for not equals was incorrect! CASE:%d A:%b == B:%b ", i, tempA, tempB);
					end 
				end 
				else if(3'd5==tempC)
				begin 
					//$fdisplay(fileHandle2,"CASE:%d A:%b > B:%b ", i, tempA, tempB);
					if(tempA[5]==1)
					begin
						temp=~(tempA)+1;
						Atwo= -1*(temp);			
					end
					else 
						Atwo=tempA;
						
					if(tempB[5]==1)
					begin 
						temp2= ~(tempB)+1;
						Btwo= -1*(temp2);
					end 
					else
						Btwo=tempB;	
					
					if(Atwo > Btwo)
					begin 
						ifgreat: assert(RESULT==6'd1)
						$display("The result for greater than was correct CASE:%d A:%b > B:%b ", i, tempA, tempB);
						else $display("The result for greater than was incorrect! CASE:%d A:%b > B:%b ", i, tempA, tempB);
					end 
					else 
					begin 
						ifNgreat: assert(RESULT==6'd0)
						$display("The result for not greater than was correct CASE:%d A:%b > B:%b ", i, tempA, tempB);
						else $display("The result for not greater than was incorrect! CASE:%d A:%b > B:%b ", i, tempA, tempB);
					end
				end 		
				else if(3'd6==tempC)
				begin 
					//$fdisplay(fileHandle2,"CASE:%d A:%b < B:%b ", i, tempA, tempB);
					if(tempA[5]==1)
					begin
						temp=~(tempA)+1;
						Atwo= -1*(temp);			
					end
					else 
						Atwo=tempA;
						
					if(tempB[5]==1)
					begin 
						temp2= ~(tempB)+1;
						Btwo= -1*(temp2);
					end 
					else
						Btwo=tempB;	
					
					if(Atwo < Btwo)
					begin 
						ifless: assert(RESULT==6'd1)
						$display("The result for less than was correct CASE:%d A:%b < B:%b ", i, tempA, tempB);
						else $display("The result for less than was incorrect! CASE:%d A:%b < B:%b ", i, tempA, tempB);
					end 
					else 
					begin 
						ifNless: assert(RESULT==6'd0)
						$display("The result for not less than was correct CASE:%d A:%b < B:%b ", i, tempA, tempB);
						else $display("The result for not less than was incorrect! CASE:%d A:%b < B:%b ", i, tempA, tempB);
					end 
				end 
				else if(3'd7==tempC)
				begin 
					//$fdisplay(fileHandle2,"CASE:%d A:%b == 0 ", i, tempA, tempB);
					if(tempA == 6'd0)
					begin 
						ifEzero: assert(RESULT==6'd1)
						$display("The result for equal 0 was correct CASE:%d A:%b == 0 ", i, tempA);
						else $display("The result for equal 0 was incorrect! CASE:%d A:%b == 0 ", i, tempA);
					end 
					else 
					begin 
						ifNEzero: assert(RESULT==6'd0)
						$display("The result for not equal 0 was correct CASE:%d A:%b == 0 ", i, tempA);
						else $display("The result for not equal 0 was incorrect! CASE:%d A:%b == 0 ", i, tempA);
					end
				end 		
				else  
					$display("CASE:%d A:%b B:%b Invalid OP", i, tempA, tempB);
			
	endtask 
	
	task fill();
		$fdisplay(fileHandle,"Filling The FIFO");
		for(int i=0 ; i<8; i++)
		begin 	
			writeData(i);
		end
	endtask 
	
	task emptyIt();
		$fdisplay(fileHandle,"Emptying The FIFO");
		for(int i=0; i<8; i++)
		begin 
			readData(i);
		end 	
	endtask 
	
	task choose();
		range2=$urandom_range(1,0);
		if(range2)
		begin 
			if(!full)
			begin
				writeData(wrd);
				wrd++;
			end 	
			if(wrd==8)
			begin 
				wrd=0;
			end 
		end 	
		else
			begin 
			if(!empty)
			begin 
				readData(rd);
				rd++;
			end 	
				if(rd==8)
				begin 
					rd=0;
				end 	
			end 
	endtask
	
	task resetToggle();
		@(negedge clock);
		reset = ~(reset);
	endtask
	
	initial 
	begin 
	$fdisplay(fileHandle,"Starting FULL TEST");
		fill();
		emptyIt();
		$fdisplay(fileHandle,"BEGINNING LONG TEST ");
		temp4 = $urandom(89);
		
		for(int i=0; i<1000; i++)
			choose();
		emptyIt();
		$fdisplay(fileHandle,"Activating Reset");
		
		resetToggle();
		repeat(2) @(posedge clock);
		for(int i=0; i<30; i++)
			choose();
		resetToggle();
		
		fill();
		fill();
		fill();
		emptyIt();
		emptyIt();
		emptyIt();
		readData(0);
		writeData(2);
		readData(2);
		writeData(3);
		readData(3);
		
	$fdisplay(fileHandle,"Ending FULL TEST ");
	$stop;
	end 
	
	initial
	begin 
		$fmonitor(fileHandle, "wren:%b button:%b", wren, button);
		$fmonitor(fileHandle, "full:%b empty:%b", full, empty);
	end
endmodule  