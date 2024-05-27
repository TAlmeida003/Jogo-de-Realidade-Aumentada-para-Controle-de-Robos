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
	selectField:       sinal que informa qual intervalo de bits da parte de dados da instruçao
deve ser guardada pelo banco de registradores.
	register_wr:       sinal de escrita/leitura do banco de registradores.
	
	selectorDemuxRegister: sinal de seleção para o demultiplexador que seleciona entre a entrada Register do banco de registradores e a entrada de endereço da memória.

	selectorDemuxData:     sinal de seleção para o demultiplexador ao qual seleciona entre a entrada de dados do banco de registradores e a entrada de dados da memória.  

	selectorAddress:       sinal de seleção para o multiplexador ao qual escolhe entre os endereços de memória vindos do decodificador de instrução ou do módulo de impressão.
//////////////////////////////////////////////////////////////////////////
**/
module controlUnit(
	 input wire clk,
	 input wire reset,
	 input wire [3:0] opCode,
	 input wire       printtingScreen,
	 input wire       doneInst,
	 output reg       new_instruction,
	 output reg       memory_wr,
	 output reg [3:0] selectField,
	 output reg       register_wr,
	 output reg       selectorDemuxRegister, 
	 output reg       selectorDemuxData,
	 output reg       selectorAddress,
	 output reg       reset_done
);


parameter [1:0]     PRONTO              = 2'b00,
					ESCREVER_NO_BANCO   = 2'b01,
					HABILITAR_IMPRESSAO = 2'b10,
					ESCRITA_NA_MEMORIA  = 2'b11;

reg [1:0] state, next;

always @(posedge clk or negedge reset) begin
	if(!reset)
		state <= PRONTO;
	else 
		state <= next;
end

/*
Bloco always (combinacional) responsavel por analisar as entradas
da maquina de estados e realizar a mudança para o proximo estado.
*/
always @(state or opCode or printtingScreen or doneInst) begin
	next = 2'bxx;
	case(state)
		PRONTO: begin
			if( (opCode == 4'b0000) && !printtingScreen)	
				next = ESCREVER_NO_BANCO;
			else if( (opCode == 4'b0001) && !printtingScreen )
				next = ESCRITA_NA_MEMORIA;
			else if( (opCode == 4'b0000 || opCode == 4'b0001) && printtingScreen )
				next = HABILITAR_IMPRESSAO;
			else if(!printtingScreen) 
				next = PRONTO;
			else next = HABILITAR_IMPRESSAO;
		end
		
		ESCREVER_NO_BANCO: begin
			if(doneInst == 1'b1 && printtingScreen) 
				next = HABILITAR_IMPRESSAO;
			else if(doneInst == 1'b1) //a instrução que estava em execução foi finalizada
				next = PRONTO; 
			else 
				next = ESCREVER_NO_BANCO;
		end
		
		HABILITAR_IMPRESSAO: begin
			if(!printtingScreen) //o módulo de impressão não está mais imprimindo.
				next = PRONTO;
			else 
				next = HABILITAR_IMPRESSAO;	
		end

		ESCRITA_NA_MEMORIA: begin
			if(doneInst == 1'b1 && printtingScreen) 
				next = HABILITAR_IMPRESSAO;
			else if(doneInst == 1'b1) //a instrução que estava em execução foi finalizada
				next = PRONTO; 
			else 
				next = ESCRITA_NA_MEMORIA;
		end
		default: next = PRONTO;
	endcase
end

/*
Block always responsavel por gerar de acordo ao proximo estado as
saidas correspondentes.
*/
always @(negedge clk or negedge reset) begin
	if(!reset) begin
		//Todas as saidas estao desativadas
		new_instruction   <= 1'bx;   
		memory_wr         <= 1'bx;    
		selectField       <= 4'bxxxx; 
		register_wr       <= 1'bx;    
		selectorDemuxRegister <= 1'bx;  
	    selectorDemuxData     <= 1'bx; 
	 	selectorAddress       <= 1'bx;
	 	reset_done            <= 1'b0;
	end
	else begin
		case(next)
			PRONTO: begin
				new_instruction   <= 1'b0;    //permite executar novas instruçoes
				memory_wr         <= 1'bx;    //nao tem leitura na memoria
				selectField       <= 4'bxxxx; //nao existem campos a serem alterados no registradores do banco
				register_wr       <= 1'b0;    
				selectorDemuxRegister <= 1'bx; 
	       		selectorDemuxData     <= 1'bx;
	 			selectorAddress       <= 1'bx;
	 			reset_done            <= 1'b1;
			end
			
			ESCREVER_NO_BANCO: begin
				new_instruction   <= 1'b1;   //nao permite executar novas instruçoes
				memory_wr         <= 1'bx;   //nao tem leitura na memoria
				selectField       <= opCode; //existem campos a serem alterados no registradores do banco
				register_wr       <= 1'b1;   //aciona escrita no banco de registradores
				selectorDemuxRegister <= 1'b1; //redireciona a entrada para o banco de registradores.
	       		selectorDemuxData     <= 1'b1; //redireciona os dados para o banco de registradores.
	 			selectorAddress       <= 1'bx; //não possue nem leitura nem escrita na memória.
	 			reset_done            <= 1'b0;
			end
			
			
			HABILITAR_IMPRESSAO: begin
				new_instruction   <= 1'b1;     //nao permite executar novas instruçoes
				memory_wr         <= 1'b0;     //aciona leitura da memoria
				selectField       <= 4'bxxxx;  //nao existem campos a serem alterados no registradores do banco
				register_wr       <= 1'b0;     //aciona leitura no banco de registradores
								
				selectorDemuxRegister <= 1'bx; //não possue nem acesso de escrita no banco de registradores, nem na memória. 
	       		selectorDemuxData     <= 1'bx; //não possue nem escrita no banco de registradores, nem escrita na memória. 
	 			selectorAddress       <= 1'b1; //seleciona os endereços de leitura da memória vindos do módulo de impressão.
	 			reset_done            <= 1'b0;
			end

			ESCRITA_NA_MEMORIA: begin
				new_instruction   <= 1'b1;     //nao permite executar novas instruçoes
				memory_wr         <= 1'b1;     //aciona escrita da memoria
				selectField       <= 4'bxxxx;  //nao existem campos a serem alterados no registradores do banco
				register_wr       <= 1'bx;     
									
				selectorDemuxRegister <= 1'b0;  //redireciona o endereo recebido para a memória de sprite.
	       		selectorDemuxData     <= 1'b0;  //redireciona os dados a serem escritos para a memória de sprite.
	 			selectorAddress       <= 1'b0;  //seleciona o endereço vindo do decodificador de instrução.
	 			reset_done            <= 1'b0;
			end

			default: begin
				/////////////////////////////////////
				//Todas as saidas estao desativadas
				new_instruction   <= 1'bx;   
				memory_wr         <= 1'bx;    
				selectField       <= 4'bxxxx; 
				register_wr       <= 1'bx;    
				selectorDemuxRegister <= 1'bx;  
	       		selectorDemuxData     <= 1'bx; 
	 			selectorAddress       <= 1'bx;
	 			reset_done            <= 1'b0;
				/////////////////////////////////////
			end
		endcase
	end
end 
endmodule