module button_avalon_interface (
    input clk, rst_n,
    input [7:0] buttons,

    // Avalon MM interface
    input address, read, write, chipselect,
    input [31:0] writedata,
    output [31:0] readdata,
    output waitrequest,
	 output [7:0] leds
);

    wire wr;

    assign wr = write & chipselect;

    top_button_controller tbc(
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(wr),
		  .rd(read),
        /*I*/ .buttons(buttons),
        /*I*/ .register_addr(address),
        /*I*/ .wr_data(writedata),
        /*O*/ .rd_data(readdata),
        /*O*/ .done(waitrequest),
		  /*O*/ .leds(leds)
    );
	 
    
endmodule