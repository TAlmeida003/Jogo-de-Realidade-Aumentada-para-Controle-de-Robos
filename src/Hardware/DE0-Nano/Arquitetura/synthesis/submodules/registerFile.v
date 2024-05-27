/**
//////////////////////////////////////////////////////////////////////////
    AUTOR: Gabriel Sa Barreto Alves
DESCRICAO: banco de registradores responsavel por armazenar as informaçoes de coordenadas e offset
dos sprites que estao na tela.
--------------------------------------------------------------------------
ENTRADAS: 
       n_reg: numero do registrador a ser escrito.
       check: valor para comparaçao entre valores armazenados.
        data: dado a ser escrito no registrador desejado. 
     written: sinal de escrita/leitura.
  selectFied: seleciona qual intervalo de bits na entrada "data" sera capturado.
SAIDAS:		 
  readData:   valor lido de um registrador.
      done:   informa se uma operacao de atualizaçao foi realizada com sucesso.
//////////////////////////////////////////////////////////////////////////
**/
module registerFile(
	input  wire        clk,
	input  wire        reset,
	input  wire [4:0]  n_reg, 
	input  wire [31:0] data,
	input  wire        written,
	

	output wire [31:0] r0,
	output wire [31:0] r1,
	output wire [31:0] r2,
	output wire [31:0] r3,
	output wire [31:0] r4,
	output wire [31:0] r5,
	output wire [31:0] r6,
	output wire [31:0] r7,
	output wire [31:0] r8,
	output wire [31:0] r9,
	output wire [31:0] r10,
	output wire [31:0] r11,
	output wire [31:0] r12,
	output wire [31:0] r13,
	output wire [31:0] r14,
	output wire [31:0] r15,
	output wire [31:0] r16,
	output wire [31:0] r17,
	output wire [31:0] r18,
	output wire [31:0] r19,
	output wire [31:0] r20,
	output wire [31:0] r21,
	output wire [31:0] r22,
	output wire [31:0] r23,
	output wire [31:0] r24,
	output wire [31:0] r25,
	output wire [31:0] r26,
	output wire [31:0] r27,
	output wire [31:0] r28,
	output wire [31:0] r29,
	output wire [31:0] r30,
	output wire [31:0] r31,
    output  wire       out_success
);

/*---Parametros que definem as posições de inicio e fim dos atributos de cada sprite em cada registrador---*/
//localparam  n_sprite_inicio = 0; 
//localparam 	n_sprite_final  = 8;

//localparam  y_inicio = 9;
//localparam  y_final  = 18;

//localparam  x_inicio = 19;
//localparam  x_final  = 28;
//localparam  used     = 29;
//localparam spriteLine = 20;

/*----------------------------------------------------------------------------------------------------------*/

/*-------------------Registradores----------------------*/	
reg        success;
reg [31:0] reg0;
reg [31:0] reg1;
reg [31:0] reg2;
reg [31:0] reg3;
reg [31:0] reg4;
reg [31:0] reg5;
reg [31:0] reg6;
reg [31:0] reg7;
reg [31:0] reg8;
reg [31:0] reg9;
reg [31:0] reg10;
reg [31:0] reg11;
reg [31:0] reg12;
reg [31:0] reg13;
reg [31:0] reg14;
reg [31:0] reg15;
reg [31:0] reg16;
reg [31:0] reg17;
reg [31:0] reg18;
reg [31:0] reg19;
reg [31:0] reg20;
reg [31:0] reg21;
reg [31:0] reg22;
reg [31:0] reg23;
reg [31:0] reg24;
reg [31:0] reg25;
reg [31:0] reg26;
reg [31:0] reg27;
reg [31:0] reg28;
reg [31:0] reg29;
reg [31:0] reg30;
reg [31:0] reg31;
////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////

assign r0 = reg0;
assign r1 = reg1;
assign r2 = reg2;
assign r3 = reg3;
assign r4 = reg4;
assign r5 = reg5;
assign r6 = reg6;
assign r7 = reg7;
assign r8 = reg8;
assign r9 = reg9;
assign r10 = reg10;
assign r11 = reg11;
assign r12 = reg12;
assign r13 = reg13;
assign r14 = reg14;
assign r15 = reg15;
assign r16 = reg16;
assign r17 = reg17;
assign r18 = reg18;
assign r19 = reg19;
assign r20 = reg20;
assign r21 = reg21;
assign r22 = reg22;
assign r23 = reg23;
assign r24 = reg24;
assign r25 = reg25;
assign r26 = reg26;
assign r27 = reg27;
assign r28 = reg28;
assign r29 = reg29;
assign r30 = reg30;
assign r31 = reg31;
assign out_success = success;


/*Bloco always responsavel por realizar as operaçoes de escrita e leitura
no banco de registradores na descida do pulso de clock.
*/
always @(negedge clk or negedge reset) begin
	if(!reset) begin
		//Reset de todos os registradores
		 reg0 <= 32'b00000000000000000000000000000000;
		 reg1 <= 32'b00000000000000000000000000000000;
		 reg2 <= 32'b00000000000000000000000000000000;
		 reg3 <= 32'b00000000000000000000000000000000;
		 reg4 <= 32'b00000000000000000000000000000000;
		 reg5 <= 32'b00000000000000000000000000000000;
		 reg6 <= 32'b00000000000000000000000000000000;
		 reg7 <= 32'b00000000000000000000000000000000;
		 reg8 <= 32'b00000000000000000000000000000000;
		 reg9 <= 32'b00000000000000000000000000000000;
		reg10 <= 32'b00000000000000000000000000000000;
		reg11 <= 32'b00000000000000000000000000000000;
		reg12 <= 32'b00000000000000000000000000000000;
		reg13 <= 32'b00000000000000000000000000000000;
		reg14 <= 32'b00000000000000000000000000000000;
		reg15 <= 32'b00000000000000000000000000000000;
		reg16 <= 32'b00000000000000000000000000000000;
		reg17 <= 32'b00000000000000000000000000000000;
		reg18 <= 32'b00000000000000000000000000000000;
		reg19 <= 32'b00000000000000000000000000000000;
		reg20 <= 32'b00000000000000000000000000000000;
		reg21 <= 32'b00000000000000000000000000000000;
		reg22 <= 32'b00000000000000000000000000000000;
		reg23 <= 32'b00000000000000000000000000000000;
		reg24 <= 32'b00000000000000000000000000000000;
		reg25 <= 32'b00000000000000000000000000000000;
		reg26 <= 32'b00000000000000000000000000000000;
		reg27 <= 32'b00000000000000000000000000000000;
		reg28 <= 32'b00000000000000000000000000000000;
		reg29 <= 32'b00000000000000000000000000000000;
		reg30 <= 32'b00000000000000000000000000000000;
		reg31 <= 32'b00000000000000000000000000000000;
	end
	else if(written) begin //realiza uma atualizaçao no banco
		case(n_reg) 
			5'd0:
				begin
					reg0 <= data;
					success <= 1;
				end
			5'd1:
				begin
					reg1 <= data;
					success <= 1;
				end
			5'd2:
				begin
					reg2 <= data;
					success <= 1;
				end
			5'd3:
				begin
					reg3 <= data;
					success <= 1;
				end
			5'd4:
				begin
					reg4 <= data;
					success <= 1;
				end
			5'd5:
				begin
					reg5 <= data;
					success <= 1;
				end
			5'd6:
				begin
					reg6 <= data;
					success <= 1;
				end
			5'd7:
				begin
					reg7 <= data;
					success <= 1;
				end
			5'd8:
				begin
					reg8 <= data;
					success <= 1;
				end
			5'd9:
				begin
					reg9 <= data;
					success <= 1;
				end
			5'd10:
				begin
					reg10 <= data;
					success <= 1;
				end
			5'd11:
				begin
					reg11 <= data;
					success <= 1;
				end
			5'd12:
				begin
					reg12 <= data;
					success <= 1;
				end
			5'd13:
				begin
					reg13 <= data;
					success <= 1;
				end
			5'd14:
				begin
					reg14 <= data;
					success <= 1;
				end
			5'd15:
				begin
					reg15 <= data;
					success <= 1;
				end
			5'd16:
				begin
					reg16 <= data;
					success <= 1;
				end
			5'd17:
				begin
					reg17 <= data;
					success <= 1;
				end
			5'd18:
				begin
					reg18 <= data;
					success <= 1;
				end
			5'd19:
				begin
					reg19 <= data;
					success <= 1;
				end
			5'd20:
				begin
					reg20 <= data;
					success <= 1;
				end

			5'd21:
				begin
					reg21 <= data;
					success <= 1;
				end

			5'd22:
				begin
					reg22 <= data;
					success <= 1;
				end
			5'd23:
				begin
					reg23 <= data;
					success <= 1;
				end
			5'd24:
				begin
					reg24 <= data;
					success <= 1;
				end
			5'd25:
				begin
					reg25 <= data;
					success <= 1;
				end
			5'd26:
				begin
					reg26 <= data;
					success <= 1;
				end
			5'd27:
				begin
					reg27 <= data;
					success <= 1;
				end
			5'd28:
				begin
					reg28 <= data;
					success <= 1;
				end
			5'd29:
				begin
					reg29 <= data;
					success <= 1;
				end
			5'd30:
				begin
					reg30 <= data;
					success <= 1;
				end
			5'd31:
				begin
					reg31 <= data;
					success <= 1;
				end
			default:	
				success <= 0;
		endcase
	end
	else success <= 0;
end

endmodule