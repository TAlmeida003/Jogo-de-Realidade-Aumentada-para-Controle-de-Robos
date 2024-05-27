module pulseCounter #(parameter MAX_VALUE = 10000, n_bits = 19)(
	input  wire        clk,
	input  wire         reset,
	output reg         screen
);

reg        [n_bits-1:0]        code = 0;
localparam [n_bits-1:0]   add_value = 1;
localparam [n_bits-1:0] reset_value = 0;

always @(posedge clk) begin
	if(screen) begin
		if(reset) begin
			screen <= 1'd0;
		end
		else begin
			screen <= 1'd1;
		end
	end
	else begin
		if(code == MAX_VALUE) begin
			code   <= reset_value;
			screen <= 1'd1;
		end
		else begin
			screen <= 1'd0;
			code   <= code + add_value;
		end
	end
end

endmodule