module top_edge_capture (
    input  wire [7:0]  butoes,
    input  wire        clk,
    input  wire        we,
    input  wire        rd,
    input  wire [1:0]  register_addr,
    input  wire [31:0] wr_data,
    output wire [31:0] rd_data,
    output wire        ready
);

    localparam NUM_BUTTONS = 8;
    
    wire [31:0]                  register [3:0];
    wire [1:0]                   TR;
    wire [NUM_BUTTONS - 1:0]     RSTR, NCR, RS;
    wire [2 * NUM_BUTTONS - 1:0] CCR;
    wire                         clk_div, CRR, we_system;
	wire [31:0] 			     data_button;
    wire                         done_we, done_rd;
    
    assign ready = done_rd | done_we;
	 
	controle_R0 cr0(
        .clk(clk),
        .rst(),
        .register_0(register[0]),
        .register_button(data_button),
        .we_system(we_system)
    );

    regiter_bank rb(
        /*I*/ .clk(clk),  
        /*I*/ .we(we),
        /*I*/ .we_system(we_system),             
        /*I*/ .wr_addr(register_addr),  
        /*I*/ .wr_data(wr_data),   
        /*I*/ .wr_data_system(data_button),  
        /*O*/ .rd_reg0(register[0]),
        /*O*/ .rd_reg1(register[1]),
        /*O*/ .rd_reg2(register[2]),
        /*O*/ .rd_reg3(register[3]),
        /*O*/ .done(done_we)
	);

    read_register rr(
	     /*I*/ .rd(rd),
        /*I*/ .clk(clk),
        /*I*/ .register_0(register[0]),
        /*I*/ .register_1(register[1]),
        /*I*/ .register_2(register[2]),
        /*I*/ .register_3(register[3]),
        /*I*/ .rd_addr(register_addr),
        /*O*/ .rd_data(rd_data),
        /*O*/ .done(done_rd)
    );

    controller_bus #(
        /*P*/ .NUM_BUTTONS(NUM_BUTTONS)
        ) cb(
        /*I*/ .register_1(register[1]),
		/*I*/ .register_2(register[2]),
        /*O*/ .CRR(CRR),
        /*O*/ .TR(TR),
        /*O*/ .RSTR(RSTR),
        /*O*/ .NCR(NCR),
        /*O*/ .CCR(CCR)
    );
    
    time_counter tc(
        /*I*/ .clk(clk),
        /*I*/ .rst(CRR),          
        /*I*/ .select_clk(TR), 
        /*O*/ .clk_out(clk_div)
    );

    button_data #(
        /*P*/ .NUM_BUTTONS(NUM_BUTTONS)
        ) btd(
        /*I*/ .clk(clk_div),
        /*I*/ .rst(RSTR),            
        /*I*/ .noise_cancelling(NCR), 
        /*I*/ .select_edge(CCR), 
        /*I*/ .button(butoes),
        /*O*/ .capture(data_button) 
    );

	
endmodule 