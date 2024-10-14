module mod_comparator #(parameter size_reg = 32, size_check = 20 ,x_init = 19, x_fim = 28, y_init = 9, y_fim = 18, sprLine = 20)
(
	input wire [size_reg-1:0] r0,
	input wire [size_reg-1:0] r1,
	input wire [size_reg-1:0] r2,
	input wire [size_reg-1:0] r3,
	input wire [size_reg-1:0] r4,
	input wire [size_reg-1:0] r5,
	input wire [size_reg-1:0] r6,
	input wire [size_reg-1:0] r7,
	input wire [size_reg-1:0] r8,
	input wire [size_reg-1:0] r9,
	input wire [size_reg-1:0] r10,
	input wire [size_reg-1:0] r11,
	input wire [size_reg-1:0] r12,
	input wire [size_reg-1:0] r13,
	input wire [size_reg-1:0] r14,
	input wire [size_reg-1:0] r15,
	input wire [size_reg-1:0] r16,
	input wire [size_reg-1:0] r17,
	input wire [size_reg-1:0] r18,
	input wire [size_reg-1:0] r19,
	input wire [size_reg-1:0] r20,
	input wire [size_reg-1:0] r21,
	input wire [size_reg-1:0] r22,
	input wire [size_reg-1:0] r23,
	input wire [size_reg-1:0] r24,
	input wire [size_reg-1:0] r25,
	input wire [size_reg-1:0] r26,
	input wire [size_reg-1:0] r27,
	input wire [size_reg-1:0] r28,
	input wire [size_reg-1:0] r29,
	input wire [size_reg-1:0] r30,
	input wire [size_reg-1:0] r31,
	input wire [size_check-1:0] check,
	input wire                  compare,

	output reg [size_reg-1:0] register_read
);

wire [31:0] result;

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_0
(
	.rg(r0) ,					// input [size_reg-1:0] rg_sig
	.check(check) ,			// input [size_check-1:0] check_sig
	.compare(compare) ,		// input  compare_sig
	.result(result[0]) 		// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_1
(
	.rg(r1) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[1]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_2
(
	.rg(r2) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[2]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_3
(
	.rg(r3) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[3]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_4
(
	.rg(r4) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[4]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_5
(
	.rg(r5) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[5]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_6
(
	.rg(r6) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[6]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_7
(
	.rg(r7) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[7]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_8
(
	.rg(r8) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[8]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_9
(
	.rg(r9) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[9]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_10
(
	.rg(r10) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[10]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_11
(
	.rg(r11) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[11]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_12
(
	.rg(r12) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[12]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_13
(
	.rg(r13) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[13]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_14
(
	.rg(r14) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[14]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_15
(
	.rg(r15) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[15]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_16
(
	.rg(r16) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[16]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_17
(
	.rg(r17) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[17]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_18
(
	.rg(r18) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[18]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_19
(
	.rg(r19) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[19]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_20
(
	.rg(r20) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[20]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_21
(
	.rg(r21) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[21]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_22
(
	.rg(r22) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[22]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_23
(
	.rg(r23) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[23]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_24
(
	.rg(r24) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[24]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_25
(
	.rg(r25) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[25]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_26
(
	.rg(r26) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[26]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_27
(
	.rg(r27) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[27]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_28
(
	.rg(r28) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[28]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_29
(
	.rg(r29) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[29]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_30
(
	.rg(r30) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[30]) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_31
(
	.rg(r31) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.compare(compare) ,	// input  compare_sig
	.result(result[31]) 	// output  result_sig
);

always @(*) begin
	if(result[0])    register_read = r0;
	else if(result[1])    register_read = r1;
	else if(result[2])    register_read = r2;
	else if(result[3])    register_read = r3;
	else if(result[4])    register_read = r4;
	else if(result[5])    register_read = r5;
	else if(result[6])    register_read = r6;
	else if(result[7])    register_read = r7;
	else if(result[8])    register_read = r8;
	else if(result[9])    register_read = r9;
	else if(result[10])   register_read = r10;
	else if(result[11])   register_read = r11;
	else if(result[12])   register_read = r12;
	else if(result[13])   register_read = r13;
	else if(result[14])   register_read = r14;
	else if(result[15])   register_read = r15;
	else if(result[16])   register_read = r16;
	else if(result[17])   register_read = r17;
	else if(result[18])   register_read = r18;
	else if(result[19])   register_read = r19;
	else if(result[20])   register_read = r20;
	else if(result[21])   register_read = r21;
	else if(result[22])   register_read = r22;
	else if(result[23])   register_read = r23;
	else if(result[24])   register_read = r24;
	else if(result[25])   register_read = r25;
	else if(result[26])   register_read = r26;
	else if(result[27])   register_read = r27;
	else if(result[28])   register_read = r28;
	else if(result[29])   register_read = r29;
	else if(result[30])   register_read = r30;
	else if(result[31])   register_read = r31;
	else register_read = 32'h00000001;
end

endmodule
