//**********************************************************************************
// Edge Detector
//**********************************************************************************
//
// Módulo: edge_detector
// Descrição: Este módulo detecta transições de borda em um sinal de entrada.
// Ele pode ser configurado para detectar bordas de subida, bordas de descida ou
// ambas (bordas duplas) com base no parâmetro `EDGE_DETECT`.
//
//**********************************************************************************

module edge_detector (
    input  wire          clk,          // Sinal de clock
    input  wire          rst,          // Sinal de reset assíncrono
    input  wire          data,         // Sinal de entrada a ser monitorado
    input  wire [1:0]    select_edge,  // Seleção do tipo de borda a ser detectada
    output wire          pulso         // Sinal de saída indicando a detecção de borda
);
    
    reg reg_d, pulso_aux;

    // Bloco de registro que armazena o valor atual de 'data' na borda de subida do clock
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            reg_d <= 1'b0;
				pulso_aux <= 1'b0;
        end else begin
            reg_d <= data;
				case (select_edge)
					2'b00   : pulso_aux <=  data & ~reg_d; // Detecção de borda de subida
					2'b01   : pulso_aux <= ~data &  reg_d; // Detecção de borda de descida
					2'b10   : pulso_aux <=  data ^  reg_d;  // Detecção de bordas duplas (subida ou descida)
					2'b11   : pulso_aux <=  data ^  reg_d;  // Detecção de bordas duplas (subida ou descida)
					default : pulso_aux <= 1'b0;            // Caso padrão, nenhum pulso gerado
        endcase
        end
    end
	 
	// Bloco mux para determinar o pulso com base no tipo de borda selecionado 

    // Atribuição do pulso de saída, ativado apenas quando o reset não está ativo
    assign pulso = pulso_aux;

endmodule
