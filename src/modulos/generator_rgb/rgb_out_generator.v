/* DESCRICAO:
	* Modulo combinacional responsavel por gerar a saida RGB a partir dos dados lidos da memoria de sprite
	e background, e qual objeto deve ser impresso, sprite, bloco de background ou cor de fundo base. 
*/
module rgb_out_generator(
	input wire			clk,
	input wire			active_area,
	input wire [8:0]	co_processor_RGB,
	input wire [8:0]	sprite_memory_data,
	input wire [8:0]	block_color,
	input wire [8:0]	base_background,
	input wire			is_sprite,
	input wire			is_block,
	input wire 			rf_vga_out, 
	output reg [2:0]	out_R,
	output reg [2:0]	out_G,
	output reg [2:0]	out_B
);

/*
Precedências:
1 - Sprite;
2 - Polígonos;
3 - Bloco de background;
4 - Background;
*/


localparam invisible_color = 9'b111111110; //510
reg [2:0] R;
reg [2:0] G;
reg [2:0] B;

always @(co_processor_RGB or sprite_memory_data or block_color or base_background or is_sprite or is_block) begin
	case({is_sprite, is_block})
		2'b00: begin /* ------Sprite e Bloco de Background inativos no pixel atual-------------*/
			if(co_processor_RGB != invisible_color) begin
				R = co_processor_RGB[2:0];
				G = co_processor_RGB[5:3];
				B = co_processor_RGB[8:6];
			end
			else begin
				R = base_background[2:0];
				G = base_background[5:3];
				B = base_background[8:6];			
			end
		end
		2'b01: begin
			/* ------Sprite inativo e Bloco de Background ativo no pixel atual--------*/
			if(co_processor_RGB != invisible_color) begin
				R = co_processor_RGB[2:0];
				G = co_processor_RGB[5:3];
				B = co_processor_RGB[8:6];
			end
			else begin
				R = block_color[2:0];
				G = block_color[5:3];
				B = block_color[8:6];					
			end
		end
		2'b10: begin
			/* ------Sprite ativo e Bloco de Background inativo no pixel atual--------*/
			if(sprite_memory_data != invisible_color) begin
				R = sprite_memory_data[2:0];
				G = sprite_memory_data[5:3];
				B = sprite_memory_data[8:6];
			end
			else if(co_processor_RGB != invisible_color) begin
				R = co_processor_RGB[2:0];
				G = co_processor_RGB[5:3];
				B = co_processor_RGB[8:6];
			end
			else begin
				R = base_background[2:0];
				G = base_background[5:3];
				B = base_background[8:6];			
			end
		end
		2'b11: begin
			/* ------Sprite e Bloco de Background ativos no pixel atual---------------*/
			/*-------Saida: pixel do sprite ou cor do bloco de background ------------*/
			if(sprite_memory_data != invisible_color) begin
				R = sprite_memory_data[2:0];
				G = sprite_memory_data[5:3];
				B = sprite_memory_data[8:6];
			end
			else if(co_processor_RGB != invisible_color) begin
				R = co_processor_RGB[2:0];
				G = co_processor_RGB[5:3];
				B = co_processor_RGB[8:6];
			end
			else begin
				R = block_color[2:0];
				G = block_color[5:3];
				B = block_color[8:6];			
			end
		end
	endcase
end

always @(posedge clk) begin
	if(active_area) begin
		if(rf_vga_out) begin
			out_R <= R;
			out_G <= G;
			out_B <= B;
		end
		else begin
			out_R <= out_R;
			out_G <= out_G;
			out_B <= out_B;
		end
	end
	else begin
		out_R <= 3'd0;
		out_G <= 3'd0;
		out_B <= 3'd0;
	end
end

endmodule