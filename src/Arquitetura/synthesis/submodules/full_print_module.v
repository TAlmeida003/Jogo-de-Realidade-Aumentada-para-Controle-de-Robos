module full_print_module #(parameter size_x1 = 10, size_y1 = 10, size_address1 = 14, bits_x_y_1 = 20, size_line1 = 20) 
(
	input wire                clk,
	input wire                clk_pixel,
	input wire                reset,
	input wire  [31:0]        data_reg,
	input wire                active_area,
	input wire  [size_x1-1:0] pixel_x,
	input wire  [size_y1-1:0] pixel_y,


	output wire						 printting,
	output reg  [size_address1-1:0]  memory_address,
	output wire [bits_x_y_1-1:0]     check_value
);

wire [4:0]               current_state;
wire                     sprite_on;
wire                     count_finished;
wire [31:0]              sprite_datas;
wire [size_address1-1:0] memory_address1;
wire [size_address1-1:0] memory_address2;
wire [size_address1-1:0] out_module;

printModule #(.size_x(size_x1),.size_y(size_y1),.size_address(size_address1),.bits_x_y(bits_x_y_1))
printModule_inst
(
	.clk(clk) ,									// input  		      		 clk_sig
	.clk_pixel(clk_pixel) ,						// input  		      		 clk_pixel_sig
	.reset(reset) ,								// input  			  	     reset_sig
	.data_reg(data_reg) ,						// input  [31:0]       		 data_reg_sig
	.active_area(active_area) ,					// input   			  		 active_area_sig
	.pixel_x(pixel_x) ,							// input  [size_x-1:0] 		 pixel_x_sig
	.pixel_y(pixel_y) ,							// input  [size_y-1:0]       pixel_y_sig
	.count_finished(count_finished) ,			// input  			  	     count_finished_sig
	.sprite_datas(sprite_datas) ,				// output [31:0]      		 sprite_datas_sig
	.memory_address(memory_address1) ,			// output [size_address-1:0] memory_address_sig
	.printting(printting),
	.check_value(check_value) ,					// output [bits_x_y-1:0] 	 check_value_sig
	.sprite_on(sprite_on) 						// output  				     sprite_on_sig
);

calculoAddress #(.size_x(10), .size_y(10), .size_address(14) )
calculoAddress_inst
(
	.clk_pixel(clk_pixel) ,	               // input  clk_pixel_sig
	.pixel_x(pixel_x) , 	               // input [size_x-1:0] pixel_x_sig
	.pixel_y(pixel_y) ,	                   // input [size_y-1:0] pixel_y_sig
	.sprite_datas(sprite_datas) ,	       // input [31:0] sprite_datas_sig
	.sprite_on(sprite_on) ,	               // input  sprite_on_sig
	.counter_finished(count_finished),      // input counter_finished_sig
	.memory_address(memory_address2) 	   // output [size_address-1:0] memory_address_sig
);



multiplexador #(.data_bits1(size_address1), .data_bits2(size_address1), .out_bits_size(size_address1))
multiplexador_inst
(
	.selector(sprite_on) ,	        // input  selector_sig
	.data(memory_address1) ,	    // input [data_bits1-1:0] data_sig
	.data2(memory_address2) ,	    // input [data_bits2-1:0] data2_sig
	.out(out_module) 	            // output [out_bits_size-1:0] out_sig
);

always @(negedge clk_pixel) begin
	memory_address  <= out_module;
end
endmodule

