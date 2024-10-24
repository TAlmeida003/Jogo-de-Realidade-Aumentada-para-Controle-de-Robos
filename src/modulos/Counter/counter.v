module counter #(parameter n_bits = 19)(
	input  wire        clk,
	input  wire        reset,
	output reg  [n_bits-1:0]  value
);

localparam [n_bits-1:0]   add_value = 1;
localparam [n_bits-1:0] reset_value = 0;

always @(posedge clk) begin
	if(!reset) begin
		value <= reset_value;
	end
	else begin
		value   <= value + add_value;
	end
end

endmodule