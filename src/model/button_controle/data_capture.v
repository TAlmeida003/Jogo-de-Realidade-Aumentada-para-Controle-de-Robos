module data_capture (
    input  wire       clk,          // Sinal de clock
    input  wire       rst,
    input  wire       data,         // Sinal de entrada a ser monitorado
    input  wire [1:0] select_edge,  // Seleção do tipo de borda a ser detectada
    input  wire       noise_cancelling,          // Sinal de cancelamento de ruído
    output wire       capture       // Sinal de saída indicando a detecção de borda
);  
    wire pulso;
    reg edge_capture = 0;

    edge_detector ed(
        /*I*/ .clk(clk),
        /*I*/ .rst(noise_cancelling),
        /*I*/ .select_edge(select_edge),
        /*I*/ .data(data),
        /*O*/ .pulso(pulso)
    );

    always @(posedge pulso, posedge rst) begin
        if (rst) begin
            edge_capture <= 0;
        end else begin
            edge_capture <= 1;
        end
    end
    
    assign capture = (noise_cancelling == 1) ? edge_capture : data;
    
endmodule