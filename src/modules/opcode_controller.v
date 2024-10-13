module opcode_controller #(
    parameter WIDTH = 64;
    parameter ARCHITECTURE = 32
) (
    input  wire [WIDTH-1:0] in_reg_data,
    input  wire [3:0] 		 opcode,
    output reg  [WIDTH-1:0] out_reg_data,
    output reg 				 we,
    output reg  [1:0] 		 addr
);

    localparam RDEC =  4'b0100,
               RCTL =  4'b0101,
               RMIRQ = 4'b0110,
               WDEC =  4'b0111,
               WCTL =  4'b1000,
               WMIRQ = 4'b1001;

    always @(*) begin
        if (ARCHITECTURE == 32) begin
            if (opcode == RDEC ) begin // RDEC
                we <= 1'b0;
                addr <= 2'b00;
                out_reg_data <= 64'h0;
            end else if (opcode == RCTL) begin // RCTL
                we <= 1'b0;
                addr <= 2'b01;
                out_reg_data <= 64'h0;
            end else if (opcode == RMIRQ) begin // RMIRQ
                we <= 1'b0;
                addr <= 2'b10;
                out_reg_data <= 64'h0;
            end else if (opcode == WDEC) begin // WDEC
                we <= 1'b1;
                addr <= 2'b00;
                out_reg_data <= {32'h0, in_reg_data[63:32]};
            end else if (opcode == WCTL) begin // WCTL
                we <= 1'b1;
                addr <= 2'b01;
                out_reg_data <= {18'h0, in_reg_data[WIDTH-1:32], in_reg_data[17:4]};
            end else if (opcode == WMIRQ) begin // WMIRQ
                we <= 1'b1;
                addr <= 2'b10;
                out_reg_data <= {20'h0, in_reg_data[WIDTH-1:32], in_reg_data[15:4]};
            end else begin
                we <= 1'b0;
                addr <= 2'b11;
                out_reg_data <= 64'h0;
            end
        end else if (ARCHITECTURE == 64) begin
            if (opcode == RDEC) begin // RDEC
                we <= 1'b0;
                addr <= 2'b00;
            end else if (opcode == RCTL) begin // RCTL
                we <= 1'b0;
                addr <= 2'b01;
            end else if (opcode == RMIRQ) begin // RMIRQ
                we <= 1'b0;
                addr <= 2'b10;
            end else if (opcode == WDEC) begin // WDEC
                we <= 1'b1;
                addr <= 2'b00;
            end else if (opcode == WCTL) begin // WCTL
                we <= 1'b1;
                addr <= 2'b01;
            end else if (opcode == WMIRQ) begin // WMIRQ
                we <= 1'b1;
                addr <= 2'b10;
            end else begin
                we <= 1'b0;
                addr <= 2'b11;
            end
            out_reg_data <= in_reg_data[63:4];
        end
    end
endmodule