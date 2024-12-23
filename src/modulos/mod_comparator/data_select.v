module data_select #(parameter size_reg = 32)
( 
	input wire [size_reg-1:0] result,
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

	output reg [size_reg-1:0] register_read
);
always @(*) begin
	if(result[0])    	  register_read = r1;
	else if(result[1])    register_read = r2;
	else if(result[2])    register_read = r3;
	else if(result[3])    register_read = r4;
	else if(result[4])    register_read = r5;
	else if(result[5])    register_read = r6;
	else if(result[6])    register_read = r7;
	else if(result[7])    register_read = r8;
	else if(result[8])    register_read = r9;
	else if(result[9])    register_read = r10;
	else if(result[10])   register_read = r11;
	else if(result[11])   register_read = r12;
	else if(result[12])   register_read = r13;
	else if(result[13])   register_read = r14;
	else if(result[14])   register_read = r15;
	else if(result[15])   register_read = r16;
	else if(result[16])   register_read = r17;
	else if(result[17])   register_read = r18;
	else if(result[18])   register_read = r19;
	else if(result[19])   register_read = r20;
	else if(result[20])   register_read = r21;
	else if(result[21])   register_read = r22;
	else if(result[22])   register_read = r23;
	else if(result[23])   register_read = r24;
	else if(result[24])   register_read = r25;
	else if(result[25])   register_read = r26;
	else if(result[26])   register_read = r27;
	else if(result[27])   register_read = r28;
	else if(result[28])   register_read = r29;
	else if(result[29])   register_read = r30;
	else if(result[30])   register_read = r31;
	else register_read <= 32'h00000001;
end

endmodule

