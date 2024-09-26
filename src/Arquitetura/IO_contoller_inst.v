	IO_contoller u0 (
		.clk_clk            (<connected-to-clk_clk>),            //         clk.clk
		.irq_export         (<connected-to-irq_export>),         //         irq.export
		.rd_data_lsb_export (<connected-to-rd_data_lsb_export>), // rd_data_lsb.export
		.rd_data_msb_export (<connected-to-rd_data_msb_export>), // rd_data_msb.export
		.reset_reset_n      (<connected-to-reset_reset_n>),      //       reset.reset_n
		.we_export          (<connected-to-we_export>),          //          we.export
		.we_data_lsb_export (<connected-to-we_data_lsb_export>), // we_data_lsb.export
		.we_data_msb_export (<connected-to-we_data_msb_export>)  // we_data_msb.export
	);

