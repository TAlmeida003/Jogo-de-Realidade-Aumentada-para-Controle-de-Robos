module geometric_Forms_Processor(
	input wire  clk,
	input wire  clk_25,
	input wire  reset,
	input wire  reset_done,
	input wire  active_area,
	input wire  printtingScreen,
	input wire  enable_written,
	input wire 	[9:0]  vga_x,
	input wire 	[9:0]  vga_y,
	input wire  [3:0]  in_address,   	//endereço para escrita na memória de instrução
	input wire  [31:0] instruction,
   output wire  [8:0]  geo_color,
   output reg    		  w_memory
);
/*
INSTRUCTION FORMAT:
	instruction[8:0]   = X do ponto base
	instruction[17:9]  = Y do ponto base  
	instruction[21:18] = Fator multiplicativo da base e altura do polígono.
	instruction[30:22] = Cor
	instruction[31]    = Forma 
*/
/* =============================== BARRAMENTOS e sinais ===================================== */
wire [31:0] data;	// Barramento de saída da memória de instrução.
wire [3:0] address; // Barramento de endereço da memória de instrução.
// ==========================================================
// Barramentos e sinais de saída da unidade de controle.
wire 		wr_memory_fg;				
wire 		memory_fg_selector;				
wire 		wr_register;			
wire 		registers_reset;	
wire 		reset_counter;

wire [3:0] 	register_w_address;  
wire [1:0] 	register_r_address;
wire [3:0] 	memory_read_address; 
// Barramento de dados de saída dos bancos de registradores.
wire [32:0] rb_data1;
wire [32:0] rb_data2;
wire [32:0] rb_data3;
wire [32:0] rb_data4;
wire [32:0] rb_data5;
// Barramentos de saída do núcleos do pipeline.
wire [3:0] out_reg1;
wire [8:0] out_color1;
wire 	   out_bubble1;

wire [3:0] out_reg2;
wire [8:0] out_color2;
wire 	   out_bubble2;

wire [3:0] out_reg3;
wire [8:0] out_color3;
wire 	   out_bubble3;

wire [3:0] out_reg4;
wire [8:0] out_color4;
wire 	   out_bubble4;

wire [3:0] out_reg5;
wire [8:0] out_color5;
wire 	   out_bubble5;
// Barramento de saída do comparador.
wire [8:0] polygon_color;
wire 	   out_wr;
// ===========================================================
/*==================================================================================================================*/
/*==================================== Unidade de Controle ==========================================================*/
controls_pipeline controls_pipeline_inst (
	.clk(clk),
	.reset(reset),
	.printtingScreen(printtingScreen),
	.counter_x(counter_x),						// Contador para coordenada x.
	.vga_x(vga_x),								// coordenada x do monitor VGA.
	.vga_y(vga_y),								// coordenada y do monitor VGA.
	.wr_memory_fg(wr_memory_fg),				// sinal de escrita/leitura da memória de instrução.
	.memory_fg_selector(memory_fg_selector),	// sinal de seleção do endereço da memória de instrução.
	.wr_register(wr_register),					// Sinal de escrita/leitura dos bancos de registradores.
	.registers_reset(registers_reset),			// Sinal de reset dos bancos de registradores.
	.reset_counter_x(reset_counter),
	.register_w_address(register_w_address),     // Barramento de escrita dos bancos de registradores.
	.register_r_address(register_r_address),     // Barramento de leitura dos bancos de registradores.
	.memory_read_address(memory_read_address)    // Barramento de endereço para leitura na memória de instrução.
);


/*==================================================================================================================*/
/*==================================================================================================================*/
/*multiplexador #(.data_bits1(4), .data_bits2(4), .out_bits_size(4)) 
multiplexador_memory_fg_inst (
	.selector(memory_fg_selector),        
	.data(in_address), 					// endereço de escrita     
	.data2(memory_read_address),    	// endereço de leitura
 	.out(address)       
);*/
/*==================================================================================================================*/
/*======================================== Memória de instrução ====================================================*/

always @(posedge clk) begin
	if(enable_written) begin //escrita
		w_memory <= 1'b1;
	end
	else if(reset_done == 1'b1 || enable_written == 1'b0) begin
		w_memory <= 1'b0;
	end
	else w_memory <= 1'b0;
end
/*------------------------------------------------------------------------------------------------------*/
memory_fg	memory_fg_inst (
	.clock(clk),
	.data(instruction),
	.rdaddress(memory_read_address),
	.wraddress(in_address),
	.wren(enable_written),
	.q(data)
);
/*memory_fg memory_fg_inst (
	.clock(clk),
	.address(address),
	.data(instruction),
	.wren(enable_written),
	.q(data)
);*/
/*==================================================================================================================*/
/*==================================================================================================================*/

/*==================================================================================================================*/
/*======================= Bancos de Registradores para entrada dos núcleos do pipeline =============================*/
register_file #(.add_reg0(4'd0), .add_reg1(4'd1), .add_reg2(4'd2)) 
register_file_inst_1 (
	.clk(clk),
	.reset(registers_reset),
	.wr(wr_register),
	.address_write(register_w_address),
	.address_read(register_r_address),
	.data(data),
	.out_data(rb_data1)
);

register_file #(.add_reg0(4'd3), .add_reg1(4'd4), .add_reg2(4'd5))
register_file_inst_2 (
	.clk(clk),
	.reset(registers_reset),
	.wr(wr_register),
	.address_write(register_w_address),
	.address_read(register_r_address),
	.data(data),
	.out_data(rb_data2)
);

register_file #(.add_reg0(4'd6), .add_reg1(4'd7), .add_reg2(4'd8))
register_file_inst_3 (
	.clk(clk),
	.reset(registers_reset),
	.wr(wr_register),
	.address_write(register_w_address),
	.address_read(register_r_address),
	.data(data),
	.out_data(rb_data3)
);

register_file #(.add_reg0(4'd9), .add_reg1(4'd10), .add_reg2(4'd11))
register_file_inst_4 (
	.clk(clk),
	.reset(registers_reset),
	.wr(wr_register),
	.address_write(register_w_address),
	.address_read(register_r_address),
	.data(data),
	.out_data(rb_data4)
);

register_file #(.add_reg0(4'd12), .add_reg1(4'd13), .add_reg2(4'd14))
register_file_inst_5 (
	.clk(clk),
	.reset(registers_reset),
	.wr(wr_register),
	.address_write(register_w_address),
	.address_read(register_r_address),
	.data(data),
	.out_data(rb_data5)
);
/*==================================================================================================================*/
/*==================================================================================================================*/
/*==================================================================================================================*/
/*========================= Gerenciadores de Coordenada x e Y para o Pipeline ======================================*/
reg [9:0] counter_x = 10'd0;
reg [9:0] counter_y = 10'd0;
always @(posedge clk or negedge reset_counter) begin
	if(!reset_counter) begin
		counter_x <= 10'd0;
	end
	else if(register_r_address == 2'b00) begin
		counter_x <= counter_x;
	end
	else if(register_r_address == 2'b11) begin
		counter_x <= counter_x + 10'd1;
	end
	else begin
		counter_x <= counter_x;
	end
end

always @(posedge clk) begin
	if(!reset_counter) begin
		if(vga_y == 10'd523) begin
			// última linha da área inativa. Inicia processamento da primeira linha da próxima tela.
			counter_y <= 10'd0;
		end
		else begin
			counter_y <= vga_y + 10'd1;
		end		
	end
	else begin
		counter_y <= counter_y;
	end
end


/*==================================================================================================================*/
/*===================================== Núcleos do processador (Pipeline)===========================================*/
pipeline_geometricForms core_pipeline_1 (
	.clk(clk),								// input  clk_sig
	.reset(reset),							// input  reset_sig
	.in_bubble(rb_data1[32]) ,				// input  in_bubble_sig
	.pixel_x(counter_x) ,					// input [9:0] pixel_x_sig
	.pixel_y(counter_y) ,					// input [9:0] pixel_y_sig
	.ref_point_x(rb_data1[8:0]) ,			// input [8:0] ref_point_x_sig
	.ref_point_y(rb_data1[17:9]) ,			// input [8:0] ref_point_y_sig
	.in_color(rb_data1[30:22]) ,			// input [8:0] in_color_sig
	.mult(rb_data1[21:18]) ,				// input [3:0] mult_sig
	.form(rb_data1[31]) ,					// input  form_sig
	.out_reg(out_reg1) ,					// output [3:0] out_reg_sig
	.out_color(out_color1) ,				// output [8:0] out_color_sig
	.out_bubble(out_bubble1) 				// output  out_bubble_sig
);

pipeline_geometricForms core_pipeline_2 (
	.clk(clk),								// input  clk_sig
	.reset(reset),							// input  reset_sig
	.in_bubble(rb_data2[32]) ,				// input  in_bubble_sig
	.pixel_x(counter_x) ,					// input [9:0] pixel_x_sig
	.pixel_y(counter_y) ,					// input [9:0] pixel_y_sig
	.ref_point_x(rb_data2[8:0]) ,			// input [8:0] ref_point_x_sig
	.ref_point_y(rb_data2[17:9]) ,			// input [8:0] ref_point_y_sig
	.in_color(rb_data2[30:22]) ,			// input [8:0] in_color_sig
	.mult(rb_data2[21:18]) ,				// input [3:0] mult_sig
	.form(rb_data2[31]) ,					// input  form_sig
	.out_reg(out_reg2) ,					// output [3:0] out_reg_sig
	.out_color(out_color2) ,				// output [8:0] out_color_sig
	.out_bubble(out_bubble2) 				// output  out_bubble_sig
);

pipeline_geometricForms core_pipeline_3 (
	.clk(clk),								// input  clk_sig
	.reset(reset),							// input  reset_sig
	.in_bubble(rb_data3[32]) ,				// input  in_bubble_sig
	.pixel_x(counter_x) ,					// input [9:0] pixel_x_sig
	.pixel_y(counter_y) ,					// input [9:0] pixel_y_sig
	.ref_point_x(rb_data3[8:0]) ,			// input [8:0] ref_point_x_sig
	.ref_point_y(rb_data3[17:9]) ,			// input [8:0] ref_point_y_sig
	.in_color(rb_data3[30:22]) ,			// input [8:0] in_color_sig
	.mult(rb_data3[21:18]) ,				// input [3:0] mult_sig
	.form(rb_data3[31]) ,					// input  form_sig
	.out_reg(out_reg3) ,					// output [3:0] out_reg_sig
	.out_color(out_color3) ,				// output [8:0] out_color_sig
	.out_bubble(out_bubble3) 				// output  out_bubble_sig
);

pipeline_geometricForms core_pipeline_4 (
	.clk(clk),								// input  clk_sig
	.reset(reset),							// input  reset_sig
	.in_bubble(rb_data4[32]) ,				// input  in_bubble_sig
	.pixel_x(counter_x) ,					// input [9:0] pixel_x_sig
	.pixel_y(counter_y) ,					// input [9:0] pixel_y_sig
	.ref_point_x(rb_data4[8:0]) ,			// input [8:0] ref_point_x_sig
	.ref_point_y(rb_data4[17:9]) ,			// input [8:0] ref_point_y_sig
	.in_color(rb_data4[30:22]) ,			// input [8:0] in_color_sig
	.mult(rb_data4[21:18]) ,				// input [3:0] mult_sig
	.form(rb_data4[31]) ,					// input  form_sig
	.out_reg(out_reg4) ,					// output [3:0] out_reg_sig
	.out_color(out_color4) ,				// output [8:0] out_color_sig
	.out_bubble(out_bubble4) 				// output  out_bubble_sig
);

pipeline_geometricForms core_pipeline_5 (
	.clk(clk),								// input  clk_sig
	.reset(reset),							// input  reset_sig
	.in_bubble(rb_data5[32]) ,				// input  in_bubble_sig
	.pixel_x(counter_x) ,					// input [9:0] pixel_x_sig
	.pixel_y(counter_y) ,					// input [9:0] pixel_y_sig
	.ref_point_x(rb_data5[8:0]) ,			// input [8:0] ref_point_x_sig
	.ref_point_y(rb_data5[17:9]) ,			// input [8:0] ref_point_y_sig
	.in_color(rb_data5[30:22]) ,			// input [8:0] in_color_sig
	.mult(rb_data5[21:18]) ,				// input [3:0] mult_sig
	.form(rb_data5[31]) ,					// input  form_sig
	.out_reg(out_reg5) ,					// output [3:0] out_reg_sig
	.out_color(out_color5) ,				// output [8:0] out_color_sig
	.out_bubble(out_bubble5) 				// output  out_bubble_sig
);


/*==================================================================================================================*/
/*==================================================================================================================*/
/*==================================================================================================================*/
/*============================================= Comparador ==========================================================*/
wire bubble_wr;
assign bubble_wr = (out_bubble1 & out_bubble2 & out_bubble3 & out_bubble4 & out_bubble5);

color_comparator color_comparator_inst (
	.clk(clk),
	.reset(reset),
	.in_reg1(out_reg1),
	.in_reg2(out_reg2),
	.in_reg3(out_reg3),
	.in_reg4(out_reg4),
	.in_reg5(out_reg5),
	.in_c1(out_color1),
	.in_c2(out_color2),
	.in_c3(out_color3),
	.in_c4(out_color4),
	.in_c5(out_color5),
	.in_bubble_c(bubble_wr),
	.out_wr(out_wr),
	.out_polygon_color(polygon_color)
);
/*==================================================================================================================*/
/*==================================================================================================================*/
reg [9:0] pixels_memory_address;

always @(posedge clk or negedge reset_counter) begin
	if (!reset_counter) begin
		pixels_memory_address <= 10'd0;
	end
	else if(out_wr) begin
		pixels_memory_address <= pixels_memory_address + 10'd1;
	end
	else begin
		pixels_memory_address <= pixels_memory_address;
	end
end

pixels_memory pixels_memory_inst (
	.data(polygon_color),				// Dados para escrita
	.rdaddress(vga_x), 					// Barramento de endereço para leitura
	.rdclock(clk_25),					// Clock de leitura
	.rden(active_area),					// Sinal de habilitar leitura (1 = Habilitado; 0 = Desabilitado)
	.wraddress(pixels_memory_address), 	// Barramento de endereço para escrita
	.wrclock(clk),  					// Clock de escrita
	.wren(out_wr), 					    // Sinal de habilitar escrita (1 = Habilitado; 0 = Desabilitado)
	.q(geo_color) 						// Saída de dados
);

endmodule