/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: Módulo para escolha de dados a serem lançados na saída de acordo a um sinal de seleção.
--------------------------------------------------------------------------
ENTRADAS: 
	selector: entrada de seleção de entradas.
	    data: primeira entrada de dados.
	    data: segunda  entrada de dados.
SAIDAS:		 
	out: saída de dados.
//////////////////////////////////////////////////////////////////////////
**/
module multiplexador #(parameter data_bits1 = 32, data_bits2 = 32, out_bits_size = 32)
(
	input  wire selector,        
	input  wire [data_bits1-1:0]    data,     
	input  wire [data_bits2-1:0]    data2,    
 	output reg  [out_bits_size-1:0] out       
);

//Bloco combinacional para seleção das entradas.
always @(*) begin
	if(selector == 1'b0)
		out = data; 
	else if(selector == 1'b1) 
		out = data2;
	else out = 0;
end
endmodule