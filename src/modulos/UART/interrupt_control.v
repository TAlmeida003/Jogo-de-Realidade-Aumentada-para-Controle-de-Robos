module interrupt_control #( 
    parameter DATA_REG_BITS = 32
) (
    input clk, rst_n,
    input [1:0] address,
    input [DATA_REG_BITS-1:0] wr_data,
    input [DATA_REG_BITS-1:0] reg_mask_interruption,
    input [7:0] external_reg_data,
    input wr,
    output [DATA_REG_BITS-1:0] rd_interruption_status,
    output irq
);
    
    reg [7:0] reg_interruption_status;
    integer i;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_interruption_status <= 8'b0;
        end else begin
            for (i = 0; i < 8; i = i + 1) begin
                if ((wr && (address == 2'b11) && wr_data[i]) || !reg_mask_interruption[i]) begin
                    reg_interruption_status[i] <= 1'b0;
                end else if (external_reg_data[i] && reg_mask_interruption[i]) begin
                    reg_interruption_status[i] <= 1'b1;
                end
            end
        end
    end

    assign rd_interruption_status = {24'b0, reg_interruption_status};
    assign irq = |reg_interruption_status;

endmodule
