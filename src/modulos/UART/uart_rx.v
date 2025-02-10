module uart_rx #(
    parameter DATA_BITS = 8,
              STOP_BITS_TICK = 16
) (
    input 						clk, rst_n,
    input 						rx, s_tick,
    output reg                  rx_done, rx_error,
    output      [DATA_BITS-1:0] rx_data
);

    localparam [2:0]
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] s_reg, s_next; // contador de ticks
    reg [2:0] n_reg, n_next; // contador de bits
    reg [DATA_BITS-1:0] b_reg, b_next; // Shift register
	 reg data_serial_buffer = 1'b1;
    reg rx_in = 1'b1;

    initial begin
        state <= IDLE;
        s_reg <= 0;
        n_reg <= 0;
        b_reg <= 0;
    end
    
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
				data_serial_buffer <= 1'b1;
				rx_in <= 1'b1;
        end else begin
            state <= next_state;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
				data_serial_buffer <= rx;
				rx_in <= data_serial_buffer;
        end
    end

    always @* begin
        next_state = state;
        rx_done = 0;
        rx_error = 0;
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;

        case (state)
            IDLE: begin
                if (rx_in == 0) begin
                    next_state = START;
                    s_next = 0;
                end
            end
            START: begin
                if (s_tick) begin
                    if (s_reg == 7) begin
                        if (rx_in == 0) begin
                            next_state = DATA;
                            s_next = 0;
                            n_next = 0;
                        end else begin
                            next_state = ERROR;
                        end
                    end else begin
                        s_next = s_reg + 4'b1;
                    end
                end    
            end
            DATA: begin
                if (s_tick) begin
                    if (s_reg == 15) begin
                        s_next = 0;
                        b_next = {rx_in, b_reg[DATA_BITS-1:1]};
                        if (n_reg == DATA_BITS - 1) begin
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
                if (s_tick) begin
                    if (s_reg == STOP_BITS_TICK-1) begin
                        if (rx_in == 1) begin
                            next_state = IDLE;
                            rx_done = 1;
                        end else begin
                            next_state = ERROR;
                        end
                    end else begin
                        s_next = s_reg + 4'b1;
                    end
                end
            end
            ERROR: begin
                rx_error = 1;
				s_next = 0;
				n_next = 0;
				b_next = 0;
                if (rx_in == 1) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
					 
            end
        endcase
    end

    assign rx_data = b_reg;
endmodule