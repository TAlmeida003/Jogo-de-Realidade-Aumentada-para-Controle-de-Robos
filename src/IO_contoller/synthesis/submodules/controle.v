module controle #(
    DATA_WIDTH = 32
) (
    input  wire                  clk, rst_n, we, 
	 input  wire [1:0]            register_addr,
    input  wire [DATA_WIDTH-1:0] wr_data,

    output wire [DATA_WIDTH-1:0] out_control,
	 output wire [DATA_WIDTH-1:0] out_interrupt,
    output wire                  done
);
    
    reg [DATA_WIDTH-1:0] reg_control [1:0];
	 reg [1:0] done_aux;
	 
    initial begin
	     reg_control[0] = 32'b0;
        reg_control[1] = 32'b0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_control[0] <= 32'd0;
            done_aux[0] <= 1'b0;
        end else if (we & register_addr == 2'b01) begin
            reg_control[0] <= wr_data;
            done_aux[0] <= 1'b1;
        end else begin
            done_aux[0] <= 1'b0;
            reg_control[0] <= reg_control[0];
        end
    end
	 
	 always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_control[1] <= 32'd0;
            done_aux[1] <= 1'b0;
        end else if (we & register_addr == 2'b10) begin
				reg_control[1] <= wr_data;
            done_aux[1] <= 1'b1;
        end else begin
            done_aux[1] <= 1'b0;
            reg_control[1] <= reg_control[1];
        end
    end
	
	 assign done = done_aux[1] | done_aux[0]; 
    assign out_control = reg_control[0];
	 assign out_interrupt = reg_control[1];
    
endmodule