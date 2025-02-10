
module Arquitetura (
	clk_clk,
	cts_beginbursttransfer,
	data_a_export,
	data_b_export,
	irq_joystick_export,
	rd_joystick_lsb_export,
	rd_joystick_msb_export,
	reset_reset_n,
	reset_pulsecounter_export,
	rts_writeresponsevalid_n,
	rx_beginbursttransfer,
	screen_export,
	tx_writeresponsevalid_n,
	we_joystick_export,
	we_joystick_lsb_export,
	we_joystick_msb_export,
	wrfull_export,
	wrreg_export);	

	input		clk_clk;
	input		cts_beginbursttransfer;
	output	[31:0]	data_a_export;
	output	[31:0]	data_b_export;
	input	[7:0]	irq_joystick_export;
	input	[31:0]	rd_joystick_lsb_export;
	input	[31:0]	rd_joystick_msb_export;
	input		reset_reset_n;
	output		reset_pulsecounter_export;
	output		rts_writeresponsevalid_n;
	input		rx_beginbursttransfer;
	input		screen_export;
	output		tx_writeresponsevalid_n;
	output		we_joystick_export;
	output	[31:0]	we_joystick_lsb_export;
	output	[31:0]	we_joystick_msb_export;
	input		wrfull_export;
	output		wrreg_export;
endmodule
