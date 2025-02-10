module uart_unit #(
    parameter DATA_BITS = 8,
              REG_DATA_BITS = 32,
              STOP_BITS_TICK = 16,
              DVSR = 27,
			  DVSR_BITS = 5,
              FIFO_W = 4
) (
    input  wire                  clk, rst_n, 
    input  wire                  rx, rd, wr, cts,
    input wire [1:0]            address,
    input  wire [REG_DATA_BITS-1:0]  wr_data,
    output wire                  tx, rts, irq,
    output wire [REG_DATA_BITS-1:0]  rd_data
);

    wire tick, rx_done, rst_aux;
    wire tx_start, tx_done;
    wire [DATA_BITS-1:0]  rx_fifo_data, tx_fifo_data, reg_rx_data;
    wire almost_empty_rx, almost_full_rx;
    wire tx_enable_flow_control;
    wire tx_full, rx_empty, rx_full, rx_error;
    wire [REG_DATA_BITS-1:0] reg_control_data, reg_mask_interruption, reg_interruption_status;
	 wire addres_zero;
	 
	 
	 assign addres_zero = (address == 2'b00);
    assign rst_aux = rst_n && reg_control_data[0];

    baud_rate_gen #(
		.M(DVSR),
		.N(DVSR_BITS)
	) baud_rate_gen_inst (
		.clk(clk),
		.rst_n(rst_aux),
		.max_tick(tick),
		.q()
	);

    uart_rx #(
		.DATA_BITS(DATA_BITS),
		.STOP_BITS_TICK(STOP_BITS_TICK)
	) uart_rx_inst (
		.clk(clk),
		.rst_n(rst_aux & reg_control_data[4]),
		.rx(rx),
		.s_tick(tick),
		.rx_done(rx_done),
		.rx_error(rx_error),
		.rx_data(rx_fifo_data)
	);

    fifo_cir rx_fifo_inst(
	    .clk(clk),
        .rst_n(rst_aux & reg_control_data[3]),
        .wr(rx_done), 
        .rd(rd && addres_zero),
        .wr_data(rx_fifo_data),
        .empty(rx_empty),
        .full(rx_full),
        .rd_data(reg_rx_data), // fio de 8 bits
        .almost_empty(almost_empty_rx),
        .almost_full(almost_full_rx)
    );

    uart_tx #(
        .DATA_BITS(DATA_BITS),
        .STOP_BITS_TICK(STOP_BITS_TICK)
    ) uart_tx_inst (
        .clk(clk),
        .rst_n(rst_aux & reg_control_data[4]),
        .tx_start(!tx_start && tx_enable_flow_control),
        .s_tick(tick),
        .tx_data(tx_fifo_data),
        .tx_done(tx_done),
        .tx(tx)
    );
    
    fifo_cir tx_fifo_inst(
	    .clk(clk),
        .rst_n(rst_aux & reg_control_data[2]),
        .wr(wr && addres_zero), 
        .rd(tx_done),
        .wr_data(wr_data[7:0]),  // fio de 8 bits
        .empty(tx_start),
        .full(tx_full),
        .rd_data(tx_fifo_data),
        .almost_empty(),
        .almost_full()
    );

    modem_control modem_control_inst (
        .clk(clk),
        .rst_n(rst_aux),
        .enable(reg_control_data[1]),
        .cts(cts),
        .rts(rts),
        .enable_tx(tx_enable_flow_control),
        .full(almost_full_rx | rx_full),
        .empty(almost_empty_rx | rx_empty)
    );
	
    select_read #(
        .DATA_REG_BITS(REG_DATA_BITS)
    ) select_read_inst (
        .address(address),
        .reg_rx_data(reg_rx_data),
        .reg_control_data(reg_control_data),
        .reg_mask_interruption(reg_mask_interruption),
        .reg_interruption_status(reg_interruption_status),
        .read_data(rd_data)
    );

    reg_control #(
        .DATA_REG_BITS(REG_DATA_BITS)
    ) reg_control_inst (
        .clk(clk),
        .rst_n(rst_n),
        .address(address),
        .wr_data(wr_data),
        .external_reg_data({rts, rx_error, tx_start, tx_full, rx_empty, rx_full}),
        .wr(wr),
        .rd_control_data(reg_control_data),
        .rd_mask_interruption(reg_mask_interruption)
    );

    interrupt_control #(
        .DATA_REG_BITS(REG_DATA_BITS)
    ) interrupt_control_inst (
        .clk(clk),
        .rst_n(rst_n),
        .address(address),
        .wr_data(wr_data),
        .reg_mask_interruption(reg_mask_interruption),
        .external_reg_data({!tx_full, rts, tx_start, tx_full, !rx_empty, rx_full, rx_done, tx_done}),
        .wr(wr),
        .rd_interruption_status(reg_interruption_status),
        .irq(irq)
    );
endmodule