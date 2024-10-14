module CollisionTest();

integer num_clocks = 3100;
reg clock;
reg enable;
//---------Mobile sprite registers--------
reg [31:0] r0;
reg [31:0] r1;
reg [31:0] r2;
reg [31:0] r3;
reg [31:0] r4;
reg [31:0] r5;
reg [31:0] r6;
reg [31:0] r7;
reg [31:0] r8;
reg [31:0] r9;
reg [31:0] r10;
reg [31:0] r11;
reg [31:0] r12;
reg [31:0] r13;
reg [31:0] r14;
//-----------------------------------------
//---------Fixed sprite registers----------
reg [31:0] r15;
reg [31:0] r16;
reg [31:0] r17;
reg [31:0] r18;
reg [31:0] r19;
reg [31:0] r20;
reg [31:0] r21;
reg [31:0] r22;
reg [31:0] r23;
reg [31:0] r24;
reg [31:0] r25;
reg [31:0] r26;
reg [31:0] r27;
reg [31:0] r28;
reg [31:0] r29;
reg [31:0] r30;
reg [31:0] r31;

wire [29:0] out_flags;

always begin //frequência de impressão da tela (25 MHz)
	clock = 1'b0;
	#20;
	clock = 1'b1;
	#20;
end

initial begin
	// Colocar R0  em colisão com R1  (móvel com móvel)
	// Colocar R2  em colisão com R16 (móvel com fixo)
	// Colocar R3  em colisão com R4 e R17 (móvel com fixo ao mesmo tempo)
	// Colocar R13 em colisão com R18 (móvel com fixo)
	// Colocar R9  em colisão com R10 e R31 (móvel com fixo ao mesmo tempo)
	// Initializing values of the sprites.
	//Saída esperada: 001000000111000000001111100101
	r0  = 32'b00100011011100001101110000000000;    //x = 110, y = 110
	r1  = 32'b00100011110000001111000000000000;    //x = 120, y = 120
	r2  = 32'b00100110010000011001000000000000;    //x = 200, y = 200
	r3  = 32'b00101001011000100101100000000000;    //x = 300, y = 300
	r4  = 32'b00101001101100100110110000000000;    //x = 310, y = 310 
	r5  = 32'd0;
	r6  = 32'd0;
	r7  = 32'd0;
	r8  = 32'd0;
	r9  = 32'b00101010111100101011110000000000;     //x = 350, y = 350
	r10 = 32'b00101011010000101101000000000000;     //x = 360, y = 360
	r11 = 32'd0;
	r12 = 32'd0;
	r13 = 32'b00101100100000110010000000000000;     //x = 400, y = 400
	r14 = 32'd0;
	r15 = 32'd0;
	r16 = 32'b00100110100100011010010000000000;     //x = 210, y = 210
	r17 = 32'b00101001100010100101110000000000;     //x = 305, y = 302 
	r18 = 32'b00101100110100110011010000000000;     //x = 410, y = 410
	r19 = 32'd0;
	r20 = 32'd0;
	r21 = 32'd0;
	r22 = 32'd0;
	r23 = 32'd0;
	r24 = 32'd0;
	r25 = 32'd0;
	r26 = 32'd0;
	r27 = 32'd0;
	r28 = 32'd0;
	r29 = 32'd0;
	r30 = 32'd0;
	r31 = 32'b00101010011110101001111000000000;       //x = 335, y = 335
	enable = 1'b1; //Activates the collision module.
	repeat(num_clocks) @(posedge clock);
	$display("Saida esperada 001000000111000000001111100101",);
	$display("Saida gerada %b", out_flags);
	$stop;
end

collision collision_inst(
	.clk(clock),
	.reset(1'b1),
	.mod_enable(enable),
	//---------Mobile sprite registers--------
	.s_r0(r0),
	.s_r1(r1),
	.s_r2(r2),
	.s_r3(r3),
	.s_r4(r4),
	.s_r5(r5),
	.s_r6(r6),
	.s_r7(r7),
	.s_r8(r8),
	.s_r9(r9),
	.s_r10(r10),
	.s_r11(r11),
	.s_r12(r12),
	.s_r13(r13),
	.s_r14(r14),
	//-----------------------------------------
	//---------Fixed sprite registers----------
	.s_r15(r15),
	.s_r16(r16),
	.s_r17(r17),
	.s_r18(r18),
	.s_r19(r19),
	.s_r20(r20),
	.s_r21(r21),
	.s_r22(r22),
	.s_r23(r23),
	.s_r24(r24),
	.s_r25(r25),
	.s_r26(r26),
	.s_r27(r27),
	.s_r28(r28),
	.s_r29(r29),
	.s_r30(r30),
	.s_r31(r31),
	//----------Collision Flags---------------
	.flags(out_flags)
);

endmodule