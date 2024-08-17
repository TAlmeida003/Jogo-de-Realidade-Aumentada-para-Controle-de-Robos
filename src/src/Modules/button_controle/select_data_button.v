//**********************************************************************************
// Select Data Button
//**********************************************************************************
// Módulo: select_data_button
// Descrição: Este módulo seleciona e captura o sinal de entrada baseado na 
// detecção de bordas. O módulo utiliza um detector de bordas para monitorar 
// o sinal de entrada, e pode aplicar um cancelamento de ruído conforme 
// especificado. O sinal de saída indica se uma borda foi capturada ou se 
// o sinal de entrada deve ser passado diretamente.
//
//**********************************************************************************

module select_data_button (
    // Inputs
    input  wire       clk, rst_n, clr, data, en_noise_cancelling, clk_div,
    input  wire [1:0] select_edge,  

    // Outputs
    output wire       capture    
);
    
    wire pulso;                      // Sinal de pulso gerado pelo detector de bordas
    reg edge_capture, d;                // Registrador para armazenar o estado da captura de borda

    // Inicializa o registrador 'edge_capture' para 0
    initial begin
        edge_capture = 1'b0;
		  d <= 1'b0;
    end

    // Instância do módulo edge_detector para detectar bordas
    edge_detector ed(
        /*I*/ .clk(clk_div),                     // Sinal de clock
        /*I*/ .rst_n(rst_n),     // Habilita o cancelamento de ruído
        /*I*/ .enable(en_noise_cancelling),                 // Habilita a detecção de bordas
        /*I*/ .select_edge(select_edge),     // Seleciona o tipo de borda
        /*I*/ .data(data),                   // Sinal de entrada
        /*O*/ .pulso(pulso)                  // Sinal de pulso de saída
    );
	 
	 always @(posedge clk) begin
		d <= pulso;
	 end 


    // Lógica para capturar o sinal baseado na detecção de bordas
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            edge_capture <= 1'b0;           // Reseta a captura de borda
        end else if (en_noise_cancelling) begin
            if (clr) begin
                edge_capture <= 1'b0;
            end else if (pulso & ~d) begin
                edge_capture <= 1'b1;       // Captura a borda
            end
        end
    end

    // Atribuição do sinal de saída 'capture' baseado no cancelamento de ruído
    assign capture = (en_noise_cancelling) ? edge_capture : data;

endmodule
