module edge_capture (
    // Inputs
    input       clk, rst_n, enable, data, clr,
	 input       pulso_posedge, pulso_negedge, pulso_both,
    input [1:0] select_edge,  // Seleção do tipo de borda a ser detectada
    // Outputs
    output reg     edge_capture
); 
    reg [2:0] reg_capture;

    initial begin
        reg_capture = 3'b000;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_capture <= 3'b000;
        end else if (enable) begin
            if (clr) begin
                case (select_edge)
                    2'b00: reg_capture[0] <= 1'b0;
                    2'b01: reg_capture[1] <= 1'b0;
                    2'b10: reg_capture[2] <= 1'b0;
                    2'b11: reg_capture <= 3'b000;
                    default: reg_capture <= 3'b000;
                endcase
            end else begin
                if (pulso_posedge) 
                    reg_capture[0] <= 1'b1;
						  
                if (pulso_negedge) 
                    reg_capture[1] <= 1'b1;
                
					 if (pulso_both) 
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
            2'b11: edge_capture <= 1'b0;
            default: edge_capture <= 1'b0;
        endcase
    end

endmodule