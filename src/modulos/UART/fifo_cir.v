module fifo_cir #(
    parameter B = 8,
              W = 4,
              ALMOST_FULL = 14,
              ALMOST_EMPTY = 3
) (
    input clk, rst_n,
    input wr, rd,
    input [B-1:0] wr_data,
    output empty, full, almost_empty, almost_full,
    output [B-1:0] rd_data
);
    localparam [1:0]
        READ   = 2'b01,
        WRITE   = 2'b10,
        READ_WRITE = 2'b11;

    reg [B-1:0] array_reg [2**W-1:0];
    reg [W-1:0] wr_ptr, wr_ptr_next, wr_ptr_succ;
    reg [W-1:0] rd_ptr, rd_ptr_next, rd_ptr_succ;
    reg [W:0] num_elem, num_elem_next;
    reg full_reg, empty_reg, full_reg_next, empty_reg_next;

    wire wr_en;
	 initial begin
	  wr_ptr <= 0;
      rd_ptr <= 0;
      full_reg <= 0;
      empty_reg <= 1;
      num_elem <= 0;
	 end

    always @(posedge clk) begin
        if (wr_en)
            array_reg[wr_ptr] <= wr_data;
    end

    assign rd_data = array_reg[rd_ptr];
    assign wr_en = wr & ~full_reg;
    assign almost_empty = ((num_elem <= ALMOST_EMPTY) && !empty_reg);
    assign almost_full = ((num_elem >= ALMOST_FULL) && !full_reg);

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            full_reg <= 0;
            empty_reg <= 1;
            num_elem <= 0;
        end else begin
            wr_ptr <= wr_ptr_next;
            rd_ptr <= rd_ptr_next;
            full_reg <= full_reg_next;
            empty_reg <= empty_reg_next;
            num_elem <= num_elem_next;
        end
    end

    always @* begin
        wr_ptr_succ = wr_ptr + 1;
        rd_ptr_succ = rd_ptr + 1;

        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        full_reg_next = full_reg;
        empty_reg_next = empty_reg;
        num_elem_next = num_elem; 

        case ({wr, rd})
            READ: begin
                if (!empty_reg) begin
                    rd_ptr_next = rd_ptr_succ;
                    full_reg_next = 0;
                    num_elem_next = num_elem - 1;
                    if (rd_ptr_succ == wr_ptr) 
                        empty_reg_next = 1;
                end
            end
            WRITE: begin
                if (!full_reg) begin
                    wr_ptr_next = wr_ptr_succ;
                    empty_reg_next = 0;
                    num_elem_next = num_elem + 1;
                    if (wr_ptr_succ == rd_ptr)
                        full_reg_next = 1;
                end
            end
            READ_WRITE: begin
                wr_ptr_next = wr_ptr_succ;
                rd_ptr_next = rd_ptr_succ;
                num_elem_next = num_elem;
            end
            default: begin
                wr_ptr_next = wr_ptr;
                rd_ptr_next = rd_ptr;
                full_reg_next = full_reg;
                empty_reg_next = empty_reg;
                num_elem_next = num_elem; 
            end
        endcase
    end

    assign empty = empty_reg;   
    assign full = full_reg;

endmodule