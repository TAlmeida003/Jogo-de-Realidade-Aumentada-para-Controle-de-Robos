
module IO_contoller (
	clk_clk,
	in_data_readdata,
	in_data_writebyteenable_n,
	reset_reset_n);	

	input		clk_clk;
	output	[7:0]	in_data_readdata;
	input	[11:0]	in_data_writebyteenable_n;
	input		reset_reset_n;
endmodule
