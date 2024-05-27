module BlockModule #(parameter size_x = 10, size_y = 10, size_address = 13)(
	input wire clk, 							    // Clock com frequencia de 100 MHz
	input wire reset,							    // Sinal de reset
	input wire [size_x-1:0] 		pixel_x,	    // Proxima coordenada x que sera processada.
	input wire [size_y-1:0] 		pixel_y,	    // Proxima coordenada y que sera processada.
   output reg  [size_address-1:0]   addr_block
);

wire [1:0]	addr_signal;
wire 		enable_refresh;
wire 		reset_addr;

localparam [size_address-1:0]	addr_default = 13'd0;
reg 	   [size_address-1:0]	add_adress;
/* =============================================================================== */
/* ============= Modulo de controle para geracao dos enderecos ===================
========================= de cada bloco do background ============================ */
background_block
background_block_inst
(
	.clk(clk),
	.reset(reset),		
	.pixel_x(pixel_x),  
	.pixel_y(pixel_y),
	.addr_signal(addr_signal),
	.en_refresh(enable_refresh),
	.reset_addr(reset_addr)
);

/* ================ Bloco de Controle do Registro de Saida ====================== */
always @(posedge clk) begin
	if(reset_addr == 1'b0) begin
		addr_block <= addr_default; // Endereco do primeiro bloco do background.
	end
	else if(enable_refresh) begin
		if(addr_signal == 2'd0) begin
			addr_block <= addr_block;			// Mantem o registro do endereco de memoria no seu valor atual.
		end
		else if(addr_signal == 2'd1) begin
			addr_block <= addr_block + 13'd1;	// Terminou de desenhar a fileira de blocos. Segue ao endereco seguinte.
		end
		else if(addr_signal == 2'd2) begin
			addr_block <= addr_block - 13'd79;	// A fileira atual de blocos ainda esta sendo desenhada. Retorna ao endereco inicial da fileira de blocos.
		end
		else begin
			addr_block <= addr_block;
		end
	end
	else begin
		addr_block <= addr_block;
	end
end
/* =============================================================================== */

endmodule