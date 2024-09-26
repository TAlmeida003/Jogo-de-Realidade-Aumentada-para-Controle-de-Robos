module io_avalon_interface (
    input wire        clk, rst_n,
    input wire [11:0] input_data,

    // Avalon MM interface
    input  wire        write, read, chipselect,
	 input  wire [1:0]  address,
    input  wire [31:0] writedata,
    output wire [31:0] readdata,
    output wire        waitrequest,
	 output wire        irq,
	 output wire [7:0] leds
);

    wire wr;

    assign wr = write & chipselect;
	 
    top_input_controller #(
	 /*P*/ .NUM_INPUTS(12),
			 .DATA_WIDTH(32)
	 ) tbc(
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(wr),
        /*I*/ .in_data(input_data),
        /*I*/ .register_addr(address),
        /*I*/ .wr_data(writedata),
        /*O*/ .rd_data(readdata),
        /*O*/ .done(waitrequest),
		  /*O*/ .leds(leds),
		  /*O*/ .irq(irq)
    );
    
endmodule