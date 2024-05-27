`timescale 1ns/1ns
module decodeInstruction_test();

reg new_instruction;
reg clk_en;
reg  [31:0]  dataA;
reg  [31:0]  dataB;
wire [3:0]   out_opcode;
wire [13:0]  out_register;
wire [31:0]  out_data;

always begin //frequência de funcionamento do módulo
	clk_en = 1'b0;
	#10;
	clk_en = 1'b1;
	#10;
end

initial begin
	new_instruction = 1'b1;
	@(posedge clk_en);
	$monitor("out_opcode: %b | out_register: %b | out_data: %b" , out_opcode, out_register, out_data);
	clk_en = 1;
	dataA = 32'b00000000000000111111111111110001;
	dataB = 32'b00000000000000000000000000111000;
	new_instruction = 1'b0;            // allows to execute new instructions
	@(posedge clk_en);
	new_instruction = 1'b1;
	@(posedge clk_en);
	new_instruction = 1'b0;
	dataA = 32'b00000000000000000000000000000000;
	dataB = 32'b00100110010000100101100000000000;
	@(posedge clk_en);         
	@(posedge clk_en);
	$stop;

end
decorderInstruction decorderInstruction_inst
(
	.clk_en(clk_en) ,	                // input  clk_en_sig
	.dataA(dataA) ,		                // input [31:0] dataA_sig
	.dataB(dataB) ,	                    // input [31:0] dataB_sig
	.new_instruction(new_instruction) ,	// input  new_instruction_sig
	.out_opcode(out_opcode) ,	        // output [3:0] out_opcode_sig
	.out_register(out_register) ,	    // output [13:0] out_register_sig
	.out_data(out_data) 	            // output [31:0] out_data_sig
);


endmodule