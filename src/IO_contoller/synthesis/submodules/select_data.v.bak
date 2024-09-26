module select_data (
    input       clk, rst_n, enable, data, clr, en_noise_cancelling,
    input [1:0] select_edge,  // Seleção do tipo de borda a ser detectada
    // Outputs
    output capture
);

    wire edge_capture;
	 wire pulso_posedge, pulso_negedge, pulso_both;
	 
    wire reg_data;
	  
	  edge_detector ed(
        /*I*/ .clk(clk),                     // Sinal de clock
        /*I*/ .rst_n(rst_n),     // Habilita o cancelamento de ruído
        /*I*/ .enable(enable),                 // Habilita a detecção de bordas
        /*I*/ .data(data),                   // Sinal de entrada
        /*O*/ .pulso_posedge(pulso_posedge),                  // Sinal de pulso de saída
        /*O*/ .pulso_negedge(pulso_negedge),                  // Sinal de pulso de saída
        /*O*/ .pulso_both(pulso_both),                  // Sinal de pulso de saída
		  /*O*/ .reg_data(reg_data)
    );

    edge_capture ec(
        /*I*/ .clk(clk),                     // Sinal de clock
        /*I*/ .rst_n(rst_n),     // Habilita o cancelamento de ruído
        /*I*/ .enable(enable),                 // Habilita a detecção de bordas
        /*I*/ .data(data),                   // Sinal de entrada
        /*I*/ .clr(clr),                   // Sinal de entrada
        /*I*/ .select_edge(select_edge),     // Seleciona o tipo de borda
        /*I*/ .edge_capture(edge_capture),                  // Sinal de pulso de saída
		  /*I*/ .pulso_posedge(pulso_posedge),                  // Sinal de pulso de saída
        /*I*/ .pulso_negedge(pulso_negedge),                  // Sinal de pulso de saída
        /*O*/ .pulso_both(pulso_both)
    );

    assign capture = (en_noise_cancelling) ? edge_capture : reg_data; 
    
endmodule