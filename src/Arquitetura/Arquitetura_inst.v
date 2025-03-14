	Arquitetura u0 (
		.clk_clk                   (<connected-to-clk_clk>),                   //                clk.clk
		.cts_beginbursttransfer    (<connected-to-cts_beginbursttransfer>),    //                cts.beginbursttransfer
		.data_a_export             (<connected-to-data_a_export>),             //             data_a.export
		.data_b_export             (<connected-to-data_b_export>),             //             data_b.export
		.irq_joystick_export       (<connected-to-irq_joystick_export>),       //       irq_joystick.export
		.rd_joystick_lsb_export    (<connected-to-rd_joystick_lsb_export>),    //    rd_joystick_lsb.export
		.rd_joystick_msb_export    (<connected-to-rd_joystick_msb_export>),    //    rd_joystick_msb.export
		.reset_reset_n             (<connected-to-reset_reset_n>),             //              reset.reset_n
		.reset_pulsecounter_export (<connected-to-reset_pulsecounter_export>), // reset_pulsecounter.export
		.rts_writeresponsevalid_n  (<connected-to-rts_writeresponsevalid_n>),  //                rts.writeresponsevalid_n
		.rx_beginbursttransfer     (<connected-to-rx_beginbursttransfer>),     //                 rx.beginbursttransfer
		.screen_export             (<connected-to-screen_export>),             //             screen.export
		.tx_writeresponsevalid_n   (<connected-to-tx_writeresponsevalid_n>),   //                 tx.writeresponsevalid_n
		.we_joystick_export        (<connected-to-we_joystick_export>),        //        we_joystick.export
		.we_joystick_lsb_export    (<connected-to-we_joystick_lsb_export>),    //    we_joystick_lsb.export
		.we_joystick_msb_export    (<connected-to-we_joystick_msb_export>),    //    we_joystick_msb.export
		.wrfull_export             (<connected-to-wrfull_export>),             //             wrfull.export
		.wrreg_export              (<connected-to-wrreg_export>)               //              wrreg.export
	);

