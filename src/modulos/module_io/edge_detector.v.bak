module edge_detector (
    // Inputs
    input       clk, rst_n, enable, data,
    // Outputs
    output   pulso_posedge, pulso_negedge, pulso_both
);
    reg [1:0] reg_d;

    initial begin
        reg_d = 2'b00;
    end

    // Bloco de registro que armazena o valor atual de 'data' na borda de subida do clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_d <= 2'b00;
        end else if (enable) begin
            reg_d[0] <= data;
				reg_d[1] <= reg_d[0];
        end
    end

    // Bloco de detecção de bordas
    assign pulso_posedge = ~reg_d[0] &  reg_d[1];  // Detecção de borda de subida
    assign pulso_negedge =  reg_d[0] & ~reg_d[1];  // Detecção de borda de descida
    assign pulso_both    =  reg_d[0] ^  reg_d[1];      // Detecção de bordas duplas (subida ou descida)
endmodule