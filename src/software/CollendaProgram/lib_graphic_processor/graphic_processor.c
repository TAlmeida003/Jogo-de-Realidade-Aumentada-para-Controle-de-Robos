#include "graphic_processor.h"
#include "altera_avalon_pio_regs.h"

#define DATA_A_BASE 0x111d0
#define DATA_B_BASE 0x111c0
#define WRFULL_BASE 0x11190
#define WRREG_BASE 0x111a0
/* ================================================================================
Funcao usava para envio de instrucoes para o processador grafico.
===================================================================================*/
static int sendInstruction(unsigned long dataA, unsigned long dataB){
	if(IORD(WRFULL_BASE,0) == 0){                        //FIFO nao esta cheia
		IOWR_ALTERA_AVALON_PIO_DATA(WRREG_BASE,0);       //Desabilita o sinal de escrita
		IOWR_ALTERA_AVALON_PIO_DATA(DATA_A_BASE,dataA);  //Envia o dataA
		IOWR_ALTERA_AVALON_PIO_DATA(DATA_B_BASE,dataB);  //Envia o dataB
		IOWR_ALTERA_AVALON_PIO_DATA(WRREG_BASE,1);
		IOWR_ALTERA_AVALON_PIO_DATA(WRREG_BASE,0);
		return 1;
	}else{
		return 0;
	}
}

/* ================================================================================
Funcao que define o barramento dataB da instrucao de modificar os dados de um sprite.
===================================================================================*/
static unsigned long dataB_builder(int x, int y, int offset, int ativacao){
	unsigned long data = 0; 
	data = data | ativacao; //coloca o bit de ativacao do sprite.
    data = data << 10;    	//desloca o bit de ativacao em 10 posicoes a esquerda.
    data = data | x;      	//operacao OR com a variavel data. (insere x no barramento de bits)
    data = data << 10;    	//desloca os bits em 10 posicoes a esquerda.
    data = data | y;      	//operacao OR com a variavel data. (insere y no barramento de bits)
    data = data << 9;     	//desloca os bits em 9 posicoes a esquerda.
    data = data | offset; 	//insere o offset.
    return data;		
}

/* ================================================================================
Funcao que define o barramento dataA das instrucoes.
===================================================================================*/
static unsigned long dataA_builder(int opcode, int reg, int memory_address){
	unsigned long data = 0;
	switch(opcode){
		case(0):                                //instrucao de escrita no banco de registradores.
			data = data | reg;                  //operacao OR (adiciona o numero do registrador)
			data = data << 4;                   //deslocamento a esquerda em 4 posicoes.
			data = data | opcode;               //operacao OR (adiciona o opcode).
			break;
		case(1):                                //instrucao de escrita na memoria de sprites.
			data = data | memory_address;       //operacao OR (adiciona o endereco de memoria)
			data = data << 4;                   //deslocamento a esquerda em 4 posicoes.
			data = data | opcode;               //operacao OR (adiciona o opcode).
			break;
		case(2):								//instrucao de escrita na memoria de background.
			data = data | memory_address;		//operacao OR (adiciona o endereco de memoria)
			data = data << 4;					//deslocamento a esquerda em 4 posicoes.
			data = data | opcode;				//operacao OR (adiciona o opcode).
	}
	return data;
}

int set_sprite(int registrador, int x, int y, int offset, int activation_bit){
	unsigned long dataA = dataA_builder(0,registrador,0);
	unsigned long dataB = dataB_builder(x, y, offset, activation_bit);
	return sendInstruction(dataA, dataB);
}


int set_background_color(int R, int G, int B){
	unsigned long dataA = dataA_builder(0,0,0);
	unsigned long color = B;
	color = color << 3;
	color = color | G;
	color = color << 3;
	color = color | R;
	return sendInstruction(dataA, color);
}

int set_background_block(int column, int line, int R, int G, int B){
	int address = (line * 80) + column;
	unsigned long dataA = dataA_builder(2, 0, address);
	unsigned long color = B;
	color = color << 3;
	color = color | G;
	color = color << 3;
	color = color | R;
	return sendInstruction(dataA, color);
}

void increase_coordinate(Sprite *sp, int mirror){
	switch((*sp).direction){
		case LEFT:                   							//0 graus   (esquerda)
			(*sp).coord_x -= (*sp).step_x; 						//Atualiza a coordenada X.
			if(mirror == 1){
				if((*sp).coord_x < 1){                          //Realiza a troca de posicao do sprite ao chegar no limite esquerdo da tela.
					(*sp).coord_x = 640;
				}
			}else {
				if((*sp).coord_x < 1){
					(*sp).coord_x = 1;
				}
			}
			break;
		case UPPER_RIGHT:                                       //45 graus  (diagonal superior direita)
			(*sp).coord_x += (*sp).step_x; 						//Atualiza a coordenada X.
			(*sp).coord_y -= (*sp).step_y; 						//Atualiza a coordenada Y.
			if(mirror == 1){
				if((*sp).coord_y < 0){                          //Realiza a troca de posicao do sprite ao chegar no limite superior da tela.
					(*sp).coord_y = 480;
				}else if((*sp).coord_x > 640){                  //Realiza a troca de posicao do sprite ao chegar no limite direito da tela.
					(*sp).coord_x = 0;	
				}
			}else{
				if((*sp).coord_y < 0){
					(*sp).coord_y = 0;
				}else if((*sp).coord_x > 640){
					(*sp).coord_x = 640;
				}
			}
			break;
		case UP:                                                //90 graus  (pra cima)
			(*sp).coord_y -= (*sp).step_y; 						//Atualiza a coordenada Y.
			if(mirror == 1){
				if((*sp).coord_y < 0){                          //Realiza a troca de posicao do sprite ao chegar no limite superior da tela.
					(*sp).coord_y = 480;
				}
			}else{
				if((*sp).coord_y < 0){
					(*sp).coord_y = 0;
				}			
			}
			break;
		case UPPER_LEFT:          							    //135 graus (diagonal superior esquerda)
			(*sp).coord_x -= (*sp).step_x; 						//Atualiza a coordenada X.
			(*sp).coord_y -= (*sp).step_y; 						//Atualiza a coordenada Y.
			if(mirror == 1){
				if((*sp).coord_y < 0){                          //Realiza a troca de posicao do sprite ao chegar no limite superior da tela.
					(*sp).coord_y = 480;
				}else if((*sp).coord_x < 1){                    //Realiza a troca de posicao do sprite ao chegar no limite esquerdo da tela.
					(*sp).coord_x = 640;
				}
			}else{
				if((*sp).coord_y < 0){
					(*sp).coord_y = 0;
				}else if((*sp).coord_x < 1){
					(*sp).coord_x = 1;
				}
			}
			break;
		case RIGHT:          									//180 graus (direita)
			(*sp).coord_x += (*sp).step_x; 						//Atualiza a coordenada X.
			if(mirror == 1){
				if((*sp).coord_x > 640){                        //Realiza a troca de posicao do sprite ao chegar no limite direito da tela.
					(*sp).coord_x = 0;
				}
			}else{
				if((*sp).coord_x > 620){
					(*sp).coord_x = 620;
				}
			}
			break;
		case BOTTOM_LEFT:          								//225 graus (diagonal inferior esquerda)
			(*sp).coord_x -= (*sp).step_x; 						//Atualiza a coordenada X.
			(*sp).coord_y += (*sp).step_y; 						//Atualiza a coordenada Y.
			if(mirror == 1){
				if((*sp).coord_y > 480){                        //Realiza a troca de posicao do sprite ao chegar no limite inferior da tela.
					(*sp).coord_y = 0;
				}else if((*sp).coord_x < 1){                    //Realiza a troca de posicao do sprite ao chegar no limite esquerdo da tela.
					(*sp).coord_x = 640;
				}
			}else{
				if((*sp).coord_y > 480){
					(*sp).coord_y = 480;
				}else if((*sp).coord_x < 1){
					(*sp).coord_x = 1;
				}
			}
			break;
		case DOWN:                                              //270 graus (pra baixo)
			(*sp).coord_y += (*sp).step_y; 						//Atualiza a coordenada Y.
			if(mirror == 1){
				if((*sp).coord_y > 480){                        //Realiza a troca de posicao do sprite ao chegar no limite inferior da tela.
					(*sp).coord_y = 0;
				}
			}else{
				if((*sp).coord_y > 480){
					(*sp).coord_y = 480;
				}
			}
			break;
		case BOTTOM_RIGHT:                                      //315 graus (diagonal inferior direita)
			(*sp).coord_x += (*sp).step_x; 						//Atualiza a coordenada X.
			(*sp).coord_y += (*sp).step_y; 						//Atualiza a coordenada Y.
			if(mirror == 1){
				if((*sp).coord_y > 480){                        //Realiza a troca de posicao do sprite ao chegar no limite inferior da tela.
					(*sp).coord_y = 0;
				}else if((*sp).coord_x > 640){                  //Realiza a troca de posicao do sprite ao chegar no limite direito da tela.
					(*sp).coord_x = 0;
				}
			}else{
				if((*sp).coord_y > 480){
					(*sp).coord_y = 480;
				}else if((*sp).coord_x > 640){
					(*sp).coord_x = 640;
				}
			}
			break;
	}
}


int collision(Sprite *sp1, Sprite *sp2){
	int h = 15;
	int y_face_1 = (*sp1).coord_y + h;
	int y_face_2 = (*sp2).coord_y + h;
	int x_face_1 = (*sp1).coord_x + h;
	int x_face_2 = (*sp2).coord_x + h;
	/*-------------------------------------*/   
	if( (y_face_1 > (*sp2).coord_y ) && ((*sp1).coord_y < y_face_2) ){
		//Colisoes a esquerda --------------------------------------------
		if( ( x_face_1 > (*sp2).coord_x ) && (x_face_1 < x_face_2) ){
			return 1;
		}else if ( (x_face_1 < x_face_2) && (x_face_1 > (*sp2).coord_x) ){
			return 1;
		}
		/*--------------------------------------------------------------*/
		//Colisoes a direita --------------------------------------------
		if( ( x_face_1 > x_face_2) && (x_face_2 > (*sp1).coord_x) ){
			return 1;
		}else if( ( x_face_1 > x_face_2) && (x_face_2 > (*sp1).coord_x) ){
			return 1;
		}
		/*--------------------------------------------------------------*/
	}
	return 0;
}
