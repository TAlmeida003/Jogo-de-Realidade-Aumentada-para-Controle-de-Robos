module edge_capture (
    // Inputs
    input       clk, rst_n, enable, data, clr, interrupt_mask,
	 input       pulso_posedge, pulso_negedge, pulso_both,
    input [1:0] select_edge, select_interrupt,
    // Outputs
    output reg     edge_capture, irq
); 
    reg [2:0] reg_capture;

    initial begin
        reg_capture = 3'b000;
    end
	 
	 always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin
				reg_capture[0] <= 1'b0;
			end else if(enable) begin
				if (clr & (select_edge == 2'b00)) begin
					reg_capture[0] <= 1'b0;
				end else if (pulso_posedge) begin
					reg_capture[0] <= 1'b1;
				end
			end
	 end

	 always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin
				reg_capture[1] <= 1'b0;
			end else if(enable) begin
				if (clr & select_edge == 2'b01) begin
					reg_capture[1] <= 1'b0;
				end else if (pulso_negedge) begin
					reg_capture[1] <= 1'b1;
				end
			end
	 end
	 
	 always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin
				reg_capture[2] <= 1'b0;
			end else if(enable) begin
				if (clr & select_edge == 2'b10) begin
					reg_capture[2] <= 1'b0;
				end else if (pulso_both) begin
					reg_capture[2] <= 1'b1;
				end
			end
	 end

    // Atribuição do sinal de saída 'capture' baseado no cancelamento de ruído
    always @(*) begin
        case (select_edge)
            2'b00: edge_capture <= reg_capture[0];
            2'b01: edge_capture <= reg_capture[1];
            2'b10: edge_capture <= reg_capture[2];
            2'b11: edge_capture <= !data;
            default: edge_capture <= 1'b0;
        endcase
    end
	 
	 always @(*) begin
        case (select_interrupt)
            2'b00: irq <= reg_capture[0] & interrupt_mask;
            2'b01: irq <= reg_capture[1] & interrupt_mask;
            2'b10: irq <= reg_capture[2] & interrupt_mask;
            2'b11: irq <= !data & interrupt_mask;
            default: edge_capture <= 1'b0;
        endcase
    end


endmodule