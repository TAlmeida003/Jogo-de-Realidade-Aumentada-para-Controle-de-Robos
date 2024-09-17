module edge_detector (
    // Inputs
    input       clk, rst_n, enable, data,
    // Outputs
    output   pulso_posedge, pulso_negedge, pulso_both, reg_data
);
    reg reg_d;

    initial begin
        reg_d = 1'b0;
    end

    // Bloco de registro que armazena o valor atual de 'data' na borda de subida do clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_d <= 1'b0;
        end else if (enable) begin
            reg_d <= data;
        end
    end

    // Bloco de detecção de bordas
    assign pulso_posedge = ~data &  reg_d;  // Detecção de borda de subida
    assign pulso_negedge =  data & ~reg_d;  // Detecção de borda de descida
    assign pulso_both    =  data ^  reg_d;      // Detecção de bordas duplas (subida ou descida)
	 assign reg_data = reg_d;
endmodule