module baud_rate_gen #(
    parameter N = 4,  // number of bits
              M = 10  // mod-M
) (
    input clk, rst_n,
    output max_tick,
    output [N-1:0] q
);

    reg [N-1:0] r_reg;
    wire [N-1:0] r_next;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            r_reg <= 0;
        end else begin
            r_reg <= r_next;
        end
    end

    assign r_next = (r_reg == M-1) ? 0 : r_reg + 1;

    assign q = r_reg;
    assign max_tick = (r_reg == M-1) ? 1'b1 : 1'b0;
    
endmodule