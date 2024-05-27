module table_size(
	input wire clk,
	input wire reset,
	input wire st1_bubble,
	input wire [8:0] st1_color,
	input wire [9:0] st1_pixel_x,
	input wire [9:0] st1_pixel_y,
	input wire [3:0] mult,
	input wire [8:0] in_ref_point_x,
	input wire [8:0] in_ref_point_y,
	input wire 	     in_form,

   output reg [8:0] out_st1_color,
   output reg [9:0] out_st1_pixel_x,
   output reg [9:0] out_st1_pixel_y,
   output reg [8:0] out_ref_point_x,
   output reg [8:0] out_ref_point_y,
   output reg       out_table_form, 
   output reg [6:0] out_size,
   output reg 		out_st1_bubble
);

reg [6:0] size;

always @(mult) begin
	case(mult)
		/*0*/  4'b0000: size = 7'b0000000; //8'b10;  // Tamanho padrao dos poligonos
		/*1*/  4'b0001: size = 7'b0001010; //8'd20;  // 10*2
		/*2*/  4'b0010: size = 7'b0001111; //8'd30;  // 10*3
		/*3*/  4'b0011: size = 7'b0010100; //8'd40;  // 10*4
		/*4*/  4'b0100: size = 7'b0011001; //8'd50;  // 10*5
		/*5*/  4'b0101: size = 7'b0011110; //8'd60;  // 10*6
		/*6*/  4'b0110: size = 7'b0100011; //8'd70;  // 10*7
		/*7*/  4'b0111: size = 7'b0101000; //8'd80;  // 10*8
		/*8*/  4'b1000: size = 7'b0101101; //8'd90;  // 10*9
		/*9*/  4'b1001: size = 7'b0110010; //8'd100; // 10*10
		/*10*/ 4'b1010: size = 7'b0110111; //8'd110; // 10*11
		/*11*/ 4'b1011: size = 7'b0111100; //8'd120; // 10*12
		/*12*/ 4'b1100: size = 7'b1000001; //8'd130; // 10*13
		/*13*/ 4'b1101: size = 7'b1000110; //8'd140; // 10*14
		/*14*/ 4'b1110: size = 7'b1001011; //8'd150; // 10*15
		/*15*/ 4'b1111: size = 7'b1010000; //8'd160; // 10*16
			   default: size = 7'b0000101; //8'd10;  // Tamanho padrao dos poligonos
	endcase
end


always @(posedge clk) begin
	out_st1_color   <= st1_color;
	out_st1_pixel_x <= st1_pixel_x;
	out_st1_pixel_y <= st1_pixel_y;
	out_ref_point_x <= in_ref_point_x;
	out_ref_point_y <= in_ref_point_y;
	out_table_form  <= in_form;
	out_size        <= size;
end

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		out_st1_bubble  <= 1'b0;
	end
	else begin
		out_st1_bubble  <= st1_bubble;
	end
end

endmodule