/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: Módulo para redirecionamento de dados de entrada.
--------------------------------------------------------------------------
ENTRADAS: 
	selector: entrada de seleção das saídas.
	    data: entrada de dados.
SAIDAS:		 
	out1: primeira saída de dados.
	out2: segunda saída de dados.
//////////////////////////////////////////////////////////////////////////
**/
module demultiplexador #(parameter data_bits = 32, out1_bits_size = 32, out2_bits_size = 32, bits_to_out1 = 32, bits_to_out2 = 32)
(
	 input wire                  selector,     //entrada de seleção da saída de dados.
	 input wire [data_bits-1:0]      data,     //entrada de dados.
	output reg  [out1_bits_size-1:0] out1,     //primeira saída de dados.
 	output reg  [out2_bits_size-1:0] out2     //segunda saída de dados.
);

//Bloco combinacional para redirecionamento da entrada.
always @(*) begin
	out1 = 0;     //valores default;
	out2 = 0;
	if(selector == 1'b0) 
		out1 = data[bits_to_out1-1:0];
	else begin            //selector == 1'b1;
		out2 = data[bits_to_out2-1:0];
	end
end
endmodule