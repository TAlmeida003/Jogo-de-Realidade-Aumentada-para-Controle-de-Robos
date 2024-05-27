module register_file #(parameter [3:0] add_reg0 = 4'd0, add_reg1 = 4'd1, add_reg2 = 4'd2) (
	input wire 			clk,
	input wire 			reset,
	input wire 			wr,
	input wire [3:0] 	address_write,
	input wire [1:0] 	address_read,
	input wire [31:0] 	data,
	output reg [32:0] out_data
);

/*-------------------Registradores----------------------*/	
reg [32:0] reg0;
reg [32:0] reg1;
reg [32:0] reg2;
reg [32:0] reg3; // Registrador para bolha do pipeline
/*------------------------------------------------------*/	


always @(posedge clk or negedge reset) begin
	if(!reset) begin
		 // Reset de todos os registradores
		 reg0 	  <= 33'b000000000000000000000000000000000;
		 reg1 	  <= 33'b000000000000000000000000000000000;
		 reg2 	  <= 33'b000000000000000000000000000000000;
		 out_data <= 33'b000000000000000000000000000000000;
	end
	else if(wr) begin // Realiza operação de escrita
		case(address_write) 
			add_reg0:
				begin
					reg0 <= {1'b0,data};
				end
			add_reg1:
				begin
					reg1 <= {1'b0,data};
				end
			add_reg2:
				begin
					reg2 <= {1'b1,data};
				end
			default: begin
				reg0 <= reg0;
				reg1 <= reg1;
				reg2 <= reg2;
			end
		endcase
	end
	else if(!wr) begin // Realia operação de leitura
		case(address_read) 
			2'b00:
				begin
					out_data <= reg0;
				end
			2'b01:
				begin
					out_data <= reg1;
				end
			2'b10:
				begin
					out_data <= reg2;
				end
			2'b11:
				begin
					out_data <= 33'b000000000000000000000000000000000;
				end
		endcase	
	end
end


endmodule