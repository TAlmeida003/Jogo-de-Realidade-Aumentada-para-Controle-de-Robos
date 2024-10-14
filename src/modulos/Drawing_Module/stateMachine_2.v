module stateMachine_2(
	input wire  clk,
	input wire  reset,
	output reg  refresh_data_out,
	output reg 	refresh_vga_out

);

parameter [2:0] RESET = 3'b000,
				B2    = 3'b001,
				C2    = 3'b010,
				D2    = 3'b011,
				E2    = 3'b100;

reg [2:0] state, next;

always @(posedge clk or negedge reset) begin
	if (!reset) begin
		state <= RESET;
	end
	else
		state <= next;
end

always @(state) begin
	next = 3'bxxx;
	case(state)
		RESET: begin
			next = B2;
		end
		B2: begin
			next = C2;
		end
		C2: begin
			next = D2;
		end
		D2: begin
			next = E2;
		end
		E2: begin
			next = B2;
		end

		default : begin
			next = RESET;
		end
	endcase
end


always @(state) begin
	case(state)
		RESET: begin
			refresh_data_out = 1'b0;
			refresh_vga_out  = 1'b0;
		end
		B2: begin 	// Calcula endereco de memoria
			refresh_data_out = 1'b1;
			refresh_vga_out  = 1'b0;
		end
		C2: begin   // Realiza leitura na memoria de sprites , armazena as flags auxiliares, registra a cor do block atual de background 
			refresh_data_out = 1'b1;
			refresh_vga_out  = 1'b0;
		end
		D2: begin
			refresh_data_out = 1'b0;
			refresh_vga_out  = 1'b1;
		end
		E2: begin
			refresh_data_out = 1'b0;
			refresh_vga_out  = 1'b0;
		end

		default : begin
			refresh_data_out = 1'b0;
			refresh_vga_out  = 1'b0;
		end 
	endcase
end

endmodule