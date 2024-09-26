module select_read_data #(
    parameter DATA_WIDTH = 64
) (
    input  wire [DATA_WIDTH - 1:0] reg_control, reg_data_io, reg_interrupt,
    input  wire [1:0]              read_addr,
    output wire [DATA_WIDTH - 1:0] read_data
);

	

    assign read_data = (read_addr == 2) ? reg_interrupt : 
							  (read_addr == 1) ? reg_control : 
							  (read_addr == 0) ? reg_data_io : 
							  {DATA_WIDTH{1'b0}};
endmodule