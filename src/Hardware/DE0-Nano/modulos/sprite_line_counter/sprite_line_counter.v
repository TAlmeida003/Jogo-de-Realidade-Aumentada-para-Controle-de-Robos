/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sá Barreto Alves
DESCRICAO: modulo responsável por realizar o processamento dos pixeis que serao
jogados na tela.
--------------------------------------------------------------------------
ENTRADAS: 
	clk_pixel: clock utilizado na interface VGA. 
	sprite_on: sinal de entrada para informar que a contagem das linhas deve ser iniciada.
	    reset: sinal de reset do contador.
	sprite_datas: dados do sprite a ser impresso.    
SAIDAS:		 
	address_memory: endereço a ser acessado na memoria.  
	count_finished: sinal para informar que a contagem foi finalizada.
//////////////////////////////////////////////////////////////////////////
**/

module sprite_line_counter(
	input  wire                     clk_pixel,
	input  wire                     sprite_on,
	input  wire                     reset,
	output wire        			    count_finished,
	output wire [4:0]               current_state
);

/*------------------Parâmetros da máquina de estados-------------------------*/
localparam [4:0] ZERO     =  5'b00000,
				ONE          =  5'b00001,
				TWO          =  5'b00010,
				THREE        =  5'b00011,
				FOUR         =  5'b00100,
				FIVE         =  5'b00101,
				SIX          =  5'b00110,
				SEVEN        =  5'b00111,
				EIGHT        =  5'b01000,
				NINE         =  5'b01001,
				TEN          =  5'b01010,
				ELEVEN       =  5'b01011,
				TWELVE       =  5'b01100,
				THIRTEEN     =  5'b01101,
				FOURTEEN     =  5'b01110,
				FIFTEEN      =  5'b01111,
				SIXTEEN      =  5'b10000,
				SEVENTEEN    =  5'b10001,
				EIGHTEEN     =  5'b10010,
				NINETEEN     =  5'b10011;			
/*---------------------------------------------------------------------------*/

/*----------------------Registrador auxiliar de saída---------------------------*/
reg                    out_count_finished;
/*-----------------------------------------------------------------------------------*/

reg  [4:0]              next, state, state_value;

/*----------------Bloco always para atualização do estado atual----------------------*/
always @(posedge clk_pixel or negedge reset) begin
	if(!reset) begin
		state <= ZERO;
	end
	else begin
		state <= next;
	end
end
/*-------------------------------------------------------------------------------------*/

/*--------------------Bloco combinacional responsável pela mudança de estados----------------------------*/
always @(state or sprite_on) begin
	if(sprite_on == 1'b1) begin
		case(state)
			ZERO: begin
				next = ONE;
			end
			ONE: begin
				next = TWO;
			end
			TWO: begin
				next = THREE;
			end
			THREE: begin
				next = FOUR;
			end
			FOUR: begin
				next = FIVE;
			end
			FIVE: begin
				next = SIX;
			end
			SIX: begin
				next = SEVEN;
			end
			SEVEN: begin
				next = EIGHT;
			end
			EIGHT: begin
				next = NINE;
			end
			NINE: begin
				next = TEN;
			end
			TEN: begin
				next = ELEVEN;
			end
			ELEVEN: begin
				next = TWELVE;
			end
			TWELVE: begin
				next = THIRTEEN;
			end
			THIRTEEN: begin
				next = FOURTEEN;
			end
			FOURTEEN: begin
				next = FIFTEEN;
			end
			FIFTEEN: begin
				next = SIXTEEN;
			end
	 		SIXTEEN: begin
	 			next = SEVENTEEN;
	 		end
			SEVENTEEN: begin
				next = EIGHTEEN;
			end
			EIGHTEEN: begin
				next = NINETEEN;
			end
			NINETEEN: begin
				next = ZERO;
			end
			default: next = ZERO;
		endcase
	end
	else next = ZERO;
end
/*--------------------------------------------------------------------------------------------------------*/


/*-------------------Bloco always responsável por gerenciar as saídas do módulo---------------------*/
always @(negedge clk_pixel or negedge reset) begin
	if(!reset) begin
		out_count_finished <= 1'b1;
		state_value <= ZERO;
	end
	else begin
		if(sprite_on == 1'b1) begin
			if(next == ZERO) begin                    //contagem  será desabilitada.
				out_count_finished <= 1'b1;
			end
			else begin
				out_count_finished <= 1'b0;
			end 
			end
		else  out_count_finished <= 1'b1; 

		case(state)
			ZERO: begin
				state_value <= ZERO;
			end
			ONE: begin
				state_value <= ONE;
			end
			TWO: begin
				state_value <= TWO;
			end
			THREE: begin
				state_value <= THREE;
			end
			FOUR: begin
				state_value <= FOUR;
			end
			FIVE: begin
				state_value <= FIVE;
			end
			SIX: begin
				state_value <= SIX;
			end
			SEVEN: begin
				state_value <= SEVEN;
			end
			EIGHT: begin
				state_value <= EIGHT;
			end
			NINE: begin
				state_value <= NINE;
			end
			TEN: begin
				state_value <= TEN;
			end
			ELEVEN: begin
				state_value <= ELEVEN;
			end
			TWELVE: begin
				state_value <= TWELVE;
			end
			THIRTEEN: begin
				state_value <= THIRTEEN;
			end
			FOURTEEN: begin
				state_value <= FOURTEEN;
			end
			FIFTEEN: begin
				state_value <= FIFTEEN;
			end
	 		SIXTEEN: begin
	 			state_value <= SIXTEEN;
	 		end
			SEVENTEEN: begin
				state_value <= SEVENTEEN;
			end
			EIGHTEEN: begin
				state_value <= EIGHTEEN;
			end
			NINETEEN: begin
				state_value <= NINETEEN;
			end
			default: state_value = ZERO;
		endcase
	end
end
/*--------------------------------------------------------------------------------------------------*/

/*-----------------Atribuição contínua das saídas---------------------------*/
assign count_finished = out_count_finished;
assign current_state  = state_value;
/*---------------------------------------------------------------------------*/

endmodule