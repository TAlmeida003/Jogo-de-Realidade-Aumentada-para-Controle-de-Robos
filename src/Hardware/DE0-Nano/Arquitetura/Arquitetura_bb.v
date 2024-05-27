
module Arquitetura (
	a_button_export,
	b_button_export,
	clk_clk,
	data_a_export,
	data_b_export,
	direction_analogic_export,
	reset_reset_n,
	reset_pulsecounter_export,
	screen_export,
	select_button_export,
	start_button_export,
	tl_button_export,
	tr_button_export,
	wrfull_export,
	wrreg_export,
	x_button_export,
	y_button_export);	

	input		a_button_export;
	input		b_button_export;
	input		clk_clk;
	output	[31:0]	data_a_export;
	output	[31:0]	data_b_export;
	input	[3:0]	direction_analogic_export;
	input		reset_reset_n;
	output		reset_pulsecounter_export;
	input		screen_export;
	input		select_button_export;
	input		start_button_export;
	input		tl_button_export;
	input		tr_button_export;
	input		wrfull_export;
	output		wrreg_export;
	input		x_button_export;
	input		y_button_export;
endmodule
