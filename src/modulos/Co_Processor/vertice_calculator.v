module vertice_calculator(
	input wire clk,
	input wire reset,
	input wire st2_bubble,
	input wire [8:0] st2_color,
	input wire [9:0] st2_pixel_x,
	input wire [9:0] st2_pixel_y,
	input wire [8:0]  ref_point_x,
	input wire [8:0]  ref_point_y,
	input wire 		  form,
	input wire [6:0]  size,
	output reg [9:0] v1_x,
	output reg [9:0] v1_y,
	output reg [9:0] v2_x,
	output reg [9:0] v2_y,
	output reg [9:0] v3_x,
	output reg [9:0] v3_y,
	output reg [9:0] v4_x,
	output reg [9:0] v4_y,
	output reg		 out_form,
	output reg [8:0] out_st2_color,
    output reg [9:0] out_st2_pixel_x,
    output reg [9:0] out_st2_pixel_y,
    output reg 		 out_st2_bubble
);

wire [9:0] s_x;
wire [9:0] sb_x;
wire [9:0] s_y;
wire [9:0] sb_y;
wire [9:0] v1_x_triangulo;

// Caso o barramento size esteja zerado, significa que o polígono está desabilitado.
// Assim, as coordenadas geradas farão com que o polígono seja colocado fora da área ativa da tela.
assign v1_x_triangulo 	= (size == 7'd0) ? 10'd720 : ref_point_x;
assign s_x  			= (size == 7'd0) ? 10'd740 : ref_point_x + size;
assign sb_x 			= (size == 7'd0) ? 10'd700 : ref_point_x - size;
assign s_y  			= (size == 7'd0) ? 10'd510 : ref_point_y + size;
assign sb_y 			= (size == 7'd0) ? 10'd500 : ref_point_y - size;

always @(posedge clk) begin
	out_st2_color   <= st2_color;
	out_st2_pixel_x <= st2_pixel_x;
	out_st2_pixel_y <= st2_pixel_y;
	out_form  		<= form;
	v1_x <= (form == 1'b0) ? sb_x : v1_x_triangulo;
	v1_y <= sb_y;
	v2_x <= sb_x;
	v2_y <= s_y;
	v3_x <= s_x;
	v3_y <= s_y;
	v4_x <= (form == 1'b0) ? s_x  : 10'd0;
	v4_y <= (form == 1'b0) ? sb_y : 10'd0;
end

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		out_st2_bubble <= 1'b0;	
	end
	else begin
		out_st2_bubble <= st2_bubble;
	end
end

endmodule