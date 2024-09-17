module select_read_data #(
    DATA_WIDTH = 32
) (
    input  wire [DATA_WIDTH - 1:0] reg_control, reg_data_io,
    input  wire                    read_addr,
    output wire [DATA_WIDTH - 1:0] read_data
);
    assign read_data = read_addr ? reg_data_io : reg_control;
endmodule