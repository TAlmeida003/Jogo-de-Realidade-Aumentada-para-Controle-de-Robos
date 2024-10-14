module ControlUnit_aux(
	input wire clk,
	input wire print,
	input wire end_instruction,
	input wire fifo_empty,
	input wire reset,
	output reg en_reading,
    output reg en_refresh_decode,
    output reg en_execution
);

parameter [2:0] WAIT           = 3'b000,
				ENABLE_READING = 3'b001,
                READING        = 3'b010,
                REFRESH_OUT    = 3'b011,
                END_INST       = 3'b100;

reg [2:0] state = WAIT; 
reg [2:0] next;

always @(posedge clk or negedge reset) begin
	if(!reset)
		state <= WAIT;
	else 
		state <= next;
end

always @(state or print or end_instruction or fifo_empty) begin
	next = 3'bxxx;
	case(state)
		WAIT: begin // verifica se a tela está sendo impressa ou não.
			if(!print && fifo_empty == 1'b0) begin
				next = ENABLE_READING;
			end
			else if(print && (fifo_empty == 1'b1 || fifo_empty == 1'b0) )   begin
				next = WAIT; // tela está sendo impressa
			end
			else begin
				next = WAIT;
			end
		end

		ENABLE_READING: begin   // Ativa a leitura de uma nova instrução.
			next  = READING;
		end

		READING: begin          // Realiza a leitura da instrução e faz a decodificação.
			next  = REFRESH_OUT;
		end

		REFRESH_OUT: begin      //Armazena o resultado da decodificação.
			next = END_INST;
		end
		
		END_INST: begin
			if(print == 1'b1 || end_instruction == 1'b1) begin
				next = WAIT;
			end
			else begin
				if(end_instruction == 1'b0) begin
					next = END_INST;
				end
			end
		end
		default: next = WAIT;
	endcase
end


always @(state) begin
	case(state)
		WAIT: begin
			en_reading         = 1'b0;
			en_refresh_decode  = 1'b0;
			en_execution       = 1'b0;
		end

		ENABLE_READING: begin   // Ativa a leitura de uma nova instrução.
			en_reading         = 1'b1;
			en_refresh_decode  = 1'b0;
			en_execution       = 1'b0;
		end

		READING: begin          // Realiza a leitura da instrução e faz a decodificação.
			en_reading         = 1'b0;
			en_refresh_decode  = 1'b1;
			en_execution       = 1'b0;
		end

		REFRESH_OUT: begin      //Armazena o resultado da decodificação.
			en_reading         = 1'b0;
			en_refresh_decode  = 1'b1;
			en_execution       = 1'b0; 
		end

		END_INST: begin
			en_reading         = 1'b0;
			en_refresh_decode  = 1'b0;
			en_execution       = 1'b1; //ativa a execução da nova instrução.
		end
	endcase
end

endmodule