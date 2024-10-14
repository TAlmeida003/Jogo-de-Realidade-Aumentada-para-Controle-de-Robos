module stateMachine_1(
	input wire clk,
	input wire reset,
	input wire is_pixel,
	output reg refresh_comp,
	output reg refresh_select
);

parameter [2:0] RESET  = 3'b000, 
				A1     = 3'b001,
				B1     = 3'b010,
				C1     = 3'b011,
				D1     = 3'b100,
				WAIT   = 3'b101;

reg [2:0] state, next;
reg [1:0] counter;

always @(posedge clk or negedge reset) begin
	if (!reset) begin
		state <= RESET;
	end
	else
		state <= next;
end

always @(state or is_pixel or counter) begin
	next    = 3'bxxx;
	case(state)
		RESET: begin
			next = A1;
		end
		A1: begin     // Comparação e Verifica se o próximo pixel a ser gerado é válido
			if(is_pixel == 1'b1) begin
		    	next = B1;
		    end
		    else begin
		    	next = WAIT;
		    end
		end
		B1: begin    
			next = C1;
		end

		C1: begin    
			next = D1;
		end

		D1: begin    
		    next = A1;
		end

		WAIT: begin
			if(counter == 2'd3) begin
				next = A1;
			end
			else begin
				next = WAIT;
			end
		end

		default: next = RESET;
	endcase
end

always @(negedge clk) begin
	case(state)
		A1: begin
			counter <= 2'd0;
		end

		WAIT: begin
			counter <= counter + 2'd1;
		end

		default counter <= 2'd0;
	endcase
end


always @(state) begin
	case(state)
		RESET: begin
			refresh_comp   = 1'b0;
			refresh_select = 1'b0;
		end
		A1: begin //faz comparação.
			refresh_comp   = 1'b1;
			refresh_select = 1'b0;
		end
		B1: begin  //armazena o resultado da comparação.
			refresh_comp   = 1'b0;
			refresh_select = 1'b0;
		end

		C1: begin  // faz a seleção dos dados.
			refresh_comp   = 1'b0;
			refresh_select = 1'b1;
		end

		D1: begin //armazena resultado da seleção.
			refresh_comp   = 1'b0;
			refresh_select = 1'b0;
		end

		WAIT: begin
			refresh_comp   = 1'b0;
			refresh_select = 1'b0;
		end
	endcase
end

endmodule