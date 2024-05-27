/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: Module responsavel por gerenciar o uso correto das unidades
que compoem o processador de video apartir da geraçao dos respectivos sinais de controle.
--------------------------------------------------------------------------
ENTRADAS: 
	clk:               sinal de clock (50Mhz)
	opCode:            campo que denota a instrucao que deve ser executada.
	printtingScreen:   campo que informa se o monitor esta em processo de impressao. (0)Nao (1)Sim
	doneInst:              informa se a instrução que estava em execução foi finalizada. (0)Não (1)Sim
SAIDAS:		 
	new_instruction:   informa se uma nova instruçao pode ser executada. (0)Sim (1)Nao
	memory_wr:         sinal de escrita/leitura da memoria de sprites.
deve ser guardada pelo banco de registradores.
	register_wr:       sinal de escrita/leitura do banco de registradores.

	selectorAddress:       sinal de seleção para o multiplexador ao qual escolhe entre os endereços de memória vindos do decodificador de instrução ou do módulo de impressão.
//////////////////////////////////////////////////////////////////////////
**/
module controlUnit(
	 input wire clk,
	 input wire reset,
	 input wire [3:0] opCode,
	 input wire       printtingScreen,
	 input wire       doneInst,
	 input wire       en_execution,
	 output reg 	  register_wr,
	 output reg       memory_wr_SP,
	 output reg       memory_wr_BK,
	 output reg       selectorAddress,
	 output reg       reset_done,
	 output reg       reset_modules,
	 output reg 	  reset_rsd,
	 output reg       enable_written_co_processor
);


parameter [2:0] RESET                   = 3'b000,
				INIT                    = 3'b001,
				PRONTO                  = 3'b010,
				ESCREVER_NO_BANCO       = 3'b011,
				HABILITAR_IMPRESSAO     = 3'b100,
				ESCRITA_NA_MEMORIA_SP   = 3'b101, // Escrita na memória de sprites.
				ESCRITA_NA_MEMORIA_BK   = 3'b110, // Escrita na memória de background.
				ESCRITA_NO_CO_PROCESSOR = 3'b111;

reg [2:0] state; 
reg [2:0] next = INIT;

reg [1:0] counter_reset = 2'd0;

always @(posedge clk) begin
	state <= next;
end

/*
Bloco always (combinacional) responsavel por analisar as entradas
da maquina de estados e realizar a mudança para o proximo estado.
*/
always @(state or reset or opCode or printtingScreen or doneInst or en_execution or counter_reset) begin
	next = 3'bxxx;
	case(state)
	    RESET: begin
	    	next = PRONTO;
		end

		INIT: begin
			if(!reset) begin
				next = RESET;
			end
			else if(counter_reset == 2'd3) begin
				next = HABILITAR_IMPRESSAO;
			end
			else begin
				next = INIT;
			end
		end

		PRONTO: begin
			if(!reset)
				next = RESET;
			else if(en_execution == 1'b0)
				next = PRONTO;
			else if(printtingScreen)
				next = HABILITAR_IMPRESSAO;
			else if(opCode == 4'b0000)	
				next = ESCREVER_NO_BANCO;
			else if(opCode == 4'b0001)
				next = ESCRITA_NA_MEMORIA_SP;
			else if(opCode == 4'b0010)
				next = ESCRITA_NA_MEMORIA_BK;
			else if(opCode == 4'b0011)
				next = ESCRITA_NO_CO_PROCESSOR;
			else begin
				next = PRONTO;
			end
		end
		
		ESCREVER_NO_BANCO: begin
			if(!reset)
				next = RESET;
			else if(doneInst == 1'b1 && printtingScreen) 
				next = HABILITAR_IMPRESSAO;
			else if(doneInst == 1'b1) //a instrução que estava em execução foi finalizada
				next = PRONTO; 
			else 
				next = ESCREVER_NO_BANCO;
		end
		
		HABILITAR_IMPRESSAO: begin
			if(!reset)
				next = RESET;
			else if(!printtingScreen) //o módulo de impressão não está mais imprimindo.
				next = PRONTO;
			else 
				next = HABILITAR_IMPRESSAO;	
		end

		ESCRITA_NA_MEMORIA_SP: begin
			if(!reset)
				next = RESET;
			else if(doneInst == 1'b1 && printtingScreen) 
				next = HABILITAR_IMPRESSAO;
			else if(doneInst == 1'b1) //a instrução que estava em execução foi finalizada
				next = PRONTO; 
			else 
				next = ESCRITA_NA_MEMORIA_SP;
		end

		ESCRITA_NA_MEMORIA_BK: begin
			if(!reset)
				next = RESET;
			else if(doneInst == 1'b1 && printtingScreen) 
				next = HABILITAR_IMPRESSAO;
			else if(doneInst == 1'b1) //a instrução que estava em execução foi finalizada
				next = PRONTO; 
			else 
				next = ESCRITA_NA_MEMORIA_BK;
		end

		ESCRITA_NO_CO_PROCESSOR: begin
			if(!reset)
				next = RESET;
			else if(doneInst == 1'b1 && printtingScreen)
				next = HABILITAR_IMPRESSAO;
			else if(doneInst == 1'b1) //a instrução que estava em execução foi finalizada
				next = PRONTO;
			else
				next = ESCRITA_NO_CO_PROCESSOR;
		end

		default: next = RESET;
	endcase
end

/*
Block always responsavel por gerar de acordo ao proximo estado as
saidas correspondentes.
*/
always @(negedge clk) begin
	case(next)
		RESET: begin
			reset_rsd   				<= 1'b0; 	// sinal de reset para o banco de registradores, decodificador de instrucao.
			counter_reset 				<= 2'd0;
			reset_modules  				<= 1'b1;     //reseta todos os modulos da GPU.
			memory_wr_SP   				<= 1'b0;	 //habilita leitura na memoria de sprites. 	
			memory_wr_BK   				<= 1'b0;	 //habilita leitura na memoria de background.
			register_wr     			<= 1'b0;     //aciona leitura no banco de registradores 
	 		selectorAddress 			<= 1'b1;	 //seleciona os endereços de leitura da memória vindos do módulo de impressão.
	 		reset_done      			<= 1'b1;
	 		enable_written_co_processor <= 1'b0;
		end

		INIT: begin
			reset_rsd                   <= 1'b0;
			counter_reset 				<= counter_reset + 2'd1;
			reset_modules  				<= 1'b0;     //reseta todos os modulos da GPU.
			memory_wr_SP   				<= 1'b0;	 //habilita leitura na memoria de sprites. 	
			memory_wr_BK   				<= 1'b0;	 //habilita leitura na memoria de background.
			register_wr     			<= 1'b0;     //aciona leitura no banco de registradores 
	 		selectorAddress 			<= 1'b1;	 //seleciona os endereços de leitura da memória vindos do módulo de impressão.
	 		reset_done      			<= 1'b1;
	 		enable_written_co_processor <= 1'b0;
		end
	
		PRONTO: begin
			reset_rsd                   <= 1'b1;
			counter_reset 				<= 2'd0;
			reset_modules  	  			<= 1'b1;       
			memory_wr_SP   	  			<= 1'b0;	//habilita leitura na memoria de sprites.
			memory_wr_BK   	  			<= 1'b0;	//habilita leitura na memoria de background.
			register_wr       			<= 1'b0;
	 		selectorAddress  	 		<= 1'bx;
	 		reset_done        			<= 1'b1;
	 		enable_written_co_processor <= 1'b0;
		end
			
		ESCREVER_NO_BANCO: begin
			reset_rsd                   <= 1'b1;
			counter_reset 				<= 2'd0;
			reset_modules  	  			<= 1'b1;     
			memory_wr_SP   	  			<= 1'b0;	//habilita leitura na memoria de sprites.
			memory_wr_BK   	  			<= 1'b0;	//habilita leitura na memoria de background.
			register_wr       			<= 1'b1;  	//aciona escrita no banco de registradores.
	 		selectorAddress   			<= 1'bx; 	//não possue nem leitura nem escrita na memória.
	 		reset_done        			<= 1'b0;
	 		enable_written_co_processor <= 1'b0;
		end
			
		HABILITAR_IMPRESSAO: begin
			reset_rsd                   <= 1'b1;
			counter_reset 				<= 2'd0;
			reset_modules  	  			<= 1'b1;        
			memory_wr_SP   	  			<= 1'b0;	//habilita leitura na memoria de sprites.
			memory_wr_BK   	 		 	<= 1'b0;	//habilita leitura na memoria de background.
			register_wr       			<= 1'b0;    //aciona leitura no banco de registradores
	 		selectorAddress   			<= 1'b1; 	//seleciona os endereços de leitura da memória vindos do módulo de impressão.
	 		reset_done        			<= 1'b0;
	 		enable_written_co_processor <= 1'b0;
		end

		ESCRITA_NA_MEMORIA_SP: begin
			reset_rsd                   <= 1'b1;
			counter_reset 				<= 2'd0;
			reset_modules  				<= 1'b1;        
			memory_wr_SP   				<= 1'b1; //habilita escrita na memoria de sprites.
			memory_wr_BK   				<= 1'b0; //desabilita escrita da memoria de background.
			register_wr 				<= 1'bx;
	 		selectorAddress 			<= 1'b0; //seleciona o endereço vindo do decodificador de instrução.
	 		reset_done      			<= 1'b0;
	 		enable_written_co_processor <= 1'b0;
		end

		ESCRITA_NA_MEMORIA_BK: begin
			reset_rsd                   <= 1'b1;
			counter_reset 				<= 2'd0;
			reset_modules  				<= 1'b1;        
			memory_wr_SP   				<= 1'b0; //desabilita escrita na memoria de sprites.
			memory_wr_BK   				<= 1'b1; //habilita escrita na memoria de background.
			register_wr    				<= 1'bx;
	 		selectorAddress				<= 1'b0; //seleciona o endereço vindo do decodificador de instrução.
	 		reset_done     				<= 1'b0;
	 		enable_written_co_processor <= 1'b0;
		end


		ESCRITA_NO_CO_PROCESSOR: begin
			reset_rsd                   <= 1'b1;
			counter_reset 				<= 2'd0;
			reset_modules  	  			<= 1'b1;        
			memory_wr_SP   	  			<= 1'b0;	//habilita leitura na memoria de sprites.
			memory_wr_BK   	  			<= 1'b0;	//habilita leitura na memoria de background.
			register_wr       			<= 1'b0;  	//desabilita escrita no banco de registradores.
	 		selectorAddress   			<= 1'bx; 	//não possue nem leitura nem escrita na memória.
	 		reset_done        			<= 1'b0;
	 		enable_written_co_processor <= 1'b1; 	//habilta escrita na memória de instrução do Co-Processador.
		end

		default: begin
			/////////////////////////////////////
			//Todas as saidas estao desativadas
			reset_rsd                   <= 1'b0;
			counter_reset 				<= 2'd0;
			reset_modules  				<= 1'b0;  
			memory_wr_SP   				<= 1'bx;
			memory_wr_BK   				<= 1'bx; 
			register_wr     			<= 1'bx;
	 		selectorAddress 			<= 1'bx;
	 		reset_done      			<= 1'b0;
	 		enable_written_co_processor <= 1'b0;
			/////////////////////////////////////
		end
	endcase
end 
endmodule