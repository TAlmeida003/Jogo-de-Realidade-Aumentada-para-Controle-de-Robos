/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sá Barreto Alves
DESCRICAO: modulo responsável por realizar o processamento dos pixeis que serao
jogados na tela.
--------------------------------------------------------------------------
ENTRADAS: 
	clk_pixel:   clock utilizado na interface VGA. 
	data_reg:    valor recebido do banco de registradores.
	active_area: sinal que informa se o monitor esta na area ativa ou nao.
	pixel_x:     coordenada x atual do monitor.
	pixel_y:     coordenada y atual do monitor.
SAIDAS:
	sprite-datas:     dados do sprite a ser impresso.		 
	memory_address:   endereço a ser acessado na memoria.
	check_value:      valor de coordenada a ser comparado com valores armazenados no banco de registradores. 
    printtingScreeen: sinal de status do modulo de impressao. (1-imprimindo, 0-nao imprimindo).     
//////////////////////////////////////////////////////////////////////////
**/
module printModule #( parameter size_x = 10, size_y = 10, size_address = 14, bits_x_y = 20 )
(
	input wire               clk,
	input wire               clk_pixel,
	input wire               reset,
	input wire  [31:0]       data_reg,
	input wire               active_area,
	input wire  [size_x-1:0] pixel_x,
	input wire  [size_y-1:0] pixel_y,
	input wire               count_finished,

   output wire [31:0]             sprite_datas,
   output wire [size_address-1:0] memory_address,
   output wire                    printting,
   output wire [bits_x_y-1:0] 	  check_value,
   output wire                    sprite_on
);


/*------------------Parâmetros da máquina de estados-------------------------*/
localparam [2:0] RECEBE     = 3'b000,
				PROCESSA    = 3'b001,
				SPRITE      = 3'b010,  
				AGUARDO     = 3'b011,
				AGUARDO_2   = 3'b100;

localparam address_BG = 14'd16383;
/*---------------------------------------------------------------------------*/

reg [2:0]  next, state;

/*-------------Registradores auxiliares de saída da máquina de estados------*/
reg [size_address-1:0] 	out_memory_address;
reg        			    out_printtingScreen; 
reg [bits_x_y-1:0] 		out_check_value;
reg        			   	out_sprite_on;
reg [31:0]             	out_sprite_datas;
/*----------------------------------------------------------------------------*/

/*----------------Bloco always para atualização do estado atual----------------------*/
always @(posedge clk or negedge reset) begin
	if(!reset) 
		state <= RECEBE;
	else 
		state <= next;
end
/*-----------------------------------------------------------------------------------*/

/*--------------------Bloco combinacional responsável pela mudança de estados----------------------------*/
always @(state or data_reg or count_finished or active_area) begin
	next = 3'bxxx;
	case(state)
		//só volta/entra no estado de RECEBE se somente se foi finalizado uma impressão da linha de um sprite
		//ou o tempo de aguardo depois de impresso a cor de background.
		RECEBE:
			begin
				if(active_area)
					next = PROCESSA;
				else 
					next = RECEBE;						
			end	

		PROCESSA:
			begin
				if( data_reg == 32'h00000001 ) begin //pixel atual pertence ao background do monitor.
					next = AGUARDO;               
				end
				else begin
					next = SPRITE;                //sprite detectado.
				end
			end 

		SPRITE:
			begin
				if(count_finished == 1'b1) begin
					next = RECEBE;
				end
				else begin
					next = SPRITE;
				end
			end

		AGUARDO:
			begin
				next = AGUARDO_2;
			end

		AGUARDO_2:
			begin
				next = RECEBE;
			end
		default: next = RECEBE;
	endcase
end
/*-------------------------------------------------------------------------------------------------*/

/*-------------------Bloco always responsável por gerenciar as saídas do módulo-------------------*/
always @(negedge clk or negedge reset) begin
	if(!reset) begin
		out_memory_address  	<= 14'bxxxxxxxxxxxxxx;
		out_check_value     	<= 20'bxxxxxxxxxxxxxxxxxxxx;
		out_sprite_on       	<= 1'b0;
		out_sprite_datas        <= 32'hxxxxxxxx;
	end
	else begin
		case(state) 
			RECEBE:
				begin
					if(active_area) begin
						//envio de coordenadas para comparação.
						out_check_value[9:0]   <= pixel_y; 
						out_check_value[19:10] <= pixel_x;
						out_memory_address     <= 14'bxxxxxxxxxxxxxx;
						out_sprite_on          <= 1'b0;
						out_sprite_datas       <= 32'hxxxxxxxx;
					end
					else begin
						out_check_value[9:0]   <= 10'bxxxxxxxxxx; 
						out_check_value[19:10] <= 10'bxxxxxxxxxx;
						out_memory_address     <= 14'bxxxxxxxxxxxxxx;
						out_sprite_on          <= 1'b0; 
						out_sprite_datas       <= 32'hxxxxxxxx;
					end
				end
			PROCESSA:
				begin
					if(data_reg == 32'h00000001) begin //pixel atual pertence ao background do monitor.
						out_memory_address    <= address_BG;  //endereço de memória onde está localizado a cor de background.
						out_check_value[19:0] <= 20'bxxxxxxxxxxxxxxxxxxxx;
						out_sprite_datas      <= 32'hxxxxxxxx;
						out_sprite_on         <= 1'b0;
					end
					else begin 
						out_memory_address    <= 14'bxxxxxxxxxxxxxx;
						out_check_value[19:0] <= 20'bxxxxxxxxxxxxxxxxxxxx;
						out_sprite_on         <= 1'b1; //habilita o contador das linhas a ser impresso em cada sprite.
						out_sprite_datas      <= data_reg;
					end
				end

			SPRITE:
				begin
					out_sprite_on         <= 1'b1;
					out_memory_address    <= 14'bxxxxxxxxxxxxxx;
					out_check_value[19:0] <= 20'bxxxxxxxxxxxxxxxxxxxx;
				end
		endcase
	end
end
/*--------------------------------------------------------------------------------------------------------------*/

always @(posedge clk_pixel) begin
	if(pixel_y < 480) begin
		out_printtingScreen <= 1;
	end
	else begin
		out_printtingScreen <= 0;
	end
end


/*-----------------Atribuição contínua das saídas---------------------------*/
assign memory_address  = out_memory_address;
assign printting       = out_printtingScreen; 
assign check_value     = out_check_value;
assign sprite_on       = out_sprite_on;
assign sprite_datas    = out_sprite_datas;
/*---------------------------------------------------------------------------*/
endmodule