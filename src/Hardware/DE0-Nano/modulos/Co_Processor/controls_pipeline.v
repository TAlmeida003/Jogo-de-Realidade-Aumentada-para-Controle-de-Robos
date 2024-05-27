module controls_pipeline(
	input wire clk,
	input wire reset,
	input wire printtingScreen,
	input wire [9:0] counter_x,						// Contador para coordenada x.
	input wire [9:0] vga_x,						// coordenada x do monitor VGA.
	input wire [9:0] vga_y,						// coordenada y do monitor VGA.
	output reg wr_memory_fg,					// sinal de escrita/leitura da memória de instrução.
	output reg memory_fg_selector,				// sinal de seleção do endereço da memória de instrução.
	output reg wr_register,						// Sinal de escrita/leitura dos bancos de registradores.
	output reg registers_reset,					// Sinal de reset dos bancos de registradores.
	output reg reset_counter_x,
	output reg [3:0] register_w_address,     	// Barramento de escrita dos bancos de registradores.
	output reg [1:0] register_r_address,     	// Barramento de leitura dos bancos de registradores.
	output reg [3:0] memory_read_address    	// Barramento de endereço para leitura na memória de instrução.
);


parameter [2:0] RESET 				= 3'b000,
			 	WAIT   				= 3'b001,	// Estado de espera até iniciar o processamento de uma nova linha.
			 	UPLOAD_DATA 		= 3'b010,	// Estado que distribue nos bancos de registradores, o conteúdo da memória de instrução.
			 	READ_MEMORY 		= 3'b011,	// Estado que realiza leitura da memória de instrução
			 	PROCESSING 			= 3'b100,	// Estado que realiza o processamento dos pixels
			 	REFRESH_INST_MEMORY = 3'b101,	// Estado de espera até iniciar o processamento de uma nova tela.
			 	STEP_RESET			= 3'b110,
			 	STEP_PROCESSING		= 3'b111;
localparam [3:0] size_of_inst_memory = 4'd15;  // Quantidade de endereços da memória de instrução.

reg [2:0] state = RESET;
reg [2:0] next;

reg [3:0] aux_register_w_address;
reg [1:0] aux_register_r_address;
reg [3:0] aux_memory_read_address;

always @(posedge clk or negedge reset) begin
	if (!reset) begin
		state <= RESET;
	end
	else begin
		state <= next;
	end
end

/*
Bloco always (combinacional) responsavel por analisar as entradas
da maquina de estados e realizar a mudança para o proximo estado.
*/

always @(state or printtingScreen or vga_x or vga_y or counter_x or memory_read_address or register_r_address or register_w_address) begin
	next = 3'bxxx;
	aux_register_w_address  = 4'd0;
	aux_register_r_address  = 2'd0;
	aux_memory_read_address = 4'd0;
	case(state)
		RESET: 
		begin
			next = STEP_RESET;	
		end

		STEP_RESET: 
		begin
			next = READ_MEMORY;	
		end

		UPLOAD_DATA: 
		begin
			next = READ_MEMORY;
			// Contagem dos endereços da memória.
			if(memory_read_address < size_of_inst_memory) begin
				aux_memory_read_address = memory_read_address + 4'd1;
				aux_register_w_address  = register_w_address  + 4'd1;
			end
			else begin  // Carregamento dos dados da Memória de instrução finalizada.
				next = STEP_PROCESSING;
			end
		end

		READ_MEMORY: 
		begin
			next = UPLOAD_DATA;
		end

		WAIT: 
		begin
			if(vga_x > 10'd639) begin
				next = WAIT;
			end
			else if(vga_x < 10'd10) begin
				next = WAIT;
			end
			else begin
				next = PROCESSING;
			end
		end

		STEP_PROCESSING:
		begin
			next = PROCESSING;
		end

		PROCESSING: 
		begin
			if(printtingScreen == 1'b0 && vga_y < 10'd523) begin
				next = REFRESH_INST_MEMORY; // vai para o estado de espera até retomar o processamento.
			end
			else if(counter_x < 10'd640) begin
				next = PROCESSING;
				if(register_r_address == 2'b11) begin
					aux_register_r_address = 2'b00;
				end
				else begin
					aux_register_r_address = register_r_address + 2'd1;
				end
			end
			else begin
				next = WAIT; // vai para o estado de espera até inicar o processamento da nova linha.
			end
		end

		REFRESH_INST_MEMORY: 
		begin
			if(vga_y < 10'd523) begin // 523 = última linha antes de iniciar uma nova tela.
				next = REFRESH_INST_MEMORY;
			end
			else begin
				next = RESET; // Volta ao estado RESET para carregar o banco de registradores e iniciar um novo processamento de tela.
			end
		end

		default: begin
			next = RESET;
		end
	endcase
end

/*
Block always responsavel por gerar de acordo ao proximo estado as
saidas correspondentes.
*/
always @(negedge clk) begin
	case(state)
		RESET: 
		begin
			reset_counter_x			<= 1'b0;	   // Reseta contador de coordenada x.
			wr_memory_fg        	<= 1'b0;	   // Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b0;       // Seleciona endereço para escrita na memória de instrução.
			wr_register         	<= 1'b0;       // Banco de registradores no modo de leitura.
			registers_reset     	<= 1'b0;       // Reseta os registros do banco de registradores.
			register_w_address      <= 4'b0000;
			register_r_address      <= 2'b00;
			memory_read_address 	<= 4'b0000;    // Endereço inicial.
		end

		STEP_RESET: 
		begin
			reset_counter_x			<= 1'b0;	   // Reseta contador de coordenada x.
			wr_memory_fg        	<= 1'b0;	   // Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b1;       // Seleciona endereço para leitura na memória de instrução.
			wr_register         	<= 1'b1;       // Banco de registradores no modo de escrita.
			registers_reset     	<= 1'b1;       // Desabilita reset dos registros do banco de registradores.
			register_w_address      <= 4'b0000;
			register_r_address      <= 2'b00;
			memory_read_address 	<= 4'b0000;    // Endereço inicial.
		end

		STEP_PROCESSING:
		begin
			reset_counter_x			<= 1'b0;	    // Reseta contador de coordenada x. 
			wr_memory_fg        	<= 1'b0;	 	// Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b1;     	// Seleciona endereço para leitura na memória de instrução.
			wr_register         	<= 1'b0;     	// Banco de registradores no modo de leitura.
			registers_reset     	<= 1'b1;     	// Desabilita reset dos registros do banco de registradores.
			register_w_address      <= 4'b0000;
			register_r_address      <= 2'b00;      
			memory_read_address 	<= 4'b0000;		
		end

		UPLOAD_DATA: 
		begin
			reset_counter_x			<= 1'b0;	    // Reseta contador de coordenada x. 
			wr_memory_fg        	<= 1'b0;	 	// Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b1;     	// Seleciona endereço para leitura na memória de instrução.
			wr_register         	<= 1'b1;     	// Banco de registradores no modo de escrita.
			registers_reset     	<= 1'b1;     	// Desabilita reset dos registros do banco de registradores.
			register_w_address      <= aux_register_w_address;
			register_r_address      <= 2'b00;      
			memory_read_address 	<= aux_memory_read_address;
		end

		READ_MEMORY: 
		begin
			reset_counter_x			<= 1'b0;	    // Reseta contador de coordenada x. 
			wr_memory_fg        	<= 1'b0;	 	// Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b1;     	// Seleciona endereço para leitura na memória de instrução.
			wr_register         	<= 1'b1;     	// Banco de registradores no modo de escrita.
			registers_reset     	<= 1'b1;     	// Desabilita reset dos registros do banco de registradores.
			register_w_address      <= register_w_address;
			register_r_address      <= register_r_address;  
			memory_read_address 	<= memory_read_address;	
		end

		WAIT: begin
			reset_counter_x			<= 1'b0;	   // Reseta contador de coordenada x.
			wr_memory_fg        	<= 1'b0;	   // Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b1;       // Seleciona endereço para leitura na memória de instrução.
			wr_register         	<= 1'b0;       // Banco de registradores no modo de leitura.
			registers_reset     	<= 1'b1;       // Desabilita reset dos bancos de registradores.
			register_w_address      <= 4'b0000;
			register_r_address      <= 2'b00;
			memory_read_address 	<= 4'b0000;    // Endereço inicial.			
		end

		PROCESSING: 
		begin
			reset_counter_x			<= 1'b1;	    // Desabilita reset do contador de coordenada x.		 
			wr_memory_fg        	<= 1'b0;		// Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b1;		// Seleciona endereço para leitura na memória de instrução.
			wr_register         	<= 1'b0;		// Banco de registradores no modo de leitura.
			registers_reset     	<= 1'b1;		// Desabilita reset dos bancos de registradores.
			register_w_address      <= 4'b0000;
			register_r_address   	<= aux_register_r_address;
			memory_read_address 	<= 4'b0000;		// Endereço inicial.
		end

		REFRESH_INST_MEMORY: 
		begin
			reset_counter_x			<= 1'b0;	   // Reseta contador de coordenada x.
			wr_memory_fg        	<= 1'b1;	   // Memória de instrução no modo de escrita.				
			memory_fg_selector  	<= 1'b0;       // Seleciona endereço para escrita na memória de instrução.
			wr_register         	<= 1'b0;       // Banco de registradores no modo de leitura.
			registers_reset     	<= 1'b0;       // Reseta os registros do banco de registradores.
			register_w_address      <= 4'b0000;
			register_r_address      <= 2'b00;
			memory_read_address 	<= 4'b0000;    // Endereço inicial.			
		end

		default: 
		begin
			reset_counter_x			<= 1'b0;	   // Reseta contador de coordenada x.
			wr_memory_fg        	<= 1'b0;	   // Memória de instrução no modo de leitura.				
			memory_fg_selector  	<= 1'b0;       // Seleciona endereço para escrita na memória de instrução.
			wr_register         	<= 1'b0;       // Banco de registradores no modo de leitura.
			registers_reset     	<= 1'b0;       // Reseta os registros do banco de registradores.
			register_w_address      <= 4'b0000;
			register_r_address      <= 2'b00;
			memory_read_address 	<= 4'b0000;    // Endereço inicial.
		end
	endcase
end
endmodule