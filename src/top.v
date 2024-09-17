module top(
	input clk, button_reset,
	input wire DOWN, UP, RIGHT, LEFT, X, Y, A, B, TR, TL, START, SELECT,
	output [7:0] leds
);
	
	 IO_contoller io(
		.clk_clk(clk),                   //     clk.clk
		.in_data_writebyteenable_n({DOWN, UP, RIGHT, LEFT, X, Y, A, B, TR, TL, START, SELECT}), // in_data.writebyteenable_n
		.in_data_readdata(leds),
		.reset_reset_n(button_reset)
	);


endmodule 