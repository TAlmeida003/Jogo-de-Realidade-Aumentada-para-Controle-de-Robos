module main (
    input                     clk, rst_n,
    input    [7:0]  buttons,
    output [7:0] leds
);
    
	 
    button bt( .clk_clk(clk),
	            .reset_reset_n(rst_n), 
					.buttons_write(buttons), 
					.buttons_readdata(leds));
	 
endmodule