module modem_control (
    input clk, rst_n, enable,      // Entradas de controle
    input cts,
    output reg rts, enable_tx,              // Saída RTS
    input full, empty             // Entradas FIFO
);

    initial begin
        rts <= 0;
        enable_tx <= 0;
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin // Reseta
            rts <= 0; // Ativa RTS
        end else if (enable) begin // Habilita
            if (empty) begin
                rts <= 0; // Ativa RTS
            end else if (full) begin
                rts <= 1; // Desativa RTS
            end 
        end else begin // Desabilita
            rts <= 0; // Ativa RTS
        end
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            enable_tx <= 0;
        end else if (enable) begin
            if (!cts) begin
                enable_tx <= 1;
            end else begin
                enable_tx <= 0;
            end
        end else begin
            enable_tx <= 1;
        end
    end

endmodule
