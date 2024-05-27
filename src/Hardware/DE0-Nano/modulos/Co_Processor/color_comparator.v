module color_comparator(
	input wire clk,
	input wire reset,
	input wire [3:0] in_reg1,
	input wire [3:0] in_reg2,
	input wire [3:0] in_reg3,
	input wire [3:0] in_reg4,
	input wire [3:0] in_reg5,
	input wire [8:0] in_c1,
	input wire [8:0] in_c2,
	input wire [8:0] in_c3,
	input wire [8:0] in_c4,
	input wire [8:0] in_c5,
	input wire 		 in_bubble_c,
	output reg 		 out_wr,
	output reg [8:0] out_polygon_color
);

reg [8:0] polygon_color;

always @(in_reg1 or in_reg2 or in_reg3 or in_reg4 or in_reg5 or in_c1 or in_c2 or in_c3 or in_c4 or in_c5) begin
	if(in_reg1 == 4'b1111) begin
		polygon_color = in_c1;
	end
	else if(in_reg2 == 4'b1111) begin
		polygon_color = in_c2;
	end
	else if(in_reg3 == 4'b1111) begin
		polygon_color = in_c3;
	end
	else if(in_reg4 == 4'b1111) begin
		polygon_color = in_c4;
	end
	else if(in_reg5 == 4'b1111) begin
		polygon_color = in_c5;
	end
	else begin
		polygon_color = 9'd510; // cor invisível.
	end
end

always @(posedge clk or negedge reset) begin
	if (!reset) begin
		out_wr 			  <= 1'b0;
		out_polygon_color <= 9'd0;
	end
	else begin
		out_wr 			  <= in_bubble_c;
		out_polygon_color <= polygon_color;	
	end
end

endmodule