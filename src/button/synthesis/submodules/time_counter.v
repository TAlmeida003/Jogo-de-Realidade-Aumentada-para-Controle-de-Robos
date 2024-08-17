//**********************************************************************************
// Time Counter
//**********************************************************************************
//
// Módulo: time_counter
// Descrição: Este módulo conta os ciclos de clock e gera um sinal de clock de saída
// com base no valor do contador. O sinal de clock de saída pode ser configurado para
// refletir o sinal de clock de entrada ou bits específicos do contador, dependendo
// do valor de `select_clk`.
//
//**********************************************************************************

module time_counter (
    input  wire       clk, rst_n,           // Sinal de reset assíncrono
    input  wire [1:0] select_clk,    // Seleção do sinal de clock de saída
    output reg        clk_out        // Sinal de clock de saída
);

    reg [19:0] counter;

    initial begin
        counter = 20'b0;
        clk_out = 1'b0;
    end

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
            counter <= 20'b0;
			clk_out <= 1'b0;
        end else begin
            counter <= counter + 20'b1; // Incrementa o contador
			case (select_clk)
				2'b00   : clk_out <= counter[16];          // Dividir por 1, sinal de clock de entrada
				2'b01   : clk_out <= counter[17];   // Dividir por 2, sinal de clock do bit 0 do contador
				2'b10   : clk_out <= counter[18];   // Dividir por 4, sinal de clock do bit 1 do contador
				2'b11   : clk_out <= counter[19];   // Dividir por 8, sinal de clock do bit 2 do contador
				default : clk_out <= 1'b0;         // Caso padrão, nenhum sinal de clock gerado
			endcase
        end
    end
	 
endmodule
