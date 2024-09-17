
module IO_contoller (
	clk_clk,
	in_data_writebyteenable_n,
	in_data_readdata,
	reset_reset_n);	

	input		clk_clk;
	input	[11:0]	in_data_writebyteenable_n;
	output	[7:0]	in_data_readdata;
	input		reset_reset_n;
endmodule
