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
    wire [63:0] data_write;
    wire [1:0] addr;

    opcode_controller #(
        .WIDTH(64),
        .ARCHITECTURE(32)
    ) oc(
        /*I*/ .in_reg_data(writedata),
        /*I*/ .opcode(writedata[3:0]),
        /*O*/ .out_reg_data(data_write),
        /*O*/ .we(wr),
        /*O*/ .addr(addr)
    );

    top_input_controller #(
	    /*P*/ .NUM_INPUTS(12),
			/*P*/ .DATA_WIDTH(64)
	 ) tbc(
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(we & wr),
        /*I*/ .in_data({joystick, buttons}),
        /*I*/ .register_addr(addr),
        /*I*/ .wr_data(data_write),
        /*O*/ .rd_data(readdata),
        /*O*/ .done(waitrequest),
		  /*O*/ .irq(irq),
		.leds(leds)
    );
    
endmodule