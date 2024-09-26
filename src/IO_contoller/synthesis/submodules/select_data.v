module select_data (
    input       clk, rst_n, enable, data, clr, en_noise_cancelling, clk_noise, interrupt_mask,
    input [1:0] select_edge, select_interrupt,
    // Outputs
    output capture, irq
);

    wire edge_capture;
	 wire pulso_posedge, pulso_negedge, pulso_both;
	 wire aux_pulso_posedge, aux_pulso_negedge, aux_pulso_both;
    reg reg_data;
	 
	 reg [2:0] syn_capture;
	
	  edge_detector ed(
        /*I*/ .clk(clk_noise),                     // Sinal de clock
        /*I*/ .rst_n(rst_n),     // Habilita o cancelamento de ruído
        /*I*/ .enable(enable),                 // Habilita a detecção de bordas
        /*I*/ .data(data),                   // Sinal de entrada
        /*O*/ .pulso_posedge(aux_pulso_posedge),                  // Sinal de pulso de saída
        /*O*/ .pulso_negedge(aux_pulso_negedge),                  // Sinal de pulso de saída
        /*O*/ .pulso_both(aux_pulso_both)                  // Sinal de pulso de saída
    );
	 
	 always @(posedge clk or negedge rst_n) begin
		  if (!rst_n) begin
				reg_data <= 1'b0;
		  end else if (enable) begin
				reg_data <= data;
		  end 
	 end
 
	 always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            syn_capture <= 3'b000;
        end else if (enable) begin
            syn_capture <= {aux_pulso_posedge, aux_pulso_negedge, aux_pulso_both};
        end
    end
	 
	  assign pulso_posedge = ~aux_pulso_posedge & syn_capture[2];
	  assign pulso_negedge = ~aux_pulso_negedge & syn_capture[1];
	  assign pulso_both    = ~aux_pulso_both    & syn_capture[0];


    edge_capture ec(
        /*I*/ .clk(clk),                     // Sinal de clock
        /*I*/ .rst_n(rst_n),     // Habilita o cancelamento de ruído
        /*I*/ .enable(enable),                 // Habilita a detecção de bordas
        /*I*/ .data(data),                   // Sinal de entrada
        /*I*/ .clr(clr),                   // Sinal de entrada
		  /*I*/ .interrupt_mask(interrupt_mask),
		  /*I*/ .select_interrupt(select_interrupt),
        /*I*/ .select_edge(select_edge),     // Seleciona o tipo de borda
        /*I*/ .edge_capture(edge_capture),                  // Sinal de pulso de saída
		  /*I*/ .pulso_posedge(pulso_posedge),                  // Sinal de pulso de saída
        /*I*/ .pulso_negedge(pulso_negedge),                  // Sinal de pulso de saída
        /*O*/ .pulso_both(pulso_both),
		  /*O*/ .irq(irq)
    );

    assign capture = (en_noise_cancelling) ? edge_capture : reg_data; 
    
endmodule