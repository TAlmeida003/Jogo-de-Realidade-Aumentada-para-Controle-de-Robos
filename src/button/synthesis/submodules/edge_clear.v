module edge_clear #(
    parameter DATA_WIDTH = 8
) (
    input  wire clk, rst_n, we, register_addr,
    output wire  [DATA_WIDTH-1:0] clr_reg
);

    wire pulse;

    assign pulse =  we & rst_n & !register_addr;

    assign clr_reg = (pulse) ? 8'b11111111 : 8'b00000000;

endmodule