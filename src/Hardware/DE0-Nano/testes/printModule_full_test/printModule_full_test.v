module printModule_full_test;

integer dataLine;              //número total de linhas a serem lidas do arquivo de entrada.

reg [52:0]  inputDatas [0:3];  //oito entradas de 53 bits.

//--------------entradas-----------------
reg clk;
reg clk_pixel;
reg reset;
reg [31:0] data_reg;
reg active_area;
reg [9:0] pixel_x;
reg [9:0] pixel_y;
/////////////////////////////////////////

//---------Fios de ligação entre módulos---------
wire      	sprite_on;
wire [31:0] sprite_datas;

//--------------saídas-------------------
wire        printting;
wire [19:0] check_value;
wire [13:0] memory_address;

/////////////////////////////////////////

always begin //frequência de funcionamento do módulo de impressão (100 MHz)
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
end

always begin //frequência de geração dos pixeis (25 MHz)
	clk_pixel = 1'b0;
	#20;
	clk_pixel = 1'b1;
	#20;
end

initial begin
	//leitura dos dados de entrada
	$readmemb("/home/gabriel/Documents/ConsoleFPGA/testes/printModule_full_test/inputDatas.mem", inputDatas);
	dataLine = 0;
    ////////////////////////////////////////////
	reset = 1;              
	@(posedge clk);                    
	reset = 0;
	$monitor("saidas: address_memory: %d | printtingScreen: %d", memory_address, printting);
	for(dataLine = 0; dataLine < 3; dataLine = dataLine + 1) begin
			{data_reg,active_area,pixel_y,pixel_x} <= inputDatas[dataLine];
			@(negedge clk); //espera a borda de descida do pulso de clock onde as saídas são geradas.
			@(posedge clk); //espera a borda de subida do clock para a geração de novas entradas.
	end
	
	for(dataLine = 0; dataLine < 20; dataLine = dataLine + 1) begin  //contagem da linha do sprite sendo impressa.
		@(posedge clk_pixel); //espera a borda de subida do clk_pixel para a geração de novas entradas.
		pixel_x = pixel_x + 10'd1;
	end
	
	{data_reg,active_area,pixel_y,pixel_x} <= inputDatas[3];               //última entrada.
	@(negedge clk_pixel);	 //espera a borda de descida do pulso de clock onde as saídas são geradas.
	@(negedge clk_pixel);
	@(negedge clk_pixel);
	$stop; //encerra a simulação
end

full_print_module #(.size_x1(10), .size_y1(10), .size_address1(14), .bits_x_y_1(20), .size_line1(20))
full_print_module_inst
(
	.clk(clk),								    // input  clk_sig
	.clk_pixel(clk_pixel),						// input  clk_pixel_sig
	.reset(!reset),								// input  reset_sig
	.data_reg(data_reg),						// input [31:0] data_reg_sig
	.active_area(active_area),					// input  active_area_sig
	.pixel_x(pixel_x),							// input [size_x1-1:0] pixel_x_sig
	.pixel_y(pixel_y),							// input [size_y1-1:0] pixel_y_sig
	.memory_address(memory_address),	        // output [size_address1-1:0] memory_address_sig
	.check_value(check_value), 					// output [bits_x_y_1-1:0] check_value_sig
	.printting(printting)
);

endmodule