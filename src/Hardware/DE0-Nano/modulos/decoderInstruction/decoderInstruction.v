/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: modulo decodificador de instruçao, responsavel por receber
as instruçoes do processador de video e separar seus determinados campos.
--------------------------------------------------------------------------
ENTRADAS: 
  dataA e dataB: campos que compoem a estrutura da instruçao.
         clk_en: sinal que indica em nivel alto que uma nova instruçao foi recebida. 
new_instruction: sinal que informa ao decodificador de instruçao se pode ou não 
decodificar uma nova instrução que for enviada.
		 		 
SAIDAS:		 
   out_opcode: valor que indica a unidade de controle qual instruçao sera executada.
 out_regsiter: identificaçao do registrador no banco de registrador.
//////////////////////////////////////////////////////////////////////////
**/
module decorderInstruction(
	input wire        clk_en,
	input wire		  reset,
	input wire [31:0] dataA,
	input wire [31:0] dataB,
	input wire        new_instruction,
	output reg [3:0]  out_opcode,
	output reg [4:0]  out_register,
	output reg [31:0] out_data_decoded,
	output reg [13:0] out_sprite_address,
	output reg [12:0] out_background_address,
	output reg [8:0]  out_memory_data,
	output reg [3:0]  out_co_processor_memory_address
);

reg [3:0]	opcode;
reg [4:0]	register;
reg [31:0]	data;	// Barramento de dados para o banco de registradores e Co-Processador.
reg [13:0]	sprite_address;
reg [12:0]	background_address;
reg [8:0]	memory_data;
reg [3:0]   co_processor_memory_address;

always @(posedge clk_en or negedge reset) begin
	if(!reset) begin
		out_opcode   					<= 4'b1111;      
		out_register 					<= 0;
    	out_data_decoded     			<= 0;
    	out_sprite_address				<= 0;
    	out_background_address			<= 0;
		out_memory_data					<= 0;
		out_co_processor_memory_address <= 0;
	end
	else if(new_instruction) begin
		out_opcode   					<= opcode;
    	out_register 					<= register;
    	out_data_decoded   				<= data;
    	out_sprite_address				<= sprite_address;
    	out_background_address			<= background_address;
		out_memory_data					<= memory_data;
		out_co_processor_memory_address <= co_processor_memory_address;
	end
	else begin
		// Valores default
		out_opcode   					<= 4'b1111;      
		out_register 					<= 0;
    	out_data_decoded     			<= out_data_decoded;
    	out_sprite_address				<= 0;
    	out_background_address			<= 0;
		out_memory_data					<= 0;
		out_co_processor_memory_address <= out_co_processor_memory_address;
	end
end

always @(dataA or dataB) begin    
	register 			= 0;
	data  		   		= 0;
	sprite_address		= 0;
	background_address	= 0;
	memory_data			= 0;
	co_processor_memory_address = 0;
	opcode 				= dataA[3:0];
	case (dataA[3:0])
		4'b0000: begin                 				// Instruçao de alterar posiçao de um sprite.
			register  			= dataA[8:4];    	// Output Register. 
			data 				= dataB[31:0];  	// Output data (dados do sprite).
		end
		4'b0001: begin                 				// Instruçao de escrita na memória de sprites.
			sprite_address 		= dataA[17:4];  	// Endereço onde os dados serão escritos.
			memory_data 	 	= dataB[8:0];  		// Output data (valor de nova cor).
		end
		4'b0010: begin                 				// Instruçao de escrita na memória de background.
			background_address 	= dataA[16:4];  	// Endereço onde os dados serão escritos.
			memory_data 	 	= dataB[8:0];  		// Output data (valor de nova cor do bloco de background).
		end
		4'b0011: begin 									// Instrução para renderização de um polígono.
			co_processor_memory_address[0] = dataA[4];	// Endereço para memória de instrução do Co-Processador.
			co_processor_memory_address[1] = dataA[5];
			co_processor_memory_address[2] = dataA[6];
			co_processor_memory_address[3] = dataA[7];
			data    					   = dataB; 	// Instrução a ser armazenada.
		end
		default: begin
			// Valores default
			opcode   			= 4'b1111;      
			register 			= 0;
	    	data     			= 0;
	    	sprite_address		= 0;
	    	background_address	= 0;
			memory_data			= 0;
			co_processor_memory_address = 0;
		end
	endcase
end

endmodule