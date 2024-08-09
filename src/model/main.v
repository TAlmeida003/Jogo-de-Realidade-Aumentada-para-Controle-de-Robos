module main (
    input wire [11:0] butoes,
    input wire clk,
    output wire [7:0] leds,
);
    wire [31:0] register;
	top_edge_capture tec(
        .butoes(butoes[7:0]),
        .clk(clk),
        .we(0),
        .rd(1),
        .register_addr(2'b00),
        .wr_data(),
        .rd_data(register),
        .ready()
    );

    assign leds = register[7:0];

endmodule