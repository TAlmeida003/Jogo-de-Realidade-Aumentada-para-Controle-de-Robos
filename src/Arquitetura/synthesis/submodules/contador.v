module contador #(parameter MAX_VALUE = 10000)(
	input  wire        clk,
	input  wire 	   reset,
	input  wire [9:0]  pixel_y,
	input  wire [9:0]  pixel_x,
	output reg [31:0]  code
);


always @(posedge clk or negedge reset) begin
	if(!reset) begin
		code <= 31'd0;
	end
	else begin
		if(pixel_x == 10'd0 && pixel_y == 10'd0) begin
			if(code == MAX_VALUE) begin
				code <= 31'd0;
			end
			else begin
				code <= code + 31'd1;
			end
		end
		else begin
			code <= code;
		end
	end
end

endmodule