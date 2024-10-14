module calculo_address_memory #(parameter size_x = 10, size_y = 10, size_address = 14)
(
	input  wire  [size_x-1:0]      pixel_x,
	input  wire  [size_y-1:0]      pixel_y,
	input  wire  [31:0]            sprite_datas,
	output wire [size_address-1:0] memory_address,
	output wire 				   is_sprite		// Flag que informa se um pixel atual e um sprite
);


localparam [13:0] offset = 400;
localparam [13:0] size_line = 20;
localparam [13:0] address_default = 14'd16383; // Endereco nao utilizado (valor default)
/*-------------Registradores auxiliares no cálculo do endereço de memória--------------*/
reg[13:0] linha;
reg[13:0] coluna; 
reg[13:0] aux_add_address;
/*----------------------------------------------------------------------------*/
reg [4:0] counter;
reg       aux_counter_finished;


/*----------------------Registradores auxiliares de saída---------------------------*/
reg 				   aux_is_sprite;
reg [size_address-1:0] out_memory_address;
reg [size_address-1:0] aux_y_sprite;
reg [size_address-1:0] aux_x_sprite;
reg [size_address-1:0] screen_x;
reg [size_address-1:0] screen_y;
reg [size_address-1:0] sprite_offset;
reg [size_address-1:0] limite;
/*-----------------------------------------------------------------------------------*/


/*--------Bloco always combinacional responsável por gerar o endereço de memória a ser acessado-----*/
always @(pixel_x or pixel_y or sprite_datas) begin
	out_memory_address  = 14'dx;
	aux_y_sprite[9:0]   = sprite_datas[18:9]; 
	aux_x_sprite[9:0]   = sprite_datas[28:19];
	aux_y_sprite[13:10] = 4'b0000;
	aux_x_sprite[13:10] = 4'b0000;
	screen_x[9:0]       = pixel_x;
	screen_y[9:0]       = pixel_y;
	screen_x[13:10]     = 4'b0000;
	screen_y[13:10]     = 4'b0000;
	sprite_offset       = sprite_datas[8:0];
	sprite_offset[13:9] = 5'b00000; 
	limite = aux_x_sprite + (size_line);
		
	//coordenada y inicial do sprite - pixel_y atual = diferença de linhas impressas
	linha  = screen_y - aux_y_sprite; 
	coluna = screen_x - aux_x_sprite;
	aux_add_address = size_line * linha; 

	aux_is_sprite = 1'b0;

	if(sprite_datas == 32'h00000001) begin //Nao e sprite
		out_memory_address = address_default;
	end
	else begin
		if( (screen_x >= aux_x_sprite) && (screen_x < limite) ) begin
			out_memory_address = (sprite_offset * offset) + coluna + aux_add_address;
			aux_is_sprite = 1'b1;
		end
		else begin
			out_memory_address = address_default;
		end
	end
end

assign memory_address = out_memory_address;
assign is_sprite      = aux_is_sprite;
/*--------------------------------------------------------------------------------------------------*/
endmodule