/**
*Descriçao:
*  Modulo responsavel por realizar a uma divisao por N no pulso de clock.
*Inputs:
*  clk: pulso de clock
*  reset: sinal de reset do reiniciar a divisao.
*Outputs:
*  out_clk: pulso de clock dividido de acordo ao parametro configurado. 
*Parametros:
	N: define metade do valor do divisor. Porque a contagem e feita a cada 
*borda de subida do pulso de clock. Se deseja-se dividir o clock por 4, logo N precisa ser 2.
*	WITDH: define a quantidade de registros necessarios para realizar a divisao.
*/
module frequency_divisor #(parameter WIDTH = 3, parameter N = 2) (
	input  wire clk,
	input  wire reset,
	output wire out_clk 
);

reg new_clock = 0;
reg [WIDTH-1:0]  counter = 0;
wire [WIDTH-1:0] counter_next;

always @ (posedge clk or posedge reset) begin
	if(counter_next == N) begin
		counter <= 0;
		new_clock <= ~new_clock;
	end
	else counter <= counter_next;
end

assign counter_next = counter + 1;
assign out_clk = new_clock;

endmodule