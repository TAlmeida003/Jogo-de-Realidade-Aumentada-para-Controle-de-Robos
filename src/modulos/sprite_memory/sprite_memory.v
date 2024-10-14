/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: Módulo responsável por armazenar os bits de cor dos sprites e informar se uma leitura foi realizada.
//////////////////////////////////////////////////////////////////////////
**/
module sprite_memory(
	input	wire [13:0] address,
	input	wire        clock,
	input   wire        reset_done,
	input	wire [8:0]  data,
	input	wire  	    wren,
	
	output	reg [8:0]   out_data,
	output  wire        read_memory
);


reg r_memory;
wire [8:0] colors;

/*--------Sempre que sentir uma mudança na saída da memória é porque uma leitura foi realizada---------*/
always @(posedge clock) begin
	out_data <= colors;

	if(wren) begin //escrita
		r_memory <= 1'b1;
	end
	else if(reset_done == 1'b1 || wren == 1'b0) begin
		r_memory <= 1'b0;
	end
	else r_memory <= 1'b0;
end
/*------------------------------------------------------------------------------------------------------*/

assign read_memory = r_memory;

memory memory_inst
(
	.address(address) ,	// input [13:0] address_sig
	.clock(clock) ,		// input  clock_sig
	.data(data) ,		// input [8:0] data_sig
	.wren(wren) ,		// input  wren_sig
	.q(colors) 		    // output [8:0] q_sig
);


endmodule