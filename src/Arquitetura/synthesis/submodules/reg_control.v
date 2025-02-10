module reg_control #(
    parameter DATA_REG_BITS = 32
) (
    input clk, rst_n,
    input [1:0] address,
    input [DATA_REG_BITS-1:0] wr_data,
    input [5:0] external_reg_data,
    input wr,
    output [DATA_REG_BITS-1:0] rd_control_data,
    output [DATA_REG_BITS-1:0] rd_mask_interruption
);

    reg [4:0] reg_control_data;
    reg [7:0] reg_mask_interruption;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            reg_control_data <= 5'b0;
            reg_mask_interruption <= 8'd0;
        end else begin
            if (wr && (address == 2'b01)) begin
                reg_control_data[4:0] <= wr_data[4:0];
            end
            if (wr && (address == 2'b10)) begin
                reg_mask_interruption <= wr_data[7:0];
            end
        end
    end
    
    assign rd_control_data = {21'b0, external_reg_data, reg_control_data};
    assign rd_mask_interruption = {24'b0, reg_mask_interruption};
    
endmodule