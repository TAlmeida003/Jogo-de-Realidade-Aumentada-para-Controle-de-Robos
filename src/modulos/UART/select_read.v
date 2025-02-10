module select_read #(
    parameter DATA_REG_BITS = 32
) (
    input [1:0] address,
    input [DATA_REG_BITS-1:0] reg_rx_data,
    input [DATA_REG_BITS-1:0] reg_control_data,
    input [DATA_REG_BITS-1:0] reg_mask_interruption,
    input [DATA_REG_BITS-1:0] reg_interruption_status,
    output [DATA_REG_BITS-1:0] read_data
);

    assign read_data = (address == 2'b00) ? reg_rx_data :
                       (address == 2'b01) ? reg_control_data :
                       (address == 2'b10) ? reg_mask_interruption 
														:reg_interruption_status;

endmodule