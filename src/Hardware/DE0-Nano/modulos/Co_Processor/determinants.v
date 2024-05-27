module determinants(
	input wire clk,
	input wire reset,
	input wire st3_bubble,
	input wire [8:0] st3_color,
	input wire [9:0] st3_pixel_x,
	input wire [9:0] st3_pixel_y,
	input wire [9:0] v1_x,
	input wire [9:0] v1_y,
	input wire [9:0] v2_x,
	input wire [9:0] v2_y,
	input wire [9:0] v3_x,
	input wire [9:0] v3_y,
	input wire [9:0] v4_x,
	input wire [9:0] v4_y,
	input wire 		 form,
   output reg  [3:0] out_reg,
   output reg  [8:0] out_st3_color,
   output reg        bubble
);

wire out[3:0];
/*==== Barramentos auxiliares dos vertices com sinal ======*/
wire signed [10:0] s_v1_x;
wire signed [10:0] s_v1_y;
wire signed [10:0] s_v2_x;
wire signed [10:0] s_v2_y;
wire signed [10:0] s_v3_x;
wire signed [10:0] s_v3_y;
wire signed [10:0] s_v4_x;
wire signed [10:0] s_v4_y;
wire signed [10:0] s_pixel_x;
wire signed [10:0] s_pixel_y;
/*========== Barramentos auxiliares =============*/
wire signed [10:0] param_A_det1;
wire signed [10:0] param_A_det2;
wire signed [10:0] param_A_det3;
wire signed [10:0] param_A_det4;

wire signed [10:0] param_B_det1;
wire signed [10:0] param_B_det2;
wire signed [10:0] param_B_det3;
wire signed [10:0] param_B_det4;

wire signed [10:0] param_C_det1;
wire signed [10:0] param_C_det2;
wire signed [10:0] param_C_det3;
wire signed [10:0] param_C_det4;

wire signed [10:0] param_D_det1;
wire signed [10:0] param_D_det2;
wire signed [10:0] param_D_det3;
wire signed [10:0] param_D_det4;

wire signed [10:0] tri_param_A_det3;
wire signed [10:0] tri_param_B_det3;
wire signed [10:0] tri_param_C_det3;
wire signed [10:0] tri_param_D_det3;

wire signed [31:0] wire_det1;
wire signed [31:0] wire_det2;
wire signed [31:0] wire_det3;
wire signed [31:0] wire_det4;
/*======= Registradores de pipeline para o parâmetro de bolha ========*/
reg param_bubble;
reg param_bubble_2;
reg param_bubble_3;
/*======= Registradores de pipeline para o parâmetro de cor ========*/
reg [8:0] param_color;
reg [8:0] param_color_2;
reg [8:0] param_color_3;
/*======= Registrador de pipeline para o resultado da verificação dos determinantes ========*/
reg [3:0] aux_reg;
/*======= Registradores de pipeline para os parâmetros dos determinantes ========*/
reg signed [10:0] A_det1;
reg signed [10:0] A_det2;
reg signed [10:0] A_det3;
reg signed [10:0] A_det4;

reg signed [10:0] B_det1;
reg signed [10:0] B_det2;
reg signed [10:0] B_det3;
reg signed [10:0] B_det4;

reg signed [10:0] C_det1;
reg signed [10:0] C_det2;
reg signed [10:0] C_det3;
reg signed [10:0] C_det4;

reg signed [10:0] D_det1;
reg signed [10:0] D_det2;
reg signed [10:0] D_det3;
reg signed [10:0] D_det4;
/*======= Registradores de pipeline para resultado dos determinantes ========*/
reg signed [31:0] det1;
reg signed [31:0] det2;
reg signed [31:0] det3;
reg signed [31:0] det4;
/* =============================================================== */
/* =============================================================== */
assign s_v1_x = v1_x;
assign s_v1_y = v1_y;

assign s_v2_x = v2_x;
assign s_v2_y = v2_y;

assign s_v3_x = v3_x;
assign s_v3_y = v3_y;

assign s_v4_x = v4_x;
assign s_v4_y = v4_y;

assign s_pixel_x = st3_pixel_x;
assign s_pixel_y = st3_pixel_y;
/* ========= Cálculo dos parâmetros dos determinantes ========== */
/* ============== para quadrados e triângulos ================== */
// determinante(v1,v2,pixel)
assign param_A_det1 = s_pixel_y - s_v1_y;
assign param_B_det1 = s_v2_x 	- s_v1_x;
assign param_C_det1 = s_pixel_x - s_v1_x;
assign param_D_det1 = s_v2_y 	- s_v1_y;
// determinante(v2,v3,pixel)
assign param_A_det2 = s_pixel_y - s_v2_y;
assign param_B_det2 = s_v3_x 	- s_v2_x;
assign param_C_det2 = s_pixel_x - s_v2_x;
assign param_D_det2 = s_v3_y 	- s_v2_y;
/* =============================================================== */
/* =============================================================== */
/* =============== Somente para quadrados ======================== */
// determinante(v3,v4,pixel)
assign param_A_det3 = s_pixel_y - s_v3_y;
assign param_B_det3 = s_v4_x 	- s_v3_x;
assign param_C_det3 = s_pixel_x - s_v3_x;
assign param_D_det3 = s_v4_y 	- s_v3_y;
// determinante(v4,v1,pixel)
assign param_A_det4 = s_pixel_y - s_v4_y;
assign param_B_det4 = s_v1_x 	- s_v4_x;
assign param_C_det4 = s_pixel_x - s_v4_x;
assign param_D_det4 = s_v1_y 	- s_v4_y;
/* =============================================================== */
/* =============================================================== */
/* =============== Somente para triângulos ======================= */
// determinante(v3,v1,pixel)
assign tri_param_A_det3 = s_pixel_y - s_v3_y;
assign tri_param_B_det3 = s_v1_x 	- s_v3_x;
assign tri_param_C_det3 = s_pixel_x - s_v3_x;
assign tri_param_D_det3 = s_v1_y 	- s_v3_y;
/* =============================================================== */
/* =============================================================== */
/* ========= Registradores de pipeline ========== */
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		param_bubble 	<= 1'b0;
	end
	else begin
		param_bubble <= st3_bubble;
	end
end

always @(posedge clk) begin
	param_color  <= st3_color;
	A_det1 		 <= param_A_det1;
	B_det1 		 <= param_B_det1;
	C_det1 		 <= param_C_det1;
	D_det1 		 <= param_D_det1;
		
	A_det2 		 <= param_A_det2;
	B_det2 		 <= param_B_det2;
	C_det2 		 <= param_C_det2;
	D_det2 		 <= param_D_det2;
	if(form == 1'b0) begin	// para quadrados
		A_det3 <= param_A_det3;
		B_det3 <= param_B_det3;
		C_det3 <= param_C_det3;
		D_det3 <= param_D_det3;
	
		A_det4 <= param_A_det4;
		B_det4 <= param_B_det4;
		C_det4 <= param_C_det4;
		D_det4 <= param_D_det4;
	end
	else begin // para triângulos
		A_det3 <= tri_param_A_det3;
		B_det3 <= tri_param_B_det3;
		C_det3 <= tri_param_C_det3;
		D_det3 <= tri_param_D_det3;

		A_det4 <= 11'sd0;
		B_det4 <= 11'sd0;
		C_det4 <= 11'sd0;
		D_det4 <= 11'sd0;
	end
end

/* ============ Cálculo da etapa de multiplicação dos determinantes ============= */
/* ==================== para quadrados e triângulos ================== */
//determinante(v1,v2,pixel)
assign wire_det1 = (A_det1 * B_det1) - (C_det1 * D_det1); 
//determinante(v2,v3,pixel)
assign wire_det2 = (A_det2 * B_det2) - (C_det2 * D_det2); 
//determinante(v3,v4,pixel)
assign wire_det3 = (A_det3 * B_det3) - (C_det3 * D_det3); 
//determinante(v4,v1,pixel)
assign wire_det4 = (A_det4 * B_det4) - (C_det4 * D_det4); 


/* ========= Registradores de pipeline ========== */
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		param_bubble_2 	<= 1'b0;
	end
	else begin
		param_bubble_2  <= param_bubble;
	end
end

always @(posedge clk) begin
	det1 <= wire_det1;
	det2 <= wire_det2;
	det3 <= wire_det3;
	det4 <= wire_det4;
	param_color_2  <= param_color;
end

// Verificaçao dos determinantes
assign out[0] = (det1 <= 32'sd0) ? 1'b1: 1'b0;
assign out[1] = (det2 <= 32'sd0) ? 1'b1: 1'b0;
assign out[2] = (det3 <= 32'sd0) ? 1'b1: 1'b0;
assign out[3] = (det4 <= 32'sd0) ? 1'b1: 1'b0;

/* ========= Registradores de pipeline ========== */
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		param_bubble_3	<= 1'b0;
	end
	else begin
		param_bubble_3  <= param_bubble_2;
	end
end

always @(posedge clk) begin
	aux_reg[0]    	<= out[0];
	aux_reg[1]    	<= out[1];
	aux_reg[2]    	<= out[2];
	aux_reg[3]    	<= out[3];
	param_color_3	<= param_color_2;
end


/* ========= Registradores de pipeline ========== */
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		bubble 			<= 1'b0;
	end
	else begin
		bubble <= param_bubble_3;
	end
end

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		out_reg 	  <= 4'd0;
		out_st3_color <= 9'd0;
	end
	else begin
		if(bubble)begin
			out_reg		  <= 4'b0000;
			out_st3_color <= 9'd510;
		end
		else if(aux_reg == 4'b1111) begin
			out_reg 	  <= aux_reg;
			out_st3_color <= param_color_3;			
		end
		else begin
			out_reg		  <= out_reg;
			out_st3_color <= out_st3_color;
		end 
	end
end

endmodule