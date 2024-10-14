module background_block (
	input wire clk, 				// Clock com frequencia de 100 MHz
	input wire reset,				// Sinal de reset
	input wire [9:0] pixel_x,	    // Proxima coordenada x que sera processada.
	input wire [9:0] pixel_y,	    // Proxima coordenada y que sera processada.
   output wire [1:0] addr_signal,   // Sinal de Atualizacao do Registro do Endereco de Memoria.
   output wire       en_refresh,  	// Sinal que habilita a atualizacao do Registro do Endereco de Memoria.
   output wire 		 reset_addr		// Sinal de reset para o registro do endereco de memoria.
);

/* ========== Definicao dos estados ============== */
parameter [2:0] RESET 			= 3'b000,
				SYNC_TIME 		= 3'b001,
				COUNT_LINES     = 3'b010,
				REFRESH_ADDR    = 3'b011,
				WAIT 			= 3'b100,
				WAIT_NEW_SCREEN = 3'b101,
				WAIT_NEW_LINE	= 3'b110;
/* ================================================ */
wire	draw_area;
wire	screen_finished;
wire 	last_pixel;
/* ===== Registros para a Maquina de Estados ====== */   
reg [2:0] state, next;
/* ================================================ */
/* ============= Registros auxiliares ============= */
reg [9:0] count_pulses;
reg [2:0] count_y;
reg [1:0] refresh_signal;
/* ================================================ */
/* ============ Saidas da Maquina de Estados ====== */
reg enable_refresh;
reg reset_address;
/* ================================================ */
/* ========= Atualizacao do estado atual ========== */
always @(posedge clk or negedge reset) begin
	if (!reset) begin
		state <= RESET;
	end
	else
		state <= next;
end
/* ================================================ */
/* ====== Definicao do proximo estado ============= */
always @(state or draw_area or count_pulses or screen_finished or last_pixel or reset) begin
	next    = 3'bxxx;
	case(state)
		RESET: begin
			if(reset == 1'b0) begin
				next = RESET;
			end
			else begin
				next = SYNC_TIME;
			end
		end
		
		SYNC_TIME: begin
			if(last_pixel == 1'b1) begin
				next = REFRESH_ADDR;
			end
			else begin
				next = WAIT;
			end
		end
		
		COUNT_LINES: begin // Neste estado, estamos na borda de subida do clk_25
			next = REFRESH_ADDR;
		end

		REFRESH_ADDR: begin 
			next = WAIT; 
		end
		
		WAIT: begin
			/* Estado de ociosidade durante os 10 pixels de largura do bloco de background, no qual 
			nao e necessario a atualizacao do endereco de memoria. */ 
			if(count_pulses == 10'd30) begin
				if(draw_area == 1'b0) begin
					next = WAIT_NEW_LINE;	
				end 
				else begin
					next = COUNT_LINES; 
				end
			end
			else begin 
				next = WAIT;
			end
		end

		WAIT_NEW_SCREEN: begin
			if(last_pixel == 1'b1) begin
				next = RESET;
			end
			else begin
				next = WAIT_NEW_SCREEN;
			end
		end

		WAIT_NEW_LINE: begin
			if(count_pulses == 10'd670) begin // Espera para atualizar o endereço de background e iniciar uma nova linha.
				if(screen_finished == 1'b1) begin
					next = WAIT_NEW_SCREEN;	  // O frame de tela foi finalizado.
				end
				else begin
					next = COUNT_LINES;
				end
			end
			else begin
				next = WAIT_NEW_LINE;
			end
		end
		default: begin next = RESET; end
	endcase
end
/* =============================================================== */
/* ====== Definicao das saidas da maquina de estados ============= */
always @(negedge clk) begin
	case(state)
		RESET: begin
			reset_address 	<= 1'b0;
			enable_refresh 	<= 1'b0;
		end
		SYNC_TIME: begin
			reset_address 	<= 1'b1;
			enable_refresh 	<= 1'b0;
		end
		COUNT_LINES: begin
			reset_address 	<= 1'b1;
			enable_refresh 	<= 1'b1;				// habilita o sinal que atualiza o registro do endereco de memoria.
		end
		REFRESH_ADDR: begin
			reset_address 	<= 1'b1;
			enable_refresh 	<= 1'b0;
		end
		WAIT: begin
			reset_address 	<= 1'b1;
			enable_refresh 	<= 1'b0;
		end
		WAIT_NEW_SCREEN: begin
			reset_address 	<= 1'b1;
			enable_refresh 	<= 1'b0;
		end

		WAIT_NEW_LINE: begin 
			reset_address 	<= 1'b1;
			enable_refresh 	<= 1'b0;
		end

		default: begin
			reset_address 	<= 1'b0;
			enable_refresh 	<= 1'b0;
		end
	endcase
end
/* =============================================================== */
/* ============= Controle dos registros auxiliares =============== */
/* ================= e da saida "refresh signal" ================= */
always @(negedge clk) begin
	case(state)
		RESET: begin
			count_y <= 3'd0; count_pulses <= 10'd0; refresh_signal <= 2'd0;
		end

		SYNC_TIME: begin
			count_y 	 	<= 3'd0;
			refresh_signal 	<= 2'd0; 
			if(last_pixel == 1'b1) begin
				count_pulses <= 10'd0;	// Sincroniza a contagem de pulsos para iniciar um novo frame.
			end
			else begin
				count_pulses <= 10'd4;	// Sincroniza a contagem de pulsos após o reset da Unidade de Controle.
			end
		end

		COUNT_LINES: begin
			count_pulses   <= 10'd0;
			count_y	       <= count_y;
			refresh_signal <= refresh_signal;
		end

		REFRESH_ADDR: begin 
			count_pulses   <= 10'd0; 
			count_y		   <= count_y;
			refresh_signal <= 2'd0; 
		end

		WAIT: begin
			/* Período de ociosidade durante os 8 pixels de largura do bloco de background, no qual 
			nao e necessario a atualizacao do endereco de memoria. */
			count_y 		<= count_y;
			count_pulses 	<= count_pulses + 10'd1;
			if(count_pulses == 10'd29) begin
				refresh_signal <= 2'd1;
			end
			else begin
				refresh_signal	<= 2'd0;
			end
		end

		WAIT_NEW_SCREEN: begin
			count_pulses   <= 10'd0;
			count_y	       <= 3'd0;
			refresh_signal <= 2'd0;
		end

		WAIT_NEW_LINE: begin
			/* Período de ociosidade durante a finalizacao de linha atual, no qual 
			nao e necessario a atualizacao do endereco de memoria. */
			count_pulses 	<= count_pulses + 10'd1;
			if(count_pulses == 10'd669) begin
				if(count_y == 3'd7) begin 				// Verifica se esta na ultima linha do bloco de 8x8.
					count_y        <= 3'd0;
					refresh_signal <= 2'd1;				// Terminou de desenhar a fileira de blocos. 
				end
				else begin
					refresh_signal <= 2'd2;			    // A fileira atual de blocos ainda esta sendo desenhada. 
					count_y        <= count_y + 3'd1;	// Registra a finalizacao de uma linha.
				end
			end
			else begin
				count_y	       <= count_y;
				refresh_signal <= 2'd0; 				// Mantem o registro do endereco de memoria no seu valor atual.
			end
		end
		default: begin count_pulses <= 10'd0; count_y <= 3'd0; refresh_signal <= 2'd0; end
	endcase
end
/* ================================================================ */
// Informa se o controlador vga esta desenhando a area de animacao da tela.
assign draw_area        = (pixel_x <= 10'd639) ? 1'b1 : 1'b0;
// Informa se uma tela foi finalizada.
assign screen_finished  = (pixel_y > 10'd479) ? 1'b1 : 1'b0;
// Informa se o controlador VGA esta no ultimo pixel da tela. Um novo frame ira iniciar.
assign last_pixel		= ((pixel_x == 10'd800) && (pixel_y == 10'd524)) ? 1'b1 : 1'b0;
// Joga para o barramento de saida o sinal de atualizacao para o registro do endereco de memoria.
assign addr_signal      = refresh_signal;
// Joga para a saida o sinal de atualizacao do endereco de memoria do bloco de background atual.
assign en_refresh   = enable_refresh;
// Sinal de reset para o registro do endereco de memoria.
assign reset_addr 	= reset_address;

endmodule