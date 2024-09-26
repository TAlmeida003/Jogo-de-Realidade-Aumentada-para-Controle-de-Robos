
module IO_contoller (
	clk_clk,
	irq_export,
	rd_data_lsb_export,
	rd_data_msb_export,
	reset_reset_n,
	we_export,
	we_data_lsb_export,
	we_data_msb_export);	

	input		clk_clk;
	input		irq_export;
	input	[31:0]	rd_data_lsb_export;
	input	[31:0]	rd_data_msb_export;
	input		reset_reset_n;
	output		we_export;
	output	[31:0]	we_data_lsb_export;
	output	[31:0]	we_data_msb_export;
endmodule
