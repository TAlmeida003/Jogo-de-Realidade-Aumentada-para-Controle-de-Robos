module full_register_file (
	input wire 		  clk,
	input wire 		  reset,
	input wire [4:0]  n_reg,
	input wire [19:0] check,
	input wire 		  written,
	input wire [31:0] data,

	output wire [31:0] readData,
	output wire success
);

/*-----------Saídas do banco de registradores------------*/
wire [31:0] r0;
wire [31:0] r1;
wire [31:0] r2;
wire [31:0] r3;
wire [31:0] r4;
wire [31:0] r5;
wire [31:0] r6;
wire [31:0] r7;
wire [31:0] r8;
wire [31:0] r9;
wire [31:0] r10;
wire [31:0] r11;
wire [31:0] r12;
wire [31:0] r13;
wire [31:0] r14;
wire [31:0] r15;
wire [31:0] r16;
wire [31:0] r17;
wire [31:0] r18;
wire [31:0] r19;
wire [31:0] r20;
wire [31:0] r21;
wire [31:0] r22;
wire [31:0] r23;
wire [31:0] r24;
wire [31:0] r25;
wire [31:0] r26;
wire [31:0] r27;
wire [31:0] r28;
wire [31:0] r29;
wire [31:0] r30;
wire [31:0] r31;
/*------------------------------------------------------*/

/*------------------Banco de registradores-------------*/
registerFile 
registerFile_inst
(
	.clk(clk) ,			// input  clk
	.reset(reset) ,		// input  reset
	.n_reg(n_reg) ,		// input [4:0] n_reg
	.data(data) ,		// input [31:0] data
	.written(written) ,	// input  written
	.r0(r0) ,	// output [31:0] r0
	.r1(r1) ,	// output [31:0] r1
	.r2(r2) ,	// output [31:0] r2
	.r3(r3) ,	// output [31:0] r3
	.r4(r4) ,	// output [31:0] r4
	.r5(r5) ,	// output [31:0] r5
	.r6(r6) ,	// output [31:0] r6
	.r7(r7) ,	// output [31:0] r7
	.r8(r8) ,	// output [31:0] r8
	.r9(r9) ,	// output [31:0] r9
	.r10(r10) ,	// output [31:0] r10
	.r11(r11) ,	// output [31:0] r11
	.r12(r12) ,	// output [31:0] r12
	.r13(r13) ,	// output [31:0] r13
	.r14(r14) ,	// output [31:0] r14
	.r15(r15) ,	// output [31:0] r15
	.r16(r16) ,	// output [31:0] r16
	.r17(r17) ,	// output [31:0] r17
	.r18(r18) ,	// output [31:0] r18
	.r19(r19) ,	// output [31:0] r19
	.r20(r20) ,	// output [31:0] r20
	.r21(r21) ,	// output [31:0] r21
	.r22(r22) ,	// output [31:0] r22
	.r23(r23) ,	// output [31:0] r23
	.r24(r24) ,	// output [31:0] r24
	.r25(r25) ,	// output [31:0] r25
	.r26(r26) ,	// output [31:0] r26
	.r27(r27) ,	// output [31:0] r27
	.r28(r28) ,	// output [31:0] r28
	.r29(r29) ,	// output [31:0] r29
	.r30(r30) ,	// output [31:0] r30
	.r31(r31) ,	// output [31:0] r31
	.out_success(success) 	// output  success
);
/*-----------------------------------------------------------*/



/*Bloco combinacional para realizacao de comparaçoes entre valores de entrada e valores armazenados nos registradores*/

mod_comparator #( .size_reg(32), .size_check(20) , .x_init(19), .x_fim(28), .y_init(9), .y_fim(18), .sprLine(20) )
mod_comparator_inst
(
	.r0(r0) ,	// input [size_reg-1:0] r0
	.r1(r1) ,	// input [size_reg-1:0] r1
	.r2(r2) ,	// input [size_reg-1:0] r2
	.r3(r3) ,	// input [size_reg-1:0] r3
	.r4(r4) ,	// input [size_reg-1:0] r4
	.r5(r5) ,	// input [size_reg-1:0] r5
	.r6(r6) ,	// input [size_reg-1:0] r6
	.r7(r7) ,	// input [size_reg-1:0] r7
	.r8(r8) ,	// input [size_reg-1:0] r8
	.r9(r9) ,	// input [size_reg-1:0] r9
	.r10(r10) ,	// input [size_reg-1:0] r10
	.r11(r11) ,	// input [size_reg-1:0] r11
	.r12(r12) ,	// input [size_reg-1:0] r12
	.r13(r13) ,	// input [size_reg-1:0] r13
	.r14(r14) ,	// input [size_reg-1:0] r14
	.r15(r15) ,	// input [size_reg-1:0] r15
	.r16(r16) ,	// input [size_reg-1:0] r16
	.r17(r17) ,	// input [size_reg-1:0] r17
	.r18(r18) ,	// input [size_reg-1:0] r18
	.r19(r19) ,	// input [size_reg-1:0] r19
	.r20(r20) ,	// input [size_reg-1:0] r20
	.r21(r21) ,	// input [size_reg-1:0] r21
	.r22(r22) ,	// input [size_reg-1:0] r22
	.r23(r23) ,	// input [size_reg-1:0] r23
	.r24(r24) ,	// input [size_reg-1:0] r24
	.r25(r25) ,	// input [size_reg-1:0] r25
	.r26(r26) ,	// input [size_reg-1:0] r26
	.r27(r27) ,	// input [size_reg-1:0] r27
	.r28(r28) ,	// input [size_reg-1:0] r28
	.r29(r29) ,	// input [size_reg-1:0] r29
	.r30(r30) ,	// input [size_reg-1:0] r30
	.r31(r31) ,	// input [size_reg-1:0] r31
	.check(check) ,	// input [size_check-1:0] check
	.compare(written), 			//input compare
	.register_read(readData) 	// output [size_reg-1:0] register_read
);

endmodule