module uart_tx #(
    parameter DATA_BITS = 8,
              STOP_BITS_TICK = 16
) (
    input  wire                  clk, rst_n,
    input  wire                  tx_start, s_tick,
    input  wire [DATA_BITS-1:0]  tx_data,
    output reg                   tx_done,
    output wire                  tx
);

    // Estados da máquina de estados
    localparam  [1:0]
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11;
    
    reg [1:0] 				state, next_state;
    reg [3:0] 				s_reg, s_next;   // contador de ticks
    reg [2:0] 				n_reg, n_next;   // contador de bits
    reg [DATA_BITS-1:0] b_reg, b_next;   // Shift register
    reg       				tx_reg, tx_next; // Transmissão

    initial begin
        state <= IDLE;
        s_reg <= 0;
        n_reg <= 0;
        b_reg <= 0;
        tx_reg <= 1;
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
            tx_reg <= 1;
        end else begin
            state <= next_state;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
            tx_reg <= tx_next;
        end
    end

    always @* begin
        next_state = state;
        tx_done = 0;
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        tx_next = tx_reg;
        case (state)
            IDLE: begin
                tx_next = 1;
                if (tx_start) begin
                    next_state = START;
                    s_next = 0;
                    b_next = tx_data;
                end
            end
            START: begin
                tx_next = 0;
                if (s_tick) begin
                    if (s_reg == 15) begin
                        next_state = DATA;
                        s_next = 0;
                        n_next = 0;
                    end else begin
                        s_next = s_reg + 4'b1;
                    end
                end
            end
            DATA: begin
                tx_next = b_reg[0];
                if (s_tick) begin
                    if (s_reg == 15) begin
                        s_next = 0;
                        b_next = {1'b0, b_reg[DATA_BITS-1:1]};
                        if (n_reg == DATA_BITS-1) begin
                            next_state = STOP;
                        end else begin
                            n_next = n_reg + 3'b1;
                        end
                    end else begin
                        s_next = s_reg + 4'b1;
                    end
                end
            end
            STOP: begin
                tx_next = 1;
                if (s_tick) begin
                    if (s_reg == STOP_BITS_TICK-1) begin
                        next_state = IDLE;
                        tx_done = 1;
                    end else begin
                        s_next = s_reg + 4'b1;
                    end
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    assign tx = tx_reg;
    
endmodule