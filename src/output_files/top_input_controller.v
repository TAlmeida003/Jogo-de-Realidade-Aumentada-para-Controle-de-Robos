module top_input_controller #(
    parameter NUM_INPUTS = 12;
    parameter DATA_WIDTH = 32
) (
    // Inputs
    input  wire                     clk, rst_n ,we,
    input  wire  [NUM_INPUTS-1:0]   in_data,
    input  wire                     register_addr,
    input  wire  [DATA_WIDTH-1:0]   wr_data,

    // Outputs
    output wire  [DATA_WIDTH-1:0]   rd_data,
    output wire                     done,
    output wire [7:0]   leds
);

    wire rst_aux, done1, done2;
    wire [DATA_WIDTH-1:0] data_io, signs_controle;
    wire [NUM_INPUTS-1:0] clr_edge_capture;

    assign rst_aux = signs_controle[0] && rst_n;
    assign leds = data_io[7:0];
    assign done = done1 || done2;

    controle #(
        /*P*/ .DATA_WIDTH(DATA_WIDTH)
    ) control_inst (
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_n),
        /*I*/ .we(we),
        /*I*/ .register_addr(register_addr),
        /*I*/ .wr_data(wr_data),
        /*O*/ .out_data(signs_controle),
        /*O*/ .done(done1)
    );
    
    edge_capture_clear #(
        /*P*/ .NUM_INPUTS(NUM_INPUTS)
    ) ecc (
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_aux),
        /*I*/ .we(we),
        /*I*/ .register_addr(register_addr),
        /*I*/ .wr_data(wr_data),
        /*I*/ .enable(signs_controle[1]),
        /*I*/ .noise_canc(signs_controle[13:2]),
        /*O*/ .clear_data(clr_edge_capture),
        /*O*/ .done(done2)
    );


    i_o_data #(
        /*P*/ .NUM_PORTS(NUM_INPUTS),
        /*P*/ .DATA_WIDTH(DATA_WIDTH)
    ) io_data_inst (
        /*I*/ .clk(clk),
        /*I*/ .rst_n(rst_aux),
        /*I*/ .enable(signs_controle[1]),
        /*I*/ .in_data(in_data),
        /*I*/ .clr(clr_edge_capture),
        /*I*/ .en_noise_cancelling(signs_controle[13:2]),
        /*I*/ .select_edge({8'b0, signs_controle[29:14]}),
        /*O*/ .out_data(data_io)
    );

    select_read_data #(
        /*P*/ .DATA_WIDTH(DATA_WIDTH)
    ) srd (
        /*I*/ .reg_control(signs_controle),
        /*I*/ .reg_data_io(data_io),
        /*I*/ .read_addr(register_addr),
        /*O*/ .read_data(rd_data)
    );


endmodule