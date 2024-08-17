module register_file #(
    parameter DATA_WIDTH = 32;
    parameter NUM_REGISTERS = 2
) (
    // Inputs
    input  clk, rst_n, we, rd, register_addr_wr, register_addr_rd,
    input [DATA_WIDTH-1:0] wr_data, wr_data_system,
    // Outputs
    output reg [DATA_WIDTH-1:0] rd_data,
	 output [DATA_WIDTH-1:0] rd_data_system,
    output done

);
    
    reg [DATA_WIDTH-1:0] registers [1:0];
    reg done_aux;

    initial begin
        registers[0] = 32'd0; // data
        registers[1] = 32'd0; // flegs
        done_aux = 1'b0;
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            registers[1] <= 32'd0;
        end else if (we & (register_addr_wr  != 0)) begin
            registers[1] <= wr_data;
        end 
    end
	
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            done_aux <= 1'b0;
        end else if (we) begin
            done_aux <= 1'b1;
        end else begin
            done_aux <= 1'b0;
        end
    end
/*
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            registers[0] <= 32'd0;
        end else begin
            registers[0] <= wr_data_system;
        end
    end
*/	 
	 always @(*) begin
		if (!register_addr_rd) begin
			rd_data <= wr_data_system;
		end else begin
			rd_data <= registers[1];
		end
	 end

    assign rd_data_system = registers[1];
    assign done = done_aux;

endmodule