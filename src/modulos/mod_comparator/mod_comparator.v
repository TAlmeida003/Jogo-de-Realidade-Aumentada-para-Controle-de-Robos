module mod_comparator #(parameter size_reg = 32, size_check = 20 ,x_init = 19, x_fim = 28, y_init = 9, y_fim = 18, sprLine = 20)
(
	input wire                clk,
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
	input wire                  refresh,
	input wire                  reset,
	output reg [size_reg-1:0]   out_result
);

wire result_1;
wire result_2;
wire result_3;
wire result_4;
wire result_5;
wire result_6;
wire result_7;
wire result_8;
wire result_9;
wire result_10;
wire result_11;
wire result_12;
wire result_13;
wire result_14;
wire result_15;
wire result_16;
wire result_17;
wire result_18;
wire result_19;
wire result_20;
wire result_21;
wire result_22;
wire result_23;
wire result_24;
wire result_25;
wire result_26;
wire result_27;
wire result_28;
wire result_29;
wire result_30;
wire result_31;

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_1
(
	.rg(r1) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_1) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_2
(
	.rg(r2) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_2) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_3
(
	.rg(r3) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_3) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_4
(
	.rg(r4) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_4) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_5
(
	.rg(r5) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_5) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_6
(
	.rg(r6) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_6) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_7
(
	.rg(r7) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_7) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_8
(
	.rg(r8) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_8) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_9
(
	.rg(r9) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_9) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_10
(
	.rg(r10) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_10) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_11
(
	.rg(r11) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_11) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_12
(
	.rg(r12) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_12) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_13
(
	.rg(r13) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_13) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_14
(
	.rg(r14) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_14) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_15
(
	.rg(r15) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_15) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_16
(
	.rg(r16) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_16) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_17
(
	.rg(r17) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_17) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_18
(
	.rg(r18) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_18) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_19
(
	.rg(r19) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_19) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_20
(
	.rg(r20) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_20) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_21
(
	.rg(r21) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_21) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_22
(
	.rg(r22) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_22) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_23
(
	.rg(r23) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_23) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_24
(
	.rg(r24) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_24) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_25
(
	.rg(r25) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_25) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_26
(
	.rg(r26) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_26) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_27
(
	.rg(r27) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_27) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_28
(
	.rg(r28) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_28) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_29
(
	.rg(r29) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_29) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_30
(
	.rg(r30) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_30) 	// output  result_sig
);

comparator #(.size_reg(32), .size_check(20) , .x_inicio(x_init), .x_final(x_fim), .y_inicio(y_init), .y_final(y_fim), .spriteLine(sprLine))
comparator_inst_31
(
	.rg(r31) ,	// input [size_reg-1:0] rg_sig
	.check(check) ,	// input [size_check-1:0] check_sig
	.result(result_31) 	// output  result_sig
);

always @(posedge clk or negedge reset) begin
	if (!reset) begin
		out_result <= 32'd0;
	end
	else begin
		if(refresh) begin
			out_result[0]   <= result_1;
			out_result[1]   <= result_2;
			out_result[2]   <= result_3;
			out_result[3]   <= result_4;
			out_result[4]   <= result_5;
			out_result[5]   <= result_6;
			out_result[6]   <= result_7;
			out_result[7]   <= result_8;
			out_result[8]   <= result_9;
			out_result[9]	<= result_10;
			out_result[10] 	<= result_11;
			out_result[11] 	<= result_12;
			out_result[12] 	<= result_13;
			out_result[13] 	<= result_14;
			out_result[14] 	<= result_15;
			out_result[15] 	<= result_16;
			out_result[16] 	<= result_17;
			out_result[17] 	<= result_18;
			out_result[18] 	<= result_19;
			out_result[19] 	<= result_20;
			out_result[20] 	<= result_21;
			out_result[21] 	<= result_22;
			out_result[22] 	<= result_23;
			out_result[23] 	<= result_24;
			out_result[24] 	<= result_25;
			out_result[25] 	<= result_26;
			out_result[26] 	<= result_27;
			out_result[27] 	<= result_28;
			out_result[28] 	<= result_29;
			out_result[29] 	<= result_30;
			out_result[30] 	<= result_31;
			out_result[31]	<= 1'b0;
		end
	end
end

endmodule