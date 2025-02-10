module ArquiteturaCollenda (	
	input wire main_clk, reset,
	input wire DOWN, UP, RIGHT, LEFT, X, Y, A, B_button, TR, TL, START, SELECT,
	input wire rx, cts,
	
	output wire [7:0] leds,
	output wire	rdempty_A, rdempty_B,wrfull_A,wrfull_B,out_hsync, out_vsync,
	output wire	[2:0] B, G, R,
	output wire tx, rts
);


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

	 wire        irq, wr;         //         irq.export
	 wire [31:0] rd_data_lsb; // rd_data_lsb.export
	 wire [31:0] rd_data_msb; // rd_data_msb.export
	 wire        we;         //          we.export
	 wire [31:0] we_data_lsb; // we_data_lsb.export
	 wire [31:0] we_data_msb;  // we_data_msb.expor


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
	.clk_clk(main_clk),
	.reset_reset_n(reset),
	.screen_export(SYNTHESIZED_WIRE_23),
	.wrfull_export(SYNTHESIZED_WIRE_28),
	.reset_pulsecounter_export(SYNTHESIZED_WIRE_11),
	.wrreg_export(SYNTHESIZED_WIRE_20),
	.data_a_export(SYNTHESIZED_WIRE_3),
	.data_b_export(SYNTHESIZED_WIRE_7),
	.irq_joystick_export(irq),     
	.rd_joystick_lsb_export(rd_data_lsb),   
	.rd_joystick_msb_export(rd_data_msb),
	.we_joystick_export(we),        
	.we_joystick_lsb_export(we_data_lsb),   
	.we_joystick_msb_export(we_data_msb),
	.tx_writeresponsevalid_n(tx),
	.rx_beginbursttransfer(rx),
	.rts_writeresponsevalid_n(rts),
	.cts_beginbursttransfer(cts),
);

	wr_pulse wp(main_clk, we, reset, wr);
	
	io_avalon_interface ioai(
		.clk(main_clk),
		.rst_n(reset),
		.we(wr),
		.joystick({DOWN, UP, RIGHT, LEFT}),
		.buttons({X, Y, A, B_button, TR, TL, START, SELECT}),
		.writedata({we_data_msb, we_data_lsb}),
		.readdata({rd_data_msb, rd_data_lsb}),
		.irq(irq),
		.waitrequest(),
		.leds(leds)
	);


endmodule
