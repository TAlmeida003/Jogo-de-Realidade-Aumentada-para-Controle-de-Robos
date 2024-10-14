module pipeline_geometricForms (
	input wire clk,
	input wire reset,
	input wire in_bubble,
	input wire [9:0] pixel_x,
	input wire [9:0] pixel_y,
	input wire [8:0] ref_point_x,
	input wire [8:0] ref_point_y,
	input wire [8:0] in_color,
	input wire [3:0] mult,
	input wire 	     form,
   output wire [3:0] out_reg, 			
   output wire [8:0] out_color,
   output wire 		 out_bubble
);

/* ======= Barramentos auxiliares para repassar as seguintes informações em cada etapa do pipeline ====== */
// Cor do polígono
// Endereço de memória corresponde ao pixel da linha
// Pixel x e y.
wire [8:0] out_st1_color;
wire [9:0] out_st1_pixel_x;
wire [9:0] out_st1_pixel_y;

wire [8:0] out_st2_color;
wire [9:0] out_st2_pixel_x;
wire [9:0] out_st2_pixel_y;

/* ============================================================================================================ */ 
wire 	   out_st1_bubble;
wire 	   out_st2_bubble;
wire 	   out_st3_bubble;
wire 	   out_form;
wire [9:0] v1_x;
wire [9:0] v2_x;
wire [9:0] v3_x;
wire [9:0] v4_x;
wire [9:0] v1_y;
wire [9:0] v2_y;
wire [9:0] v3_y;
wire [9:0] v4_y;
wire [8:0] out_ref_point_x;
wire [8:0] out_ref_point_y;
wire       out_table_form; 
wire [6:0] out_size;

table_size table_size_inst (
	.clk(clk),
	.reset(reset),
	.st1_bubble(in_bubble),
	.st1_color(in_color),
	.st1_pixel_x(pixel_x),
	.st1_pixel_y(pixel_y),
	.mult(mult),
	.in_ref_point_x(ref_point_x),
	.in_ref_point_y(ref_point_y),
	.in_form(form),
	.out_ref_point_x(out_ref_point_x),
	.out_ref_point_y(out_ref_point_y),
	.out_table_form(out_table_form),
	.out_size(out_size),
	.out_st1_color(out_st1_color),
	.out_st1_pixel_x(out_st1_pixel_x),
	.out_st1_pixel_y(out_st1_pixel_y),
	.out_st1_bubble(out_st1_bubble)
);

vertice_calculator vertice_calculator_inst (
	.clk(clk),
	.reset(reset),
	.st2_bubble(out_st1_bubble),
	.st2_color(out_st1_color),
	.st2_pixel_x(out_st1_pixel_x),
	.st2_pixel_y(out_st1_pixel_y),
	.ref_point_x(out_ref_point_x),
	.ref_point_y(out_ref_point_y),
	.form(out_table_form),
	.size(out_size),		
	.out_form(out_form),
	.v1_x(v1_x),
	.v1_y(v1_y),
	.v2_x(v2_x),
	.v2_y(v2_y),
	.v3_x(v3_x),
	.v3_y(v3_y),
	.v4_x(v4_x),
	.v4_y(v4_y),
	.out_st2_color(out_st2_color),
	.out_st2_pixel_x(out_st2_pixel_x),
	.out_st2_pixel_y(out_st2_pixel_y),
	.out_st2_bubble(out_st2_bubble)
);

determinants determinants_inst (
	.clk(clk) ,					// input  clk_sig
	.reset(reset),
	.st3_bubble(out_st2_bubble),
	.st3_color(out_st2_color) ,
	.st3_pixel_x(out_st2_pixel_x) ,
	.st3_pixel_y(out_st2_pixel_y) ,
	.v1_x(v1_x) ,				// input [9:0] v1_x_sig
	.v1_y(v1_y) ,				// input [9:0] v1_y_sig
	.v2_x(v2_x) ,				// input [9:0] v2_x_sig
	.v2_y(v2_y) ,				// input [9:0] v2_y_sig
	.v3_x(v3_x) ,				// input [9:0] v3_x_sig
	.v3_y(v3_y) ,				// input [9:0] v3_y_sig
	.v4_x(v4_x) ,				// input [9:0] v4_x_sig
	.v4_y(v4_y) ,				// input [9:0] v4_y_sig
	.form(out_form) ,			// input  form_sig
	.out_reg(out_reg), 			// output [3:0] out_sig
	.out_st3_color(out_color),
	.bubble(out_bubble)
);

endmodule