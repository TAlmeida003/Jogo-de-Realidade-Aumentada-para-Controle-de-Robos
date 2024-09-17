module io_avalon_interface (
    input clk, rst_n,
    input [11:0] input_data,

    // Avalon MM interface
    input address, read, write, chipselect,
    input [31:0] writedata,
    output [31:0] readdata,
    output waitrequest,
	 output [7:0] leds
);

    wire wr, done_aux;

    assign wr = write & chipselect;
    assign waitrequest = done_aux || read;

    top_input_controller tbc(
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(wr),
        /*I*/ .in_data(input_data),
        /*I*/ .register_addr(address),
        /*I*/ .wr_data(writedata),
        /*O*/ .rd_data(readdata),
        /*O*/ .done(done_aux),
		  /*O*/ .leds(leds)
    );
    
endmodule