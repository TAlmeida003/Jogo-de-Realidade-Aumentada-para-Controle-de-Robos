module wr_pulse(
	input clk,
	input in_data,
	input rst_n,
	output out_data
);

	reg wr;
	
	always @(posedge clk, negedge rst_n) begin
	
		if (!rst_n) wr <= 1'b0;
		else wr <= in_data;
	end	
	
	assign out_data = ~wr &  in_data & rst_n;

endmodule 