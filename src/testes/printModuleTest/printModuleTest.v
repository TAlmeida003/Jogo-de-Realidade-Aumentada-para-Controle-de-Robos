module printModuleTest;

integer dataLine;  //número total de linhas a serem lidas do arquivo de entrada.

reg [52:0]  inputDatas [0:7];  //oito entradas de 53 bits.

//--------------entradas-----------------
reg clk;
reg clk_pixel;
reg reset;
reg [31:0] data_reg;
reg active_area;
reg [9:0] pixel_x;
reg [8:0] pixel_y;
reg count_finished;
/////////////////////////////////////////

//--------------saídas-------------------
wire        printtingScreen;
wire [18:0] check_value;
wire [31:0] sprite_datas;
wire [16:0] memory_address;
wire        sprite_on;
/////////////////////////////////////////

always begin //frequência de funcionamento do módulo de impressão (100 MHz)
	clk = 1'b1;
	#5;
	clk = 1'b0;
	#5;
end

always begin //frequência de geração dos pixeis (25 MHz)
	clk_pixel = 1'b1;
	#20;
	clk_pixel = 1'b0;
	#20;
end

initial begin

		//leitura dos dados de entrada
		$readmemb("/home/gabriel/Documents/ConsoleFPGA/testes/printModuleTest/inputDatas.mem", inputDatas);

        dataLine = 0;
        ////////////////////////////////////////////
		reset = 0;              //reseta a máquina de estados da unidade de controle.
		#40;                    //delay de 40 milisegundos
		reset = 1;

		for(dataLine = 0; dataLine <= 6; dataLine = dataLine + 1) begin
			{count_finished,data_reg,active_area,pixel_y,pixel_x} <= inputDatas[dataLine];
			@(negedge clk); //espera a borda de descida do pulso de clock onde as saídas são geradas.
			$monitor("saidas: address_memory: %d | printtingScreen: %d | pixel_y: %d | pixel_x: %d | sprite_on: %d | sprite_datas: %b",
										memory_address,
										printtingScreen,  
										check_value[8:0],
										check_value[17:9], 
										sprite_on, 
										sprite_datas);
			@(posedge clk); //espera a borda de subida do clock para a geração de novas entradas.
		end
		#10;                            //espera de 10 milisegundos para alinha a contagem junto com o clk_pixel.
		for(dataLine = 0; dataLine < 20; dataLine = dataLine + 1) begin  //contagem da linha do sprite sendo impressa.
			$monitor("saidas: address_memory: %d | printtingScreen: %d | pixel_y: %d | pixel_x: %d | sprite_on: %d | sprite_datas: %b",
										memory_address,
										printtingScreen,  
										check_value[8:0],
										check_value[17:9], 
										sprite_on, 
										sprite_datas);
			@(posedge clk_pixel); //espera a borda de subida do clk_pixel para a geração de novas entradas.
		end

		{count_finished,data_reg,active_area,pixel_y,pixel_x} <= inputDatas[7];               //última entrada.
		@(negedge clk);	 //espera a borda de descida do pulso de clock onde as saídas são geradas.
		$monitor("saidas: address_memory: %d | printtingScreen: %d | pixel_y: %d | pixel_x: %d | sprite_on: %d | sprite_datas: %b",
										memory_address,
										printtingScreen,  
										check_value[8:0],
										check_value[17:9], 
										sprite_on, 
										sprite_datas);
		#35;
		$stop; //encerra a simulação
end


printModule #(.size_x(10),.size_y(9),.size_address(17),.bits_x_y(19))
printModule_inst
(
	.clk(clk) ,							// input  			  		 clk_sig
	.clk_pixel(clk_pixel) ,				// input  			  		 clk_pixel_sig
	.reset(reset) ,						// input  			  		 reset_sig
	.data_reg(data_reg) ,				// input [31:0] 	  		 data_reg_sig
	.active_area(active_area) ,			// input  			  		 active_area_sig
	.pixel_x(pixel_x) ,					// input [size_x-1:0] 	     pixel_x_sig
	.pixel_y(pixel_y) ,					// input [size_y-1:0] 		 pixel_y_sig
	.count_finished(count_finished) ,	// input  			  		 count_finished_sig
	.sprite_datas(sprite_datas) ,		// output [31:0] 	  		 sprite_datas_sig
	.memory_address(memory_address) ,	// output [size_address-1:0] memory_address_sig
	.printtingScreen(printtingScreen) ,	// output  					 printtingScreen_sig
	.check_value(check_value) ,			// output [18:0] 			 check_value_sig
	.sprite_on(sprite_on) 				// output  					 sprite_on_sig
);

endmodule