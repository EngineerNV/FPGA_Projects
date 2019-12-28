 module clockdivider(input logic iclk,
                    output logic clk);

    // define the parameter for number of clock edges to count
    const int HALF_OF_CLK_CYCLE_VALUE = 32'd1; //1.5MHz
    
    // internal variables for clock divider
    int count = 32'd0;
    logic clkstate = 1'b0;

    // generate clock signal
    always_ff @(posedge iclk)
        if(count == (HALF_OF_CLK_CYCLE_VALUE-1))
        begin
            // we have seen half of a cycle, toggle the clock
            count <= 32'd0;
            clkstate <= ~clkstate;
        end else begin
            count <= count + 32'd1;
            clkstate <= clkstate;
        end
        
    assign clk = clkstate;
    
 endmodule


