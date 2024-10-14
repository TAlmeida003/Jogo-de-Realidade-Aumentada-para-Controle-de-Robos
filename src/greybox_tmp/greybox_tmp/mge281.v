//altsyncram CBX_SINGLE_OUTPUT_FILE="ON" CLOCK_ENABLE_INPUT_A="BYPASS" CLOCK_ENABLE_OUTPUT_A="BYPASS" INTENDED_DEVICE_FAMILY=""Cyclone IV E"" NUMWORDS_A=16 OPERATION_MODE="SINGLE_PORT" OUTDATA_ACLR_A="NONE" OUTDATA_REG_A="CLOCK0" POWER_UP_UNINITIALIZED="FALSE" READ_DURING_WRITE_MODE_PORT_A="NEW_DATA_NO_NBE_READ" WIDTH_A=0 WIDTH_B=1 WIDTH_BYTEENA_A=1 WIDTH_BYTEENA_B=1 WIDTH_ECCSTATUS=3 WIDTHAD_A=4 WIDTHAD_B=1 address_a clock0 q_a
//VERSION_BEGIN 20.1 cbx_mgl 2020:06:05:13:25:21:SJ cbx_stratixii 2020:06:05:12:04:24:SJ cbx_util_mgl 2020:06:05:12:04:24:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2020  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.



//synthesis_resources = altsyncram 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mge281
	( 
	address_a,
	clock0,
	q_a) /* synthesis synthesis_clearbox=1 */;
	input   [3:0]  address_a;
	input   clock0;
	output   q_a;

	wire  wire_mgl_prim1_q_a;

	altsyncram   mgl_prim1
	( 
	.address_a(address_a),
	.clock0(clock0),
	.q_a(wire_mgl_prim1_q_a));
	defparam
		mgl_prim1.clock_enable_input_a = "BYPASS",
		mgl_prim1.clock_enable_output_a = "BYPASS",
		mgl_prim1.intended_device_family = ""Cyclone IV E"",
		mgl_prim1.numwords_a = 16,
		mgl_prim1.operation_mode = "SINGLE_PORT",
		mgl_prim1.outdata_aclr_a = "NONE",
		mgl_prim1.outdata_reg_a = "CLOCK0",
		mgl_prim1.power_up_uninitialized = "FALSE",
		mgl_prim1.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		mgl_prim1.width_a = 0,
		mgl_prim1.width_b = 1,
		mgl_prim1.width_byteena_a = 1,
		mgl_prim1.width_byteena_b = 1,
		mgl_prim1.width_eccstatus = 3,
		mgl_prim1.widthad_a = 4,
		mgl_prim1.widthad_b = 1;
	assign
		q_a = wire_mgl_prim1_q_a;
endmodule //mge281
//VALID FILE
