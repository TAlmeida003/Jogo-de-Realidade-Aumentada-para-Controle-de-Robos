module comparator_module(
	input wire        clk,
	input wire        reset,
	input wire [31:0] r1,
	input wire [31:0] r2,
	input wire [31:0] r3,
	input wire [31:0] r4,
	input wire [31:0] r5,
	input wire [31:0] r6,
	input wire [31:0] r7,
	input wire [31:0] r8,
	input wire [31:0] r9,
	input wire [31:0] r10,
	input wire [31:0] r11,
	input wire [31:0] r12,
	input wire [31:0] r13,
	input wire [31:0] r14,
	input wire [31:0] r15,
	input wire [31:0] r16,
	input wire [31:0] r17,
	input wire [31:0] r18,
	input wire [31:0] r19,
	input wire [31:0] r20,
	input wire [31:0] r21,
	input wire [31:0] r22,
	input wire [31:0] r23,
	input wire [31:0] r24,
	input wire [31:0] r25,
	input wire [31:0] r26,
	input wire [31:0] r27,
	input wire [31:0] r28,
	input wire [31:0] r29,
	input wire [31:0] r30,
	input wire [31:0] r31,
	input wire [19:0] check,
	input wire        refresh_comp,
	input wire        refresh_select,
	output reg [31:0] readData
);

wire [31:0] result;
wire [31:0] value;
/*Bloco combinacional para realizacao de comparaçoes entre valores de entrada e valores armazenados nos registradores*/

mod_comparator #( .size_reg(32), .size_check(20) , .x_init(19), .x_fim(28), .y_init(9), .y_fim(18), .sprLine(20) )
mod_comparator_inst
(
	.clk(clk),
	.reset(reset),
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
	.check(check) ,	        // input [size_check-1:0] check
	.refresh(refresh_comp), //input compare
	.out_result(result)	
);

data_select data_select_inst
(
	.result(result) ,	// input [size_reg-1:0] result_sig
	.r1(r1) ,	// input [size_reg-1:0] r1_sig
	.r2(r2) ,	// input [size_reg-1:0] r2_sig
	.r3(r3) ,	// input [size_reg-1:0] r3_sig
	.r4(r4) ,	// input [size_reg-1:0] r4_sig
	.r5(r5) ,	// input [size_reg-1:0] r5_sig
	.r6(r6) ,	// input [size_reg-1:0] r6_sig
	.r7(r7) ,	// input [size_reg-1:0] r7_sig
	.r8(r8) ,	// input [size_reg-1:0] r8_sig
	.r9(r9) ,	// input [size_reg-1:0] r9_sig
	.r10(r10) ,	// input [size_reg-1:0] r10_sig
	.r11(r11) ,	// input [size_reg-1:0] r11_sig
	.r12(r12) ,	// input [size_reg-1:0] r12_sig
	.r13(r13) ,	// input [size_reg-1:0] r13_sig
	.r14(r14) ,	// input [size_reg-1:0] r14_sig
	.r15(r15) ,	// input [size_reg-1:0] r15_sig
	.r16(r16) ,	// input [size_reg-1:0] r16_sig
	.r17(r17) ,	// input [size_reg-1:0] r17_sig
	.r18(r18) ,	// input [size_reg-1:0] r18_sig
	.r19(r19) ,	// input [size_reg-1:0] r19_sig
	.r20(r20) ,	// input [size_reg-1:0] r20_sig
	.r21(r21) ,	// input [size_reg-1:0] r21_sig
	.r22(r22) ,	// input [size_reg-1:0] r22_sig
	.r23(r23) ,	// input [size_reg-1:0] r23_sig
	.r24(r24) ,	// input [size_reg-1:0] r24_sig
	.r25(r25) ,	// input [size_reg-1:0] r25_sig
	.r26(r26) ,	// input [size_reg-1:0] r26_sig
	.r27(r27) ,	// input [size_reg-1:0] r27_sig
	.r28(r28) ,	// input [size_reg-1:0] r28_sig
	.r29(r29) ,	// input [size_reg-1:0] r29_sig
	.r30(r30) ,	// input [size_reg-1:0] r30_sig
	.r31(r31) ,	// input [size_reg-1:0] r31_sig
	.register_read(value) 	// output [size_reg-1:0] register_read_sig
);


always @(posedge clk or negedge reset) begin
	if(!reset) begin
		readData <= 32'h00000001;
	end
	else begin
		if(refresh_select) begin
			readData <= value;
		end
		else begin
			readData <= readData;
		end
	end
end

endmodule
