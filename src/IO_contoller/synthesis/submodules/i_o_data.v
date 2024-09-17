module  i_o_data #(
    parameter NUM_PORTS = 12;
    parameter DATA_WIDTH = 32
)(
    input wire                      clk, rst_n, enable,
    input wire  [NUM_PORTS-1:0]   in_data, clr,  en_noise_cancelling, 
    input wire  [2*NUM_PORTS-1:0] select_edge,

    output wire [DATA_WIDTH - 1:0]       out_data
);
    wire [NUM_PORTS-1:0] aux_capture;
	 reg [19:0] div;
	
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			div <= 20'd0;
		end else if (enable) begin
			div <= div + 20'b1;
		end
	end

    genvar i; // Variável de geração

    generate
        for (i = 0; i < NUM_PORTS; i = i + 1) begin : sb_inst
            select_data sb_inst (.clk(clk),
					 /*I*/ .clk_noise(div[19]),
                /*I*/ .rst_n(rst_n),
                /*I*/ .enable(enable),
                /*I*/ .data(in_data[i]),
                /*I*/ .clr(clr[i]),
                /*I*/ .en_noise_cancelling(en_noise_cancelling[i]),
                /*I*/ .select_edge(select_edge[(i * 2 + 1):(i * 2)]),
                /*O*/ .capture(aux_capture[i])
            );
        end
    endgenerate

    assign out_data = {{DATA_WIDTH - NUM_PORTS{1'b0}}, aux_capture};
    
endmodule