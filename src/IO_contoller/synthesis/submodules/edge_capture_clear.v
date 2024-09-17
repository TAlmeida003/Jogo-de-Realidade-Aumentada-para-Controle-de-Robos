module edge_capture_clear #(
    parameter NUM_INPUTS = 12
) (
    input  wire                  clk, rst_n, we, 
    input wire register_addr, enable,
    input [NUM_INPUTS -1:0] wr_data,
    input [NUM_INPUTS - 1:0] noise_canc,
    output wire [NUM_INPUTS-1:0] clear_data,
    output done
);
        
    reg   pulso_clear;
    wire   [NUM_INPUTS-1:0] clear_aux;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pulso_clear <= 1'b0;
        end else if (enable) begin
            pulso_clear <= we & !register_addr;
        end
    end

    genvar i;
    generate
        for (i = 0; i < NUM_INPUTS; i = i + 1) begin : clear_logic
            assign clear_aux[i] = (we & !register_addr) & noise_canc[i] & wr_data[i];
        end
    endgenerate

    assign clear_data = clear_aux;
    assign done = pulso_clear;
    
endmodule