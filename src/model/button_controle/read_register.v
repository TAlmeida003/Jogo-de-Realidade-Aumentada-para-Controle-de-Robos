module read_register (
    input  wire        clk,
    input  wire        rd,
    input  wire [31:0] register_0,
    input  wire [31:0] register_1,
    input  wire [31:0] register_2,
    input  wire [31:0] register_3,
    input  wire [1:0]  rd_addr,
    output wire [31:0] rd_data,
    output reg         done
);

	reg [31:0] rd_data_aux = 32'd0;
	
	assign rd_data = rd_data_aux;
	
    always @(posedge clk) begin
		if (rd) begin
            case (rd_addr)
                2'b00: begin 
                    rd_data_aux <= register_0;
                    done <= 1'b1;
                end
                2'b01: begin 
                    rd_data_aux <= register_1;
                    done <= 1'b1;
                end
                2'b10: begin
                    rd_data_aux <= register_2;
                    done <= 1'b1;
                end
                2'b11: begin
                    rd_data_aux <= register_3;
                    done <= 1'b1;
                end
                default: begin
                    rd_data_aux <= 32'd0;
                    done <= 1'b0;
                end
            endcase
		end else begin
			done <= 1'b0;
		end
    end
    
endmodule