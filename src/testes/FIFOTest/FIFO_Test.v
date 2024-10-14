`timescale 1ns/1ns
module FIFO_Test();

integer counter;
reg [31:0] data; //bus input for written
reg rdclk;       //reading clock
reg rdreq;       //reading signal
reg wrclk;       //writting clock
reg wrreq;       //writting signal
reg reset;
wire pulse;
wire wrfull;
wire rdempty;
wire [31:0] q;
initial begin
	data  = 32'd0;
	rdreq = 1'b0;
	reset = 1'b0;
	#20;
	reset = 1'b1;
	wrreq = 1'b0;
	/*// Test written
	for(counter = 1; counter < 30; counter = counter + 1) begin
		data  = counter;
		@(posedge wrclk);
		@(negedge wrclk);
		if(wrfull) begin
			wrreq = 1'b0;
		end
		else begin
			wrreq = 1'b1;
		end
	end
	// Test Reading
	rdreq = 1'b1;
	for(counter = 0; counter < 30; counter = counter + 1) begin
		@(negedge rdclk);
		if(rdempty) begin
			rdreq = 1'b0;
		end
		else begin
			rdreq = 1'b1;
		end
	end*/
	for(counter = 1; counter < 30; counter = counter + 1) begin
		data  = counter;
		@(posedge wrclk);
		@(negedge wrclk);
		if(wrfull == 1'b0) begin
			wrreq = 1'b1;
			#80;
			wrreq = 1'b0;
			#40;
		end
		else begin
			wrreq = 1'b0;
		end
	end
	for(counter = 0; counter < 30; counter = counter + 1) begin
		@(negedge rdclk);
		if(rdempty) begin
			rdreq = 1'b0;
		end
		else begin
			rdreq = 1'b1;
		end
	end
	$stop;
end



written_pulse written_pulse_inst(
	.clk(wrclk),
	.reset(reset),
	.start(wrreq),
   .pulse(pulse)
);


FIFO FIFO_inst(
	.data(data),
	.rdclk(rdclk),
	.rdreq(rdreq),
	.wrclk(wrclk),
	.wrreq(pulse),
	.q(q),
	.rdempty(rdempty),
	.wrfull(wrfull)
);

always begin //written frequency (50 MHz)
	rdclk = 1'b0;
	#10;
	rdclk = 1'b1;
	#10;
end

always begin //written frequency (50 MHz)
	wrclk = 1'b0;
	#10;
	wrclk = 1'b1;
	#10;
end
endmodule