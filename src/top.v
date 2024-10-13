module top(
	input clk, button_reset,
	input wire DOWN, UP, RIGHT, LEFT, X, Y, A, B, TR, TL, START, SELECT,
	output [7:0] leds
);
	
	 wire        irq, wr;         //         irq.export
	 wire [31:0] rd_data_lsb; // rd_data_lsb.export
	 wire [31:0] rd_data_msb; // rd_data_msb.export
	 wire        we;         //          we.export
	 wire [31:0] we_data_lsb; // we_data_lsb.export
	 wire [31:0] we_data_msb;  // we_data_msb.expor
	
	 IO_contoller io(
		.clk_clk(clk),
		.reset_reset_n(button_reset),
		.irq_export(irq),         //         irq.export
		.rd_data_lsb_export(rd_data_lsb), // rd_data_lsb.export
		.rd_data_msb_export(rd_data_msb), // rd_data_msb.export
		.we_export(we),          //          we.export
		.we_data_lsb_export(we_data_lsb), // we_data_lsb.export
		.we_data_msb_export(we_data_msb)  // we_data_msb.export
	);
	wr_pulse wp(clk, we, button_reset, wr);
	
	io_avalon_interface ioai(
		.clk(clk),
		.rst_n(button_reset),
		.we(wr),
		.joystick({DOWN, UP, RIGHT, LEFT}),
		.buttons({X, Y, A, B, TR, TL, START, SELECT}),
		.writedata({we_data_msb, we_data_lsb}),
		.readdata({rd_data_msb, rd_data_lsb}),
		.irq(irq),
		.waitrequest(),
		.leds(leds)
	);

endmodule 