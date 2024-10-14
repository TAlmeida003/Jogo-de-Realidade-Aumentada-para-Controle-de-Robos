module  i_o_data #(
    parameter NUM_PORTS = 12;
    parameter DATA_WIDTH = 64
)(
    input wire                     clk, rst_n, enable,
    input wire  [NUM_PORTS-1:0]    in_data, clr,  en_noise_cancelling, interrupt_mask,
    input wire  [2*NUM_PORTS-1:0]  select_edge, select_interrupt,
    output wire [DATA_WIDTH - 1:0] out_data, 
	 output wire irq
);
    wire [NUM_PORTS-1:0] aux_capture, irq_aux;
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
					 /*I*/ .interrupt_mask(interrupt_mask[i]),
                /*I*/ .select_edge(select_edge[(i * 2 + 1):(i * 2)]),
					 /*I*/ .select_interrupt(select_interrupt[(i * 2 + 1):(i * 2)]),
                /*O*/ .capture(aux_capture[i]),
					 /*O*/ .irq(irq_aux[i])
            );
        end
    endgenerate

    assign out_data = {{DATA_WIDTH - NUM_PORTS{1'b0}}, aux_capture};
	 assign irq = |irq_aux;
    
endmodule