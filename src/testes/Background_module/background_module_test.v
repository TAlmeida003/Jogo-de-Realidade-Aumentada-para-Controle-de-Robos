`timescale 1ns/1ns
module background_module_test();

integer   	i;
wire      	clk;
wire      	clk_25;
wire      	clk_8;
wire [12:0] out_addr_block;
wire        out_hsync;
wire        out_vsync;
wire        active_area;
wire [9:0]  pixel_x;
wire [9:0]  pixel_y;
wire 		printting;
reg [9:0] 	new_px;
reg [9:0] 	new_py;
reg 	  	clk_FPGA;
reg 	  	is_pixel;
reg [8:0]	color;

/* ---------------------- Sinais da Unidade de Controle ------------------------------*/
reg  [3:0] 	out_opcode;
reg 		draw_screen;
reg 		instruction_finished;
reg 		en_execution;
wire  [2:0]	counter_value;
wire 		register_wr;
wire 		memory_wr_BK;
wire 		memory_wr_SP;
wire 		selectorAddress;
wire 		reset_done;
wire 		reset_modules;
wire 		reset_vga;
wire 		enable_counter;
/*-------------------------------------------------------------------------------------*/

always begin //frequência de 50 MHz
	clk_FPGA = 1'b1;
	#10;
	clk_FPGA = 1'b0;
	#10;
end

// Valor HIGH reseta a PLL
initial begin
	en_execution    = 1'b1;
end

clock_pll clock_pll_inst
(
	.inclk0(clk_FPGA),	// input  inclk0_sig
	.c0(clk) ,			// clock de 100  MHz
	.c1(clk_25), 		// clock de 25   MHz
	.c2(clk_8)          // clock de 8.33 MHz
);

BlockModule #(.size_x(10), .size_y(10), .size_address(13) )
BlockModule_inst
(
	.clk(clk), 						// Clock com frequencia de 100 MHz
	.reset(reset_vga),				// Sinal de reset
	.pixel_x(new_px),	    		// Proxima coordenada x que sera processada.
	.pixel_y(new_py),	    		// Proxima coordenada y que sera processada.
   	.addr_block(out_addr_block)		// Endereco de Memoria do bloco de background atual
);

/*------------Módulo para geração do sinais de sincronização do monitor e seus pixeis-----------*/
VGA_sync VGA_sync_inst
(
	.clock(clk_25),				// input  clock_sig
	.reset(reset_vga),			// input  reset_sig
	.hsync(out_hsync),			// output  hsync_sig
	.vsync(out_vsync),			// output  vsync_sig
	.video_enable(active_area),	// output  video_enable_sig
	.pixel_x(pixel_x),			// output [9:0] _sig
	.pixel_y(pixel_y), 			// output [8:0] _sig
	.printting(printting)
);

counter #(.n_bits(3))
counter_inst(
	.clk(clk),
	.reset(enable_counter),
	.value(counter_value)
);

/*-------------------------------Módulo da Unidade de Controle-----------------------------------*/
controlUnit 
controlUnit_inst
(
	.clk(clk) ,							// OK input  clk_sig
	.reset(reset) ,						// OK input  reset_sig
	.opCode(out_opcode) ,					// OK input [3:0] opCode_sig
	.printtingScreen(draw_screen) ,		    // input  printtingScreen_sig
	.doneInst(instruction_finished) ,	    // OK input  doneInst_sig
	.en_execution(en_execution),            // OK
	.counter(counter_value),
	.register_wr(register_wr),
	.memory_wr_SP(memory_wr_SP) ,		
	.memory_wr_BK(memory_wr_BK) ,
	.selectorAddress(selectorAddress), 		// OK output  selectorAddress_sig
	.reset_done(reset_done),                // OK
	.reset_modules(reset_modules),          
	.reset_vga(reset_vga),                  
 	.enable_counter(enable_counter)
);

always @(new_px or new_py) begin
	if(new_py <= 10'd480) begin
		if(new_px == 10'd800 && new_py == 10'd480) begin //ultimo pixel da area ativa foi impresso.
			is_pixel = 1'b0;	
		end
		else if(new_px == 10'd800) begin
			is_pixel = 1'b1; // Uma nova linha ira iniciar. Ou seja, o proximo pixel é zero.
		end
		else if(new_px >= 10'd640 & new_px <= 10'd799) begin
			is_pixel = 1'b0; // area inativa da tela.		
		end
		else begin
			is_pixel = 1'b1;
		end
	end
	else begin
		if(new_px == 10'd800 && new_py == 10'd524) begin //ou seja, proximo pixel é [0,0]. O controlador vga ira reiniciar a contagem.
			is_pixel  = 1'b1;
		end
		else begin
			is_pixel  = 1'b0;
		end
	end
end

assign draw_screen = ( (new_px == 10'd800 && new_py == 10'd524) || printting == 1'b1) ? 1'b1 : 1'b0;
assign new_px = (pixel_x + 1);
assign new_py = (pixel_y + 1);
assign is_x   = is_pixel;
//assign check_value = (refresh_comp == 1'b1) ? {new_px,pixel_y} : {new_px-1, pixel_y};
assign check_value = {new_px, pixel_y};

endmodule