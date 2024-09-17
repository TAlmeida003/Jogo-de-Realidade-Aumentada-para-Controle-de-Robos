module controle #(
    DATA_WIDTH = 32
) (
    input wire                  clk, rst_n, we, register_addr,
    input wire [DATA_WIDTH-1:0] wr_data,

    output wire [DATA_WIDTH-1:0] out_data,
    output reg done
);
    
    reg [DATA_WIDTH-1:0] reg_control;

    initial begin
        reg_control = 32'b0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_control <= 32'd0;
            done <= 1'b0;
        end else if (we & (register_addr  != 0)) begin
            reg_control <= wr_data;
            done <= 1'b1;
        end else begin
            done <= 1'b0;
            reg_control <= reg_control;
        end
    end

    assign out_data = reg_control;
    
endmodule