module button_data #(
    parameter NUM_BUTTONS = 8;
    parameter DATA_WIDTH = 32
) (
    input wire                      clk, rst_n, clk_div,           
    input wire  [NUM_BUTTONS-1:0]   button, clr,  en_noise_cancelling, 
    input wire  [2*NUM_BUTTONS-1:0] select_edge, 

    output wire [DATA_WIDTH - 1:0]       data             
);

    wire [NUM_BUTTONS-1:0] aux_capture;

    genvar i; // Variável de geração

    generate
        for (i = 0; i < NUM_BUTTONS; i = i + 1) begin : sdb_inst
            select_data_button sdb_inst (
                /*I*/ .clk(clk),
					 /*I*/ .clk_div(clk_div),
                /*I*/ .rst_n(rst_n),
                /*I*/ .clr(clr),
                /*I*/ .select_edge(select_edge[(i * 2 + 1):(i * 2)]),
                /*I*/ .en_noise_cancelling(en_noise_cancelling[i]),
                /*I*/ .data(button[i]),
                /*O*/ .capture(aux_capture[i])
            );
        end
    endgenerate
	 
	assign data = (rst_n) ? {{DATA_WIDTH-NUM_BUTTONS{1'b0}}, aux_capture} : 32'd0;
    
endmodule