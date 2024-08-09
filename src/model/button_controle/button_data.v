module button_data #(
    parameter NUM_BUTTONS =8  // Parâmetro para definir o número de botões
) (
    input  wire        clk,
    input  wire [NUM_BUTTONS-1:0] rst,
    input  wire [NUM_BUTTONS-1:0] noise_cancelling,
    input  wire [2*NUM_BUTTONS-1:0] select_edge,
    input  wire [NUM_BUTTONS-1:0] button,
    output wire [31:0] capture
); 
	wire [NUM_BUTTONS-1:0] aux_capture;

    genvar i; // Variável de geração

    generate
        for (i = 0; i < NUM_BUTTONS; i = i + 1) begin : dc_inst
            data_capture dc_inst (
                /*I*/ .clk(clk),
                /*I*/ .rst(rst[i]),
                /*I*/ .select_edge(select_edge[(i * 2 + 1):(i * 2)]),
                /*I*/ .noise_cancelling(noise_cancelling[i]),
                /*I*/ .data(button[i]),
                /*O*/ .capture(aux_capture[i])
            );
        end
    endgenerate
	 
	 assign capture = { {32-NUM_BUTTONS{1'b0}}, aux_capture };

endmodule