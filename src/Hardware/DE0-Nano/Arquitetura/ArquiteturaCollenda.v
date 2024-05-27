// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Thu Feb 22 16:51:47 2024"

module ArquiteturaCollenda(
	b_button,
	y_button,
	x_button,
	start_button,
	select_button,
	main_clk,
	reset,
	a_button,
	tr_button,
	tl_button,
	direction_analogic,
	rdempty_A,
	rdempty_B,
	wrfull_A,
	wrfull_B,
	out_hsync,
	out_vsync,
	B,
	G,
	R
);


input wire	b_button;
input wire	y_button;
input wire	x_button;
input wire	start_button;
input wire	select_button;
input wire	main_clk;
input wire	reset;
input wire	a_button;
input wire	tr_button;
input wire	tl_button;
input wire	[3:0] direction_analogic;
output wire	rdempty_A;
output wire	rdempty_B;
output wire	wrfull_A;
output wire	wrfull_B;
output wire	out_hsync;
output wire	out_vsync;
output wire	[2:0] B;
output wire	[2:0] G;
output wire	[2:0] R;

wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_33;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	[31:0] SYNTHESIZED_WIRE_16;
wire	[31:0] SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_23;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_27;
wire	SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_30;

assign	rdempty_A = SYNTHESIZED_WIRE_19;
assign	rdempty_B = SYNTHESIZED_WIRE_18;
assign	wrfull_A = SYNTHESIZED_WIRE_9;
assign	wrfull_B = SYNTHESIZED_WIRE_8;




FIFO	b2v_dataA(
	.wrreq(SYNTHESIZED_WIRE_31),
	.wrclk(main_clk),
	.rdreq(SYNTHESIZED_WIRE_32),
	.rdclk(SYNTHESIZED_WIRE_33),
	.data(SYNTHESIZED_WIRE_3),
	.wrfull(SYNTHESIZED_WIRE_9),
	.rdempty(SYNTHESIZED_WIRE_19),
	.q(SYNTHESIZED_WIRE_16));


FIFO	b2v_dataB(
	.wrreq(SYNTHESIZED_WIRE_31),
	.wrclk(main_clk),
	.rdreq(SYNTHESIZED_WIRE_32),
	.rdclk(SYNTHESIZED_WIRE_33),
	.data(SYNTHESIZED_WIRE_7),
	.wrfull(SYNTHESIZED_WIRE_8),
	.rdempty(SYNTHESIZED_WIRE_18),
	.q(SYNTHESIZED_WIRE_17));

assign	SYNTHESIZED_WIRE_28 = SYNTHESIZED_WIRE_8 | SYNTHESIZED_WIRE_9;


debounce_block	b2v_inst1(
	.clk(main_clk),
	.PB_A(a_button),
	.PB_B(b_button),
	.PB_Y(y_button),
	.PB_X(x_button),
	.PB_TL(tl_button),
	.PB_TR(tr_button),
	.PB_Start(start_button),
	.PB_Select(select_button),
	.Out_A(SYNTHESIZED_WIRE_21),
	.Out_B(SYNTHESIZED_WIRE_22),
	.Out_Y(SYNTHESIZED_WIRE_30),
	.Out_X(SYNTHESIZED_WIRE_29),
	.Out_TL(SYNTHESIZED_WIRE_26),
	.Out_TR(SYNTHESIZED_WIRE_27),
	.OUt_Start(SYNTHESIZED_WIRE_25),
	.Out_Select(SYNTHESIZED_WIRE_24));


clock_pll	b2v_inst2(
	.inclk0(main_clk),
	.c0(SYNTHESIZED_WIRE_33),
	.c1(SYNTHESIZED_WIRE_34)
	);

assign	SYNTHESIZED_WIRE_14 =  ~reset;


pulseCounter	b2v_inst4(
	.clk(SYNTHESIZED_WIRE_34),
	.reset(SYNTHESIZED_WIRE_11),
	.screen(SYNTHESIZED_WIRE_23));
	defparam	b2v_inst4.MAX_VALUE = 419200;
	defparam	b2v_inst4.n_bits = 19;


video_processor	b2v_inst5(
	.clk_100(SYNTHESIZED_WIRE_33),
	.clk_25(SYNTHESIZED_WIRE_34),
	.reset(SYNTHESIZED_WIRE_14),
	.rdempty(SYNTHESIZED_WIRE_15),
	.dataA(SYNTHESIZED_WIRE_16),
	.dataB(SYNTHESIZED_WIRE_17),
	.out_hsync(out_hsync),
	.out_vsync(out_vsync),
	.out_rdreg(SYNTHESIZED_WIRE_32),
	.B(B),
	.G(G),
	.R(R));

assign	SYNTHESIZED_WIRE_15 = SYNTHESIZED_WIRE_18 | SYNTHESIZED_WIRE_19;


written_pulse	b2v_inst7(
	.clk(main_clk),
	.reset(reset),
	.start(SYNTHESIZED_WIRE_20),
	.pulse(SYNTHESIZED_WIRE_31));


Arquitetura	b2v_inst9(
	.a_button_export(SYNTHESIZED_WIRE_21),
	.b_button_export(SYNTHESIZED_WIRE_22),
	.clk_clk(main_clk),
	.reset_reset_n(reset),
	.screen_export(SYNTHESIZED_WIRE_23),
	.select_button_export(SYNTHESIZED_WIRE_24),
	.start_button_export(SYNTHESIZED_WIRE_25),
	.tl_button_export(SYNTHESIZED_WIRE_26),
	.tr_button_export(SYNTHESIZED_WIRE_27),
	.wrfull_export(SYNTHESIZED_WIRE_28),
	.x_button_export(SYNTHESIZED_WIRE_29),
	.y_button_export(SYNTHESIZED_WIRE_30),
	.direction_analogic_export(direction_analogic),
	.reset_pulsecounter_export(SYNTHESIZED_WIRE_11),
	.wrreg_export(SYNTHESIZED_WIRE_20),
	.data_a_export(SYNTHESIZED_WIRE_3),
	.data_b_export(SYNTHESIZED_WIRE_7));


endmodule
