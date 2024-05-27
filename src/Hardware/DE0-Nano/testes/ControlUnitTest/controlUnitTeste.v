module controleUnitTeste;

integer dataLine;  //número total de linhas a serem lidas do arquivo de entrada.

reg [6:0]  inputDatas [0:13];

//Entradas
reg clk;
reg reset;
reg [3:0] opCode;
reg printtingScreen;
reg done;
reg rdempty;
//////////////////////////////

//Saídas
wire new_instruction;
wire memory_wr;
wire register_wr;
wire selectorDemuxRegister;
wire selectorDemuxData;
wire selectorAddress;
wire rdreg;
//////////////////

always begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
end

initial 
	begin
		//Inicializando os registros de entrada.
		opCode 			= 4'bxxxx;
		done   			= 1'bx;
		printtingScreen = 1'bx;
		dataLine 		= 0;
		///////////////////////////////////////////
		//leitura dos dados de entrada
		$readmemb("/home/gabriel/Documents/ConsoleFPGA/testes/ControlUnitTest/inputs_test2/newInputData.mem", inputDatas);

		#10; //delay de 20 milisegundos
		reset = 0; //reseta a máquina de estados da unidade de controle.
		#10; //delay de 20 milisegundos
		reset = 1;

		for(dataLine = 0; dataLine < 14; dataLine = dataLine + 1) begin
			{opCode,done,printtingScreen,rdempty} <= inputDatas[dataLine];
			@(negedge clk); //espera a borda de descida do pulso de clock onde as saídas são geradas
			///////////////////////////////////////////////////////////////
			//$display("Entrada %d", dataLine);
			//$monitor("Saida do sistema: %b%b%b%b%b%b%b" , new_instruction,memory_wr,selectField,register_wr,selectorDemuxRegister,selectorDemuxData,selectorAddress);
			@(posedge clk); //espera a borda de subida do clock para a geração de novas entradas na unidade de controle
			//$display("//////////////////////////////////");
		end
		$stop; //encerra a simulação
	end

controlUnit 
controlUnit_inst
(
	.clk(clk),							            // input  clk_sig
	.reset(reset),						            // input  reset_sig
	.opCode(opCode) ,					            // input [3:0] opCode_sig
	.printtingScreen(printtingScreen) ,		        // input  printtingScreen_sig
	.doneInst(done),	                            // input  doneInst_sig
	.fifo_empty(rdempty),                       
	.new_instruction(new_instruction) ,				// output  new_instruction_sig
	.memory_wr(memory_wr) ,							// output  memory_wr_sig
	.register_wr(register_wr) ,						// output  register_wr_sig
	.selectorDemuxRegister(selectorDemuxRegister) ,	// output  selectorDemuxRegister_sig
	.selectorDemuxData(selectorDemuxData) ,			// output  selectorDemuxData_sig
	.selectorAddress(selectorAddress), 				// output  selectorAddress_sig
	.reset_done(reset_done),
	.rdreg(rdreg)
);

endmodule