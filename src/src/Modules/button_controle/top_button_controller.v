module top_button_controller #(
    parameter NUM_BUTTONS = 8;
    parameter DATA_WIDTH = 32
) (
    // Inputs
    input  wire                     clk, rst_n ,we, rd,
    input  wire  [NUM_BUTTONS-1:0]  buttons,
    input  wire                     register_addr,
    input  wire  [DATA_WIDTH-1:0]   wr_data,

    // Outputs
    output wire  [DATA_WIDTH-1:0]             rd_data,
    output wire done,
	 output wire [NUM_BUTTONS-1:0] leds
);

    wire clk_div, rst_n_aux;
    wire [DATA_WIDTH-1:0] data_button, signs_controle;
    wire [NUM_BUTTONS-1:0] clr_edge_capture;

    assign rst_n_aux = signs_controle[0] && rst_n;
	 assign leds = data_button[7:0];
 
    edge_clear #(
        /*P*/ .DATA_WIDTH(NUM_BUTTONS)
    ) ec (
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n_aux),
        /*I*/ .we(we),
        /*I*/ .register_addr(register_addr),
        /*O*/ .clr_reg(clr_edge_capture)
    );

    register_file #(
        /*P*/ .DATA_WIDTH(DATA_WIDTH),
        /*P*/ .NUM_REGISTERS(2)
    ) rf (
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(we),
        /*I*/ .register_addr_wr(register_addr),
        /*I*/ .register_addr_rd(register_addr),
        /*I*/ .wr_data(wr_data),
		  .rd(rd),
        /*I*/ .wr_data_system(data_button),
        /*O*/ .rd_data(rd_data),
        /*O*/ .rd_data_system(signs_controle),
        /*O*/ .done(done)
    );

    time_counter tc (
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n_aux),
        /*I*/ .select_clk(signs_controle[2:1]),
        /*O*/ .clk_out(clk_div)
    );

    button_data #(
        /*P*/ .NUM_BUTTONS(NUM_BUTTONS),
        /*P*/ .DATA_WIDTH(DATA_WIDTH)
    ) bd (
        /*I*/ .clk(clk),
		  .clk_div(clk_div),
        /*I*/ .rst_n(rst_n_aux),
        /*I*/ .button(buttons),
        /*I*/ .clr(clr_edge_capture),
        /*I*/ .en_noise_cancelling(signs_controle[10:3]),
        /*I*/ .select_edge(signs_controle[26:11]),
        /*O*/ .data(data_button)
    );
	 
endmodule