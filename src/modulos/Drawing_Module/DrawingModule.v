module DrawingModule(
	input  wire 		clk,
	input  wire 		reset,
	input  wire 		reset_block_module,
	input  wire 		is_pixel,
	input  wire [8:0]	block_color,	// Cor do block de background lida da Memória.
	input  wire [31:0]	data_reg,		// Barramento de dados dos sprites.
	input  wire [9:0] 	pixel_x,		// Pixel x atual.
	input  wire [9:0]	pixel_y,		// Pixel y atual.
	input  wire [9:0]	prox_pixel_x,	// Proximo pixel x a ser processado.
	input  wire [9:0]	prox_pixel_y,	// Proximo pixel y a ser processado.
	output wire			refresh_comp,	
	output wire			refresh_select,
	output wire [13:0]	memory_address,	// Endereco de memoria do sprite atual.
	output wire [12:0]	out_addr_block,	// Endereco de memoria do block de background atual.
	output reg 			out_is_sprite,	// Informa se o pixel atual pertence a um sprite.
	output reg 			out_is_block,	// Informa se o block atual de background esta ativo.
	output reg 	[8:0]	out_block_color,// Cor do bloco de background atual.
	output wire 		refresh_vga_out
);

wire	refresh_data_out;
wire	is_sprite;
wire	is_block;

localparam [8:0] invisible_color = 9'b111111110; //510

stateMachine_1 
stateMachine_1_inst(
	.clk(clk),
	.reset(reset),
	.is_pixel(is_pixel),
	.refresh_comp(refresh_comp),
	.refresh_select(refresh_select)
);

stateMachine_2
stateMachine_2_inst(
	.clk(clk),
	.reset(reset),
	.refresh_data_out(refresh_data_out),
	.refresh_vga_out(refresh_vga_out)
);

BlockModule #(.size_x(10), .size_y(10), .size_address(13) )
BlockModule_inst
(
	.clk(clk), 						// Clock com frequencia de 100 MHz
	.reset(reset_block_module),		// Sinal de reset (O mesmo do controlador VGA, de forma que fiquem sincronizados)
	.pixel_x(prox_pixel_x),	    	// Proxima coordenada x que sera processada.
	.pixel_y(prox_pixel_y),	    	// Proxima coordenada y que sera processada.
   	.addr_block(out_addr_block)		// Endereco de Memoria do bloco de background atual
);


calculo_address_memory #(.size_x(10), .size_y(10), .size_address(14) )
calculo_address_memory_inst
(
	.pixel_x(pixel_x), 	               // input [size_x-1:0] pixel_x_sig
	.pixel_y(pixel_y),	                   // input [size_y-1:0] pixel_y_sig
	.sprite_datas(data_reg),	           // input [31:0] sprite_datas_sig
	.memory_address(memory_address),    // output [size_address-1:0] memory_address_sig
	.is_sprite(is_sprite)
);

/* =============== Bloco de controle dos registros de flags auxiliares =============== */
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		out_is_sprite   <= 1'b0;
		out_is_block    <= 1'b0;
		out_block_color <= 9'd0;		
	end
	else begin
		if(refresh_data_out) begin
			out_is_sprite 	<= is_sprite;
			out_is_block  	<= is_block;
			out_block_color <= block_color;
		end
		else begin
			out_is_sprite 	<= out_is_sprite;
			out_is_block  	<= out_is_block;
			out_block_color <= out_block_color;
		end
	end
end

// Verifica se o bloco de background atual esta ativo ou nao
assign is_block = (block_color == invisible_color) ? 1'b0 : 1'b1;
/* =================================================================================== */
endmodule