module uart_interface (
    // Avalon MM interface
    input clk, rst_n,
    input read, write, chipselect,
    input [1:0] address,
    input [31:0] writedata,
    output [31:0] readdata,
	 output irq,

    // UART interface
    input rx, cts,
    output tx, rts
);

    wire wr, rd;
    
    assign wr = write & chipselect;
    assign rd = read & chipselect;

    uart_unit uart_unit_inst (
        .address(address),
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .rd(rd),
        .wr(wr),
        .tx(tx),
        .wr_data(writedata),
        .rd_data(readdata),
        .cts(cts),
        .rts(rts),
		  .irq(irq)
    );

    
endmodule