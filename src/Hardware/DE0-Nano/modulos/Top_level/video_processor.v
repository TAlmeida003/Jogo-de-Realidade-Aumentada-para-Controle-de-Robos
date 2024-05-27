module video_processor(
	input wire clk_100,
	input wire clk_25,
	input wire reset,
	input wire [31:0] dataA,
	input wire [31:0] dataB,
 	input wire        rdempty,
	output wire [2:0] R,
	output wire [2:0] G,
	output wire [2:0] B,
	output wire        out_hsync,
	output wire        out_vsync,
	output wire        out_rdreg
);

/*------------------Fios de ligação entre os módulos---------------------*/
wire        new_instruction;
// Barramentos do Decodificador 
wire [3:0]  out_opcode;
wire [4:0]	out_register;
wire [31:0] out_data_decoded;
wire [13:0] out_sprite_address;
wire [12:0] out_background_address;
wire [8:0]  in_memory_data;
//======================================
// Barramentos da Memoria de Background
wire [12:0] addr_block;
wire [12:0] back_address;
wire [8:0]  back_memory_out;
//======================================
// Barramentos do Modulo Gerador de Saida RGB
wire is_sprite;
wire is_block;
wire refresh_vga_out;
wire [8:0] block_color;
//===============================================
wire 		done_register;
wire [19:0] check_value;
wire [31:0] data_reg;
wire [13:0] sprite_address;
wire [13:0] decoded_address;
wire 		active_area;
wire [13:0] address;
wire [8:0]  sp_memory_out;
wire        done_back_memory;
wire        done_sprite_memory;
wire [8:0]  monitor_color_out;
wire [9:0]  pixel_x;
wire [9:0]  pixel_y;
wire        reset_done;
wire 		printting;
wire [9:0]  new_px;
wire [9:0]  new_py;
wire        draw_screen;
wire        refresh_comp;
wire        refresh_select;
wire        is_x;
wire        en_execution;
wire [8:0]	color_out;
/*------------------------------------------------------------------------*/

/*-----------Saídas do banco de registradores------------*/
wire [31:0] r0;
wire [31:0] r1;
wire [31:0] r2;
wire [31:0] r3;
wire [31:0] r4;
wire [31:0] r5;
wire [31:0] r6;
wire [31:0] r7;
wire [31:0] r8;
wire [31:0] r9;
wire [31:0] r10;
wire [31:0] r11;
wire [31:0] r12;
wire [31:0] r13;
wire [31:0] r14;
wire [31:0] r15;
wire [31:0] r16;
wire [31:0] r17;
wire [31:0] r18;
wire [31:0] r19;
wire [31:0] r20;
wire [31:0] r21;
wire [31:0] r22;
wire [31:0] r23;
wire [31:0] r24;
wire [31:0] r25;
wire [31:0] r26;
wire [31:0] r27;
wire [31:0] r28;
wire [31:0] r29;
wire [31:0] r30;
wire [31:0] r31;
/*------------------------------------------------------*/
/*-----Sinais da unidade de controle para o gerenciamento dos módulos-----*/
wire 	 register_wr;
wire 	 memory_wr_SP;
wire 	 memory_wr_BK;
wire 	 selectorAddress;
wire 	 instruction_finished;
wire     rdreg;
wire     reset_modules;
wire 	 reset_rsd;
wire     enable_counter;
/*------------------------------------------------------------------------*/
reg 	 reg_done;
reg      is_pixel;
// Barramentos e sinais de Entrada e saída do Co-Processador.
wire [3:0]  co_processor_address;
wire [8:0]	co_processor_color;
wire enable_written_co_processor;
/*------------------------------------------------------------------------*/
decorderInstruction 
decorderInstruction_inst
(
	.clk_en(clk_100) ,					// input  clk_en_sig
	.reset(reset_rsd),
	.dataA(dataA) ,				    	// input [31:0] dataA_sig
	.dataB(dataB) ,						// input [31:0] dataB_sig
	.new_instruction(new_instruction) ,	// input  new_instruction_sig
	.out_opcode(out_opcode) ,			// output [1:0]  out_opcode_sig
	.out_register(out_register) ,		// output [13:0] out_register_sig
	.out_data_decoded(out_data_decoded),
	.out_sprite_address(out_sprite_address),
	.out_background_address(out_background_address),
	.out_memory_data(in_memory_data),
	.out_co_processor_memory_address(co_processor_address)
);

controlUnit 
controlUnit_inst
(
	.clk(clk_100) ,							// OK input  clk_sig
	.reset(!reset) ,						// OK input  reset_sig
	.opCode(out_opcode) ,					// OK input [3:0] opCode_sig
	.printtingScreen(draw_screen) ,		    // input  printtingScreen_sig
	.doneInst(instruction_finished) ,	    // OK input  doneInst_sig
	.en_execution(en_execution),            // OK
	.register_wr(register_wr),
	.memory_wr_SP(memory_wr_SP) ,		
	.memory_wr_BK(memory_wr_BK) ,
	.selectorAddress(selectorAddress), 		// OK output  selectorAddress_sig
	.reset_done(reset_done),                // OK
	.reset_modules(reset_modules),          
	.reset_rsd(reset_rsd),
 	.enable_written_co_processor(enable_written_co_processor)
);


ControlUnit_aux 
ControlUnit_aux_inst
(
	.clk(clk_100) ,	                         // input  clk_sig
	.reset(reset_modules) ,	                 // input  reset_sig
	.print(draw_screen) ,	                 // input  print_sig
	.end_instruction(instruction_finished),  // input  end_instruction_sig
	.fifo_empty(rdempty) ,	                 // input  fifo_empty_sig
	.en_reading(rdreg) ,	                 // output  en_reading_sig
	.en_refresh_decode(new_instruction) ,	 // output  en_refresh_decode_sig
	.en_execution(en_execution) 	         // output  en_execution_sig
);

/*------------------Banco de registradores-------------*/
registerFile 
registerFile_inst
(
	.clk(clk_100) ,			  	// input  clk
	.reset(reset_rsd) ,	  	    // input  reset
	.n_reg(out_register) ,		// input [4:0] n_reg
	.data(out_data_decoded) ,	// input [31:0] data
	.written(register_wr) ,	  	// input  written
	.r0(r0) ,	// Registrador que armazena a cor base do background. 
	.r1(r1) ,	// output [31:0] r1
	.r2(r2) ,	// output [31:0] r2
	.r3(r3) ,	// output [31:0] r3
	.r4(r4) ,	// output [31:0] r4
	.r5(r5) ,	// output [31:0] r5
	.r6(r6) ,	// output [31:0] r6
	.r7(r7) ,	// output [31:0] r7
	.r8(r8) ,	// output [31:0] r8
	.r9(r9) ,	// output [31:0] r9
	.r10(r10) ,	// output [31:0] r10
	.r11(r11) ,	// output [31:0] r11
	.r12(r12) ,	// output [31:0] r12
	.r13(r13) ,	// output [31:0] r13
	.r14(r14) ,	// output [31:0] r14
	.r15(r15) ,	// output [31:0] r15
	.r16(r16) ,	// output [31:0] r16
	.r17(r17) ,	// output [31:0] r17
	.r18(r18) ,	// output [31:0] r18
	.r19(r19) ,	// output [31:0] r19
	.r20(r20) ,	// output [31:0] r20
	.r21(r21) ,	// output [31:0] r21
	.r22(r22) ,	// output [31:0] r22
	.r23(r23) ,	// output [31:0] r23
	.r24(r24) ,	// output [31:0] r24
	.r25(r25) ,	// output [31:0] r25
	.r26(r26) ,	// output [31:0] r26
	.r27(r27) ,	// output [31:0] r27
	.r28(r28) ,	// output [31:0] r28
	.r29(r29) ,	// output [31:0] r29
	.r30(r30) ,	// output [31:0] r30
	.r31(r31) ,	// output [31:0] r31
	.out_success(done_register) 	// output  success
);
/*-----------------------------------------------------------*/

comparator_module comparator_module_inst
(
	.clk(clk_100),
	.reset(reset_modules),
	.r1(r1),	// input [31:0] r1_sig
	.r2(r2),	// input [31:0] r2_sig
	.r3(r3),	// input [31:0] r3_sig
	.r4(r4),	// input [31:0] r4_sig
	.r5(r5),	// input [31:0] r5_sig
	.r6(r6),	// input [31:0] r6_sig
	.r7(r7),	// input [31:0] r7_sig
	.r8(r8),	// input [31:0] r8_sig
	.r9(r9),	// input [31:0] r9_sig
	.r10(r10),	// input [31:0] r10_sig
	.r11(r11),	// input [31:0] r11_sig
	.r12(r12),	// input [31:0] r12_sig
	.r13(r13),	// input [31:0] r13_sig
	.r14(r14),	// input [31:0] r14_sig
	.r15(r15),	// input [31:0] r15_sig
	.r16(r16),	// input [31:0] r16_sig
	.r17(r17),	// input [31:0] r17_sig
	.r18(r18),	// input [31:0] r18_sig
	.r19(r19),	// input [31:0] r19_sig
	.r20(r20),	// input [31:0] r20_sig
	.r21(r21),	// input [31:0] r21_sig
	.r22(r22),	// input [31:0] r22_sig
	.r23(r23),	// input [31:0] r23_sig
	.r24(r24),	// input [31:0] r24_sig
	.r25(r25),	// input [31:0] r25_sig
	.r26(r26),	// input [31:0] r26_sig
	.r27(r27),	// input [31:0] r27_sig
	.r28(r28),	// input [31:0] r28_sig
	.r29(r29),	// input [31:0] r29_sig
	.r30(r30),	// input [31:0] r30_sig
	.r31(r31),	// input [31:0] r31_sig
	.check(check_value),	// input [19:0] check_sig
	.refresh_comp(refresh_comp),
	.refresh_select(refresh_select),
	.readData(data_reg) 	// output [31:0] readData_sig
);

/*-------Multiplexador para selecionar a entrada de endereço para a memória de sprites--------*/
multiplexador #(.data_bits1(14), .data_bits2(14), .out_bits_size(14))
multiplexador_inst
(
	.selector(selectorAddress) ,  	// input  selector_sig
	.data(out_sprite_address) ,		// input [data_bits1-1:0] data_sig  (vem do decodificador)
	.data2(sprite_address) ,	   	// input [data_bits2-1:0] data2_sig (vem do módulo de impressão)
	.out(address) 					// output [out_bits_size-1:0] out_sig
);

/*-------Multiplexador para selecionar a entrada de endereço para a memória dos blocos de background--------*/
multiplexador #(.data_bits1(13), .data_bits2(13), .out_bits_size(13))
multiplexador_background_inst
(
	.selector(selectorAddress) ,  		// input  selector_sig
	.data(out_background_address) ,		// input [data_bits1-1:0] data_sig  (vem do decodificador)
	.data2(addr_block),	   				// input [data_bits2-1:0] data2_sig (vem do módulo de impressão)
	.out(back_address) 					// output [out_bits_size-1:0] out_sig
);

DrawingModule
DrawingModule_inst(
	.clk(clk_100),
	.reset(reset_modules),
	.reset_block_module(reset_modules),
	.is_pixel(is_x),
	.block_color(back_memory_out),
	.data_reg(data_reg),
	.pixel_x(pixel_x),			// Pixel x atual
	.pixel_y(pixel_y),			// Pixel y atual
	.prox_pixel_x(new_px),		// Proximo pixel x
	.prox_pixel_y(new_py),		// Proximo pixel y
	.refresh_comp(refresh_comp),
	.refresh_select(refresh_select),
	.memory_address(sprite_address),	// Endereco de memoria do sprite atual.
	.out_addr_block(addr_block),		// Endereco de memoria do block de background atual.
	.out_is_sprite(is_sprite),			// Informa se o pixel atual pertence a um sprite.
	.out_is_block(is_block),			// Informa se o block atual de background esta ativo.
	.out_block_color(block_color),		// Cor do bloco de background atual.
	.refresh_vga_out(refresh_vga_out)
);

/* ================================================================================================ */
/* =================== Co-Processador para processamento de Formas Geométricas ==================== */
wire w_memory;
geometric_Forms_Processor geometric_Forms_Processor_inst
(
	.clk(clk_100),									// Clock de Funcionamento do Processador.
	.clk_25(clk_25),								// Clock de Leitura da Memória de Saída.
	.reset(reset_modules),							// Sinal de reset para sincronizar junto com o controlador VGA.
	.reset_done(reset_done),
	.active_area(active_area), 						// Sinal que informa se a renderização da tela está ou não na área ativa.
	.printtingScreen(printting) ,					// Sinal que informa se a tela está sendo renderizada.
	.enable_written(enable_written_co_processor),	// Sinal que habilita escrita na memória de instrução.
	.vga_x(pixel_x),								// Coordenada X atual do monitor VGA.
	.vga_y(pixel_y),								// Coordenada Y atual do monitor VGA.
	.in_address(co_processor_address) ,				// Barramento de endereço para escrita na memória de instrução.
	.instruction(out_data_decoded),					// Barramento de dados da instrução.
	.geo_color(co_processor_color), 				// Barramento de saída (cores RGB)
	.w_memory(w_memory)
);
/* ================================================================================================ */
/* ================================================================================================ */

back_memory back_memory_inst
(
	.address(back_address) ,		// input [13:0] address_sig
	.clock(clk_100) ,				// input  clock_sig  (100Mhz)
	.reset_done(reset_done),
	.data(in_memory_data) ,		    // input [8:0] data_sig
	.wren(memory_wr_BK) ,			// input  wren_sig
	.out_data(back_memory_out) ,	// output [8:0] out_data_sig
	.read_memory(done_back_memory) 	// output  read_memory_sig
);

sprite_memory sprite_memory_inst
(
	.address(address) ,				  // input [13:0] address_sig
	.clock(clk_100) ,				  // input  clock_sig  (100Mhz)
	.reset_done(reset_done),
	.data(in_memory_data) ,		  	  // input [8:0] data_sig
	.wren(memory_wr_SP) ,			  // input  wren_sig
	.out_data(sp_memory_out) ,	  	  // output [8:0] out_data_sig
	.read_memory(done_sprite_memory)  // output  read_memory_sig
);


/*------------Módulo para geração do sinais de sincronização do monitor e seus pixeis-----------*/
VGA_sync VGA_sync_inst
(
	.clock(clk_25),				// input  clock_sig
	.reset(reset_modules),		// input  reset_sig
	.hsync(out_hsync),			// output  hsync_sig
	.vsync(out_vsync),			// output  vsync_sig
	.video_enable(active_area),	// output  video_enable_sig
	.pixel_x(pixel_x),			// output [9:0] _sig
	.pixel_y(pixel_y), 			// output [8:0] _sig
	.printting(printting)
);

/*---------------------------- Módulo Gerador de Saída RGB -------------------------------------*/
rgb_out_generator 
rgb_out_generator_inst 
(
	.clk(clk_100),
	.active_area(active_area),
	.co_processor_RGB(co_processor_color),
	.sprite_memory_data(sp_memory_out),
	.block_color(block_color),
	.base_background(r0[8:0]),	// Registrador R0 do banco de registradores.
	.is_sprite(is_sprite),
	.is_block(is_block),
	.rf_vga_out(refresh_vga_out),
	.out_R(R),		// Saida do processador - componente de cor vermelho
	.out_G(G),		// Saida do processador - componente de cor verde
	.out_B(B)		// Saida do processador - componente de cor azul
);


/* ===== Bloco combinacional para verificar se um registro no banco de registradores ou uma leitura na memória foi realiza com sucesso. ======= */
always @(done_register or done_sprite_memory or done_back_memory or w_memory) begin 
	reg_done = done_register | done_sprite_memory | done_back_memory | w_memory;    
end
/* =============================================================================================================================================*/
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
assign new_px = (pixel_x + 10'd1);
assign new_py = (pixel_y + 10'd1);
assign is_x   = is_pixel;
assign check_value = {new_px, pixel_y};
/*-----Atribuicoes de duas saidas da GPU---------*/
assign out_rdreg            = rdreg;
assign instruction_finished = reg_done;
/*-----------------------------------------------*/
endmodule
