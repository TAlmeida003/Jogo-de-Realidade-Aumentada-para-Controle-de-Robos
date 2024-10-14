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
     out_data: valores a serem escritos no banco de registradores.
//////////////////////////////////////////////////////////////////////////
**/
module decorderInstruction(
	input wire        clk_en,
	input wire [31:0] dataA,
	input wire [31:0] dataB,
	input wire        new_instruction,
	input wire        reset,
	output reg [3:0]  out_opcode,
	output reg [13:0] out_register,
	output reg [31:0] out_data,
	output reg        out_checkScreenCode,
	output reg        out_ready
);

reg [3:0]  opcode;
reg [13:0] register;
reg [31:0] data;
reg        checkScreenCode;
reg        ready;        

always @(posedge clk_en) begin
	if(!new_instruction) begin
		out_opcode   		<= opcode;
    	out_register 		<= register;
    	out_data     		<= data;
    	out_checkScreenCode <= checkScreenCode;
    	out_ready           <= ready;
	end
	else begin
		out_opcode   		<= 4'b1111;      //valor default de opcode
		out_register 		<= 0;       	 //valor default de register
		out_data     		<= 32'd0;       //valor default de data
		out_checkScreenCode <= 1'd0;
		out_ready           <= ready;
	end
end

always @(new_instruction or dataA or dataB) begin
	case(new_instruction)
		1'b0: begin
			opcode = dataA[3:0];
			case (dataA[3:0])
				4'b0000: begin                 					//instruçao de alterar posiçao de um sprite.
					register[4:0]  		= dataA[8:4];    		//output Register.
					register[13:5] 		= 9'd0; 
					data 				= dataB[31:0];  		//output data (valores de x e y).
					checkScreenCode 	= 1'd0;
					ready  				= 1'd1;
				end
				4'b0001: begin                 					//instruçao de escrita na memória de sprites.
					register 			= dataA[17:4];  		//endereço onde os dados serão escritos.
					data 	 			= dataB[31:0];  		//output data (valor de nova cor).
					checkScreenCode 	= 1'd0;
					ready  				= 1'd1;
				end
				4'b0010: begin 
					opcode   			= 4'b1111;              //valor default de opcode
					register 			= 0;       				//valor default de register
					data     			= 32'd0;       			//valor default de data
					checkScreenCode 	= 1'd1;
					ready  				= 1'd1;
				end
				4'b0011: begin
					register 			= 14'bxxxxxxxxxxxxxx;
					data     			= 32'dx;
					checkScreenCode 	= 1'd0;
					ready  				= 1'd0;
				end
				default: begin
				   	opcode   			= 4'b1111; 		//valor default de opcode
					register 			= 0;       		//valor default de register
					data     			= 32'd0;        //valor default de data
					checkScreenCode 	= 1'd0;
					ready  				= 1'd0;
				end
			endcase
		end

		1'b1: begin
			opcode   			= 4'b1111;      //valor default de opcode
			register 			= 0;       	 	//valor default de register
			data     			= 32'd0;        //valor default de data
			checkScreenCode 	= 1'd0;
			ready  				= 1'd0;
		end

		default: begin
			opcode   			= 4'b1111;      //valor default de opcode
			register 			= 0;       	 	//valor default de register
			data     			= 32'd0;        //valor default de data
			checkScreenCode 	= 1'd0;
			ready  				= 1'd0;
		end
	endcase
end

endmodule