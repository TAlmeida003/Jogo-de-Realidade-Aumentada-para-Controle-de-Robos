module controle_R0 (
    input clk,
    input rst,
    input [31:0] register_0,
    input [31:0] register_button,
    output reg we_system
);

    reg state, next_state;
	 
    localparam IDLE = 1'b0,
               WRITE = 1'b1;

    initial begin
        state <= IDLE;
        next_state <= IDLE;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @ (*) begin
        if (state == IDLE) begin
            we_system <= 1'b0;
            if (register_0 != register_button) begin
                next_state <= WRITE;
            end else begin
                next_state <= IDLE;
            end
        end else begin
            we_system <= 1'b1;
            next_state <= IDLE;
        end
    end
    
endmodule