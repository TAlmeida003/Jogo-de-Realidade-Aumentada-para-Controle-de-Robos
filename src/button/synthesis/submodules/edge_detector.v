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
    // Inputs
    input  wire       clk, rst_n, enable, data, 
    input  wire [1:0] select_edge,  // Seleção do tipo de borda a ser detectada
    // Outputs
    output reg        pulso         // Sinal de saída indicando a detecção de borda
);
    
    reg reg_d;

    initial begin
        reg_d = 1'b0;
    end

    // Bloco de registro que armazena o valor atual de 'data' na borda de subida do clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_d <= 1'b0;
			   pulso <= 1'b0;
        end else if (enable) begin
            reg_d <= data;
			case (select_edge)
				2'b00   : pulso <= ~data &  reg_d;  // Detecção de borda de subida
				2'b01   : pulso <=  data & ~reg_d;  // Detecção de borda de descida
				2'b10   : pulso <=  data ^  reg_d;  // Detecção de bordas duplas (subida ou descida)
				2'b11   : pulso <=  data ^  reg_d;  // Detecção de bordas duplas (subida ou descida)
				default : pulso <= 1'b0;            // Caso padrão, nenhum pulso gerado
            endcase
        end
    end

endmodule
