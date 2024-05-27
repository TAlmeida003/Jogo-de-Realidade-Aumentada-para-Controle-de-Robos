#ifndef _GRAPHIC_PROCESSOR_H
#define _GRAPHIC_PROCESSOR_H

#define MASX_TO_SHIFT_X 0b00011111111110000000000000000000
#define MASX_TO_SHIFT_Y 0b00000000000001111111111000000000

/*---- Constantes que definem a direcao de um sprite.*/
#define LEFT   		 0
#define UPPER_RIGHT  1
#define UP 			 2
#define UPPER_LEFT   3
#define RIGHT  		 4
#define BOTTOM_LEFT  5
#define DOWN         6
#define BOTTOM_RIGHT 7

/*-------Definicao dos dados referentes aos sprites moveis-------------------------------------------------------------------------*/
typedef struct{
	int coord_x;          //coordenada x atual do sprite na tela.
	int coord_y;          //coordenada y atual do sprite na tela.
	int direction;        //variavel que define o angulo de movimento do sprite.
	int offset;           //variavel que define o offset de memoria do sprite. Usada para escolher qual animacao usar.
	int data_register;    //variavel que define em qual registrador os dados referente ao sprite serao armazenados.
	int step_x; 		  //Numero de passos que o sprite se movimenta no eixo X.
	int step_y; 		  //Numero de passos que o sprite se movimenta no eixo Y.
	int ativo;
	int collision;        // 0 - sem colisao , 1 - sprite colidiu
} Sprite;

/*-------Definicao dos dados referentes aos sprites fixos-------------------------------------------------------------------------*/
typedef struct{
	int coord_x;          //coordenada x atual do sprite na tela.
	int coord_y;          //coordenada y atual do sprite na tela.
	int offset;           //variavel que define o offset de memoria do sprite. Usada para escolher qual animacao usar.
	int data_register;    //variavel que define em qual registrador os dados referente ao sprite serao armazenados.
	int ativo;
} Sprite_Fixed;

/* ================================================================================
Descricao: Funcao usada para posicionar um sprite.
Parametros:
	- registrador: define o registrador usado para armazenar os dados do sprite no processador grafico.
	- x:		   define a coordenada x do sprite.
	- y:		   define a coordenada y do sprite.
	- offset:	   define o offset de memória para acesso ao bitmap do sprite.
	- activation_bit: usado para ativar/desativar um sprite.
Retorno:
	- 0 (Falha)
	- 1 (Sucesso)
===================================================================================*/
int set_sprite(int registrador, int x, int y, int offset, int activation_bit);

/* ================================================================================
Descricao: Funcao usada configurar a cor de fundo da tela.
Parametros:
	- R, G, B: componentes de cores RGB. Valores na faixa de 0 a 7.
Retorno:
	- 0 (Falha)
	- 1 (Sucesso)
===================================================================================*/
int set_background_color(int R, int G, int B);

/* ================================================================================
Descricao: Funcao usada incrementar/decrementar as posicoes de um sprite de acordo ao seu angulo de movimento.
Parametros:
	- *sp: passagem por referencia da struct que armazena os dados do sprite.
	- mirror: habilita(1)/desabilita(0) o espelhamento da coordenada do sprite caso exceda os limites de tela.
===================================================================================*/
void increase_coordinate(Sprite *sp, int mirror);

/* ================================================================================
Descricao: Funcao usada para verificar se existe uma colisao entre dois sprites quaisquer.
Parametros:
	- *sp1 e *sp2: passagem por referencia da struct que armazena os dados dos sprites.
Retorno:
	- 0: sem colisao
	- 1: colisao detectada
===================================================================================*/
int collision(Sprite *sp1, Sprite *sp2);

/* ================================================================================
Description: Function used to set color of a background block.
Parameters:
	- column: number of column
	- line: number of line
	- R, G, B: RGB components of the color.
Return:
	- 0: instruction didn't send
	- 1: instruction sent
===================================================================================*/
int set_background_block(int column, int line, int R, int G, int B);

#endif	/* _GRAPHIC_PROCESSOR_H */