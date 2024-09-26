module io_avalon_interface (
    input  wire         clk, rst_n, we,
    input  wire [3:0]   joystick, // DOWN, UP, RIGHT, LEFT,
    input  wire [7:0]   buttons,  // X, Y, A, B, TR, TL, START, SELECT
    input  wire [63:0]  writedata,
    output wire [63:0]  readdata,
    output wire         waitrequest,
	 output wire         irq, 
	 output wire [7:0]   leds
);
	 
    wire wr;
    assign wr = we & writedata[2];
    top_input_controller #(
	 /*P*/ .NUM_INPUTS(12),
			.DATA_WIDTH(64)
	 ) tbc(
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(wr),
        /*I*/ .in_data({joystick, buttons}),
        /*I*/ .register_addr(writedata[1:0]),
        /*I*/ .wr_data(writedata[63:3]),
        /*O*/ .rd_data(readdata),
        /*O*/ .done(waitrequest),
		/*O*/ .irq(irq),
		.leds(leds)
    );
    
endmodule