module calculoAddress #(parameter size_x = 10, size_y = 10, size_address = 14)
(
	input  wire                     clk_pixel,
	input  wire  [size_x-1:0]       pixel_x,
	input  wire  [size_y-1:0]       pixel_y,
	input  wire  [31:0]             sprite_datas,
	input  wire                     sprite_on,
	output wire					counter_finished,
	output wire [size_address-1:0]  memory_address
);


localparam [13:0] offset = 400;
localparam [13:0] size_line = 20;
localparam address_BG = 14'd16383;
/*-------------Registradores auxiliares no cálculo do endereço de memória--------------*/
reg[13:0] linha;
reg[13:0] coluna; 
reg[13:0] aux_add_address;
/*----------------------------------------------------------------------------*/
reg [4:0] counter;
reg       aux_counter_finished;


/*----------------------Registradores auxiliares de saída---------------------------*/
reg [size_address-1:0] out_memory_address;
reg [size_address-1:0] aux_memory_address;
reg [size_address-1:0] aux_y_sprite;
reg [size_address-1:0] aux_x_sprite;
reg [size_address-1:0] screen_x;
reg [size_address-1:0] screen_y;
reg [size_address-1:0] sprite_offset;
reg [size_address-1:0] limite;
/*-----------------------------------------------------------------------------------*/


/*--------Bloco always combinacional responsável por gerar o endereço de memória a ser acessado-----*/
always @(pixel_x or pixel_y or sprite_datas or sprite_on) begin
	linha    	  	   = 14'd0;
	aux_add_address    = 14'd0;
	coluna             = 14'd0;
	aux_memory_address = 14'd0;
	aux_y_sprite[9:0] = sprite_datas[18:9]; 
	aux_x_sprite[9:0] = sprite_datas[28:19];
	aux_y_sprite[13:10] = 4'b0000;
	aux_x_sprite[13:10] = 4'b0000;
	screen_x[9:0] = pixel_x;
	screen_y[9:0] = pixel_y;
	screen_x[13:10] = 4'b0000;
	screen_y[13:10] = 4'b0000;
	sprite_offset   = sprite_datas[8:0];
	sprite_offset[13:9]   = 5'b00000; 
	limite = aux_x_sprite + (size_line);
	
	//coordenada y inicial do sprite - pixel_y atual = diferença de linhas impressas
	linha  = screen_y - aux_y_sprite; 
	coluna = screen_x - aux_x_sprite;
	aux_add_address = size_line * linha; 

	if( ( (screen_x >= aux_x_sprite) && (screen_x < limite) ) ) begin
		aux_memory_address = (sprite_offset * offset) + coluna + aux_add_address; 
	end
	else begin
		aux_memory_address = address_BG;
	end
end
/*--------------------------------------------------------------------------------------------------*/


always @(negedge clk_pixel) begin
	if(sprite_on == 1'b1) begin
		if(counter <= 5'd20) begin
			counter              <= counter + 5'd1;
			aux_counter_finished <= 1'b0;	
			out_memory_address   <= aux_memory_address;
		end
		else begin
			counter              <= 5'd0;
			aux_counter_finished <= 1'b1;	
			out_memory_address   <= address_BG;
		end
	end
	else begin
		counter                <= 5'd0;
		aux_counter_finished   <= 1'b0;	
		out_memory_address     <= address_BG;
	end
end

/*---------Saída do endereço de memória a ser acessado-------*/
assign memory_address   = out_memory_address;
assign counter_finished = aux_counter_finished;
endmodule