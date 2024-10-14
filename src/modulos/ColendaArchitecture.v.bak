module ColendaArchitecture(
	input wire	clk_50,
	input wire	reset,
	input wire  [31:0] dataA,
	input wire  [31:0] dataB,
	input wire	wrreg_export,
	input wire	reset_pulsecounter,
	output wire	wrfull_export,
	output wire	out_hsync,
	output wire	out_vsync,
	output wire	out_screen,
	output wire	[2:0] B,
	output wire	[2:0] G,
	output wire	[2:0] R,
	output wire outVgaClk
);

wire	clk_100;
wire	clk_25;
wire	out_fifoPulse;
wire	[31:0] outFifo_dataA;
wire	[31:0] outFifo_dataB;
wire	rdreq;
wire	wrfull_B;
wire	wrfull_A;
wire	rdempty;
wire	rdempty_B;
wire	rdempty_A;
wire	videoProcessor_reset;

FIFO	fifo_dataA(
	.wrreq(out_fifoPulse),
	.wrclk(clk_50),
	.rdreq(rdreq),
	.rdclk(clk_100),
	.data(dataA),
	.wrfull(wrfull_A),
	.rdempty(rdempty_A),
	.q(outFifo_dataA));


FIFO	fifo_dataB(
	.wrreq(out_fifoPulse),
	.wrclk(clk_50),
	.rdreq(rdreq),
	.rdclk(clk_100),
	.data(dataB),
	.wrfull(wrfull_B),
	.rdempty(rdempty_B),
	.q(outFifo_dataB));

clock_pll	b2v_inst2(
	.inclk0(clk_50),
	.c0(clk_100),
	.c1(clk_25)
	);

pulseCounter #(.MAX_VALUE(419200), .n_bits(19))
b2v_inst4(
	.clk(clk_25),
	.reset(reset_pulsecounter),
	.screen(out_screen)
);

video_processor	b2v_inst5(
	.clk_100(clk_100),
	.clk_25(clk_25),
	.reset(videoProcessor_reset),
	.rdempty(rdempty),
	.dataA(outFifo_dataA),
	.dataB(outFifo_dataB),
	.out_hsync(out_hsync),
	.out_vsync(out_vsync),
	.out_rdreg(rdreq),
	.B(B),
	.G(G),
	.R(R));

written_pulse	b2v_inst7(
	.clk(clk_50),
	.reset(reset),
	.start(wrreg_export),
	.pulse(out_fifoPulse));

assign	videoProcessor_reset =  ~reset;
assign	wrfull_export = wrfull_B | wrfull_A;
assign	rdempty = rdempty_B | rdempty_A;
assign  outVgaClk = clk_25;

endmodule
