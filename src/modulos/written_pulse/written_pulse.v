module written_pulse(
	input wire clk,
	input wire reset,
	input wire start,
   output wire pulse
);

reg Qr = 1'b0;
reg Qu = 1'b0;

wire in_Q;
wire enable;

assign in_Q   = start & (~Qr) & (~Qu);
assign pulse  = Qr;
assign enable = (~start) | (~Qu) | Qr;

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		Qr <= 1'b0;	
	end
	else if(enable) begin
		Qr <= in_Q;
	end
	else begin
		Qr <= Qr;
	end
end

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		Qu <= 1'b0;	
	end
	else if(enable) begin
		Qu <= Qr;
	end
	else begin
		Qu <= Qu;
	end
end

endmodule