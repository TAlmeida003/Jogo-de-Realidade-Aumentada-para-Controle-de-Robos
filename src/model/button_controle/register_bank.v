module regiter_bank (
    input  wire        clk,
    input  wire        we,
    input  wire        we_system,
    input  wire [1:0]  wr_addr,
    input  wire [31:0] wr_data,
    input  wire [31:0] wr_data_system,
    output wire [31:0] rd_reg0,
    output wire [31:0] rd_reg1,
    output wire [31:0] rd_reg2,
    output wire [31:0] rd_reg3,
    output wire         done
);

    reg [31:0] registers [3:0]; // 3 registradores de 32 bits
    reg aux_done = 0;

    initial begin
        registers[0] = 32'b00000000_00000000_00000000_00000000;
        registers[1] = 32'b01010101_01010101_01010101_01010110;
        registers[2] = 32'b00000000_00000000_00000000_00001010;
        registers[3] = 32'b00000000_00000000_00000000_00000000;
    end

    assign rd_reg0 = registers[0];
    assign rd_reg1 = registers[1];
    assign rd_reg2 = registers[2];
    assign rd_reg3 = registers[3];
    
    assign done = aux_done;

    always @(posedge clk) begin
        if (we) begin
            case (wr_addr)
					 2'b00: begin 
                    aux_done <= 1;
                end
                2'b01: begin 
                    registers[1] <= wr_data;
                    aux_done <= 1;
                end
                2'b10: begin
                    registers[2] <= wr_data;
                    aux_done <= 1;
                end
                2'b11: begin
                     registers[3] <= wr_data;
                     aux_done <= 1;
                end
                default: aux_done <= 1;
            endcase
        end else begin	
            aux_done <= 0;
        end 
    end

    always @(posedge clk) begin
        if (we_system) begin
            registers[0] <= wr_data_system;
        end
    end
    
endmodule