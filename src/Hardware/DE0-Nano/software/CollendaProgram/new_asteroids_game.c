#include "stdio.h"
#include "io.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "stdlib.h"
#include "time.h"
#include <unistd.h>
#include "lib_graphic_processor/graphic_processor.h"
#define A_BASE 0x11160
#define B_BASE 0x11130
#define X_BASE 0x11110
#define Y_BASE 0x11120
#define SELECT_BUTTON_BASE 0x110f0
#define START_BASE 0x11100
#define DIRECTION_ANALOGIC_BASE 0x11170
#define TL_BASE 0x11140
#define TR_BASE 0x11150
#define DATA_A_BASE 0x111d0
#define DATA_B_BASE 0x111c0
#define RESET_PULSECOUNTER_BASE 0x111b0
#define SCREEN_BASE 0x11180
#define WRFULL_BASE 0x11190
#define WRREG_BASE 0x111a0

/* =========================================================
Configuracao do barramento de botoes:
DOWN:             move_buttons[0] = GPIO_19  = PIN_R11
UP:               move_buttons[1] = GPIO_111 = PIN_R10
LEFT:             move_buttons[2] = GPIO_113 = PIN_P9 
RIGHT:            move_buttons[3] = GPIO_115 = PIN_N11
ATIRAR:           direction_and_shoot[0] = GPIO_117 = PIN_K16
GIRAR p/ESQUERDA: direction_and_shoot[1] = GPIO_119 = PIN_L15
GIRAR p/DIREITA:  direction_and_shoot[2] = GPIO_121 = PIN_P16
============================================================ */

/* ==========================================================
OFFSET:
Asteroids: 0, 1, 2
Nave:      3, 4, 5, 6, 7, 8, 9, 10
Tiro:      11,12,13,14
Numeros:   15,16,17,18,19,20,21,22,23,24
GAME OVER: 25,26,27,28,29,30,31
============================================================ */ 

/*-------------------PROTOTIPO DAS FUNCOES-------------------------*/
/*-----------------------------------------------------------------*/

/*----------------PROCEDIMENTOS--------------------------------*/
void initialize_sprite_random(int offset, Sprite *sp);
void increase_points(Sprite_Fixed *dg_1, Sprite_Fixed *dg_2, Sprite_Fixed *dg_3);
void collision_between_tiro_and_ast(Sprite *tiro, Sprite* asteroids[], Sprite_Fixed* placar[]);
void atirar_sp(Sprite *nave, Sprite *tiro);
/*-------------------------------------------------------------*/

/*----------------VARIAVEIS GLOBAIS----------------------------*/
int number_of_asteroids = 9;
int points = 0;
int state_placar = 0;
/*-------------------------------------------------------------*/
/*---------------FUNCAO PRINCIPAL-------------------------*/
int main(){
	int refresh_coord = 0;
	int screen_for_1s = 59;
	int number_screen = 0, number_screen_2 = 0, number_screen_3 = 0, number_screen_4 = 0;
	int wait_shoot    = 0;
	int atirar        = 0;
	int check_collision = 0; //flag para controle da analise de colisao.
	srand(time(NULL));
	//========================================================================================
	//=== Variaveis para controle dos asteroids.
	Sprite ast_1, ast_2, ast_3, ast_4, ast_5, ast_6, ast_7, ast_8, ast_9;
	ast_1.ativo  = 1;
	ast_2.ativo  = 1;
	ast_3.ativo  = 1;
	ast_4.ativo  = 1;
	ast_5.ativo  = 1;
	ast_6.ativo  = 1;
	ast_7.ativo  = 1;
	ast_8.ativo  = 1;
	ast_9.ativo  = 1;
	//========================================================================================
	//=== Variaveis para controle da nave e dos tiros.
	Sprite nave;
	Sprite tiro, tiro2, tiro3, tiro4, tiro5;
	//========================================================================================
	//=== Variaveis para controle do placar.
	Sprite_Fixed placar_dg1, placar_dg2, placar_dg3;
	//========================================================================================
	//=== Inicializa as informacoes dos asteroids referentes as coordenadas x e y, angulo de movimento, offset e passos a percorrer.
	initialize_sprite_random(0,&ast_1);
	initialize_sprite_random(0,&ast_2);
	initialize_sprite_random(0,&ast_3);
	initialize_sprite_random(0,&ast_4);
	initialize_sprite_random(0,&ast_5);
	initialize_sprite_random(0,&ast_6);
	initialize_sprite_random(0,&ast_7);
	initialize_sprite_random(0,&ast_8);
	initialize_sprite_random(0,&ast_9);
	ast_1.step_x = 2;	ast_1.step_y = 2;
	ast_2.step_x = 2;	ast_2.step_y = 2;
	ast_3.step_x = 2;	ast_3.step_y = 2;
	ast_4.step_x = 2;	ast_4.step_y = 2;
	ast_5.step_x = 2;	ast_5.step_y = 2;
	ast_6.step_x = 2;	ast_6.step_y = 2;
	ast_7.step_x = 2;	ast_7.step_y = 2;
	ast_8.step_x = 2;	ast_8.step_y = 2;
	ast_9.step_x = 2;	ast_9.step_y = 2; 
	//========================================================================================
	//=== Definicao dos registradores para armazenamento das informacoes de cada sprite.
	ast_1.data_register  = 18;
	ast_2.data_register  = 1;
	ast_3.data_register  = 2;
	ast_4.data_register  = 3;
	ast_5.data_register  = 4;
	ast_6.data_register  = 5;
	ast_7.data_register  = 6;
	ast_8.data_register  = 7;
	ast_9.data_register  = 8;
	nave.data_register   = 9;
	tiro.data_register   = 10;
	tiro2.data_register  = 11;
	tiro3.data_register  = 12;
	tiro4.data_register  = 13;
	tiro5.data_register  = 14;
	placar_dg1.data_register = 15;
	placar_dg2.data_register = 16;
	placar_dg3.data_register = 17;
    //========================================================================================
	//=== Inicializa as informacoes referentes aos sprites do placar e da nave.
	placar_dg1.ativo   = 1;  placar_dg2.ativo   = 1;  placar_dg3.ativo   = 1;
	placar_dg1.coord_x = 20; placar_dg2.coord_x = 40; placar_dg3.coord_x = 60;
	placar_dg1.coord_y = 10; placar_dg2.coord_y = 10; placar_dg3.coord_y = 10;
	placar_dg1.offset  = 15; placar_dg2.offset  = 15; placar_dg3.offset  = 15;
	nave.coord_x   = 320;
	nave.coord_y   = 430;
	nave.step_x    = 5;
	nave.step_y    = 5;
	nave.offset    = 3;
	nave.direction = 2;
	nave.collision = 0;
	nave.ativo     = 1;
	//========================================================================================
	//=== Define na tela, os objetos iniciais e cor de background.
	set_sprite(placar_dg1.data_register,placar_dg1.coord_x,placar_dg1.coord_y , placar_dg1.offset, placar_dg1.ativo);
	set_sprite(placar_dg2.data_register,placar_dg2.coord_x,placar_dg2.coord_y , placar_dg2.offset, placar_dg2.ativo);
	set_sprite(placar_dg3.data_register,placar_dg3.coord_x,placar_dg3.coord_y , placar_dg3.offset, placar_dg3.ativo);
	set_sprite(nave.data_register,nave.coord_x,nave.coord_y , nave.offset, nave.ativo);
	//set_background_color(0, 0, 0);
	//=== Define os dados iniciais dos sprites de tiro.
	tiro.step_x    = 5;
	tiro.step_y    = 5;
	tiro.offset    = 11;
	tiro.ativo     = 0;

	tiro2.step_x    = 5;
	tiro2.step_y    = 5;
	tiro2.offset    = 11;
	tiro2.ativo     = 0;

	tiro3.step_x    = 5;
	tiro3.step_y    = 5;
	tiro3.offset    = 11;
	tiro3.ativo     = 0;

	tiro4.step_x    = 5;
	tiro4.step_y    = 5;
	tiro4.offset    = 11;
	tiro4.ativo     = 0;

	tiro5.step_x    = 5;
	tiro5.step_y    = 5;
	tiro5.offset    = 11;
	tiro5.ativo     = 0;
	//========================================================================================
	/*=== Variaveis para armazenamento dos estados dos botoes ================================*/
	int TR   = 0;
	int TL   = 0;
	int A    = 0;
	int move = 0;
	int start_pause = 0; //varivel utilizada para controle de Start e Pause
	int state_game  = 0; //0 - em andamento; 1 - pausado.
	/*----------------------------------------------------------------------------------------*/
	/*----------------------------LOOP PRINCIPAL-----------------------------*/
	while(nave.collision == 0){
		start_pause = IORD(START_BASE,0);
		TR    = IORD(TR_BASE,0);
		TL    = IORD(TL_BASE,0);
		A     = IORD(A_BASE,0);
		move  = IORD(DIRECTION_ANALOGIC_BASE,0);
		if(IORD(SCREEN_BASE,0) == 1){ // Verifica se uma tela terminou de ser impressa
			// Estrutura para contagem de telas e configuracao de parametros
			number_screen++;          // Contagem de telas para 
			number_screen_2++;        // Contagem de telas para 
			number_screen_3++;        // Contagem de telas para 
			number_screen_4++;        // Contagem de telas para 
			wait_shoot++;
			if(wait_shoot == screen_for_1s){
				atirar = 1; //ativa a possibilidade de atirar.
			}
			IOWR_ALTERA_AVALON_PIO_DATA(RESET_PULSECOUNTER_BASE,1);
			IOWR_ALTERA_AVALON_PIO_DATA(RESET_PULSECOUNTER_BASE,0);
		} else { // Faz a analise de colisao caso necessario. Ela e realizada toda vez que algum sprite movel e movido.
			if(check_collision == 1){ //realiza as analises de colisao.
				check_collision = 0;  //desativa a flag para uma nova analise
				Sprite* asteroids[9] = { &ast_1, &ast_2, &ast_3, &ast_4, &ast_5, &ast_6, &ast_7, &ast_8, &ast_9 };
				// verifica se existe colisao entre a nave e algum asteroid
				for(int i = 0; i < number_of_asteroids; i++) {
					Sprite *ast = asteroids[i];
					if(collision(&nave, ast) == 1){
						// houve colisao entre a nave e algum asteroid. 
						// significa GAME OVER
						nave.collision = 1;
						// sai do LOOP FOR
						break; 
					}
				}
				// verifica se existe colisao entre os tiros realizados e algum asteroid ativo.
				Sprite_Fixed* placar[3] = { &placar_dg3, &placar_dg2, &placar_dg1 };
				if(tiro.ativo  == 1 && tiro.collision   == 0){ collision_between_tiro_and_ast(&tiro,  asteroids, placar); }
				if(tiro2.ativo == 1 && tiro2.collision  == 0){ collision_between_tiro_and_ast(&tiro2, asteroids, placar); }
				if(tiro3.ativo == 1 && tiro3.collision  == 0){ collision_between_tiro_and_ast(&tiro3, asteroids, placar); }
				if(tiro4.ativo == 1 && tiro4.collision  == 0){ collision_between_tiro_and_ast(&tiro4, asteroids, placar); }
				if(tiro5.ativo == 1 && tiro5.collision  == 0){ collision_between_tiro_and_ast(&tiro5, asteroids, placar); }
			}
		}
		/*-----------------------IF de PAUSE e START------------------------------------*/
		if(state_game == 0) { 
			switch(move){
				case 0b0111:
					nave.direction = RIGHT;
					refresh_coord = 1;
					break;
				case 0b1011:
					nave.direction = LEFT;
					refresh_coord = 1;
					break;
				case 0b1101:
					nave.direction = UP;
					refresh_coord = 1;
					break;
				case 0b1110:
					nave.direction = DOWN;
					refresh_coord = 1;
					break;
				case 0b0101:
					nave.direction = UPPER_RIGHT;
					refresh_coord = 1;
					break;
				case 0b1001:
					nave.direction = UPPER_LEFT;
					refresh_coord = 1;
					break;
				case 0b1010:  
					nave.direction = BOTTOM_LEFT;
					refresh_coord = 1;
					break;
				case 0b0110:
					nave.direction = BOTTOM_RIGHT;
					refresh_coord = 1;
					break;
			}
			if(A == 1 && atirar == 1){ // Verificar a possibilidade de novos tiros.
				atirar     = 0; // Depois de atirar, espera um novo momento.
				wait_shoot = 0;
				/*----- Estrutura condicional que verifica quais tiros estao disponiveis para serem utilizados.-----*/
				if(tiro.ativo == 0 && tiro.collision == 0){        tiro.ativo  = 1; atirar_sp(&nave, &tiro);  }
				else if(tiro2.ativo == 0 && tiro2.collision == 0){ tiro2.ativo = 1; atirar_sp(&nave, &tiro2); }
				else if(tiro3.ativo == 0 && tiro3.collision == 0){ tiro3.ativo = 1; atirar_sp(&nave, &tiro3); }
				else if(tiro4.ativo == 0 && tiro4.collision == 0){ tiro4.ativo = 1; atirar_sp(&nave, &tiro4); }
				else if(tiro5.ativo == 0 && tiro5.collision == 0){ tiro5.ativo = 1; atirar_sp(&nave, &tiro5); }
				/*---------------------------------------------------------------------------------------------------*/
			}
			/*----- Estrutura condicional que verifica os botoes de direcao da nave.-----*/
			if(number_screen_2 == 6){
				number_screen_2 = 0;
				if(TR == 1){
					nave.offset += 1;       // muda o sprite de animacao da nave
					if(nave.offset > 10){
						nave.offset = 3;    // muda o sprite de animacao da nave
					}
					refresh_coord = 0;
				}else if(TL == 1){
					nave.offset -= 1;       // muda o sprite de animacao da nave
					if(nave.offset < 3){
						nave.offset = 10;   // muda o sprite de animacao da nave
					}
				}
			}else if(number_screen_2 > 6){number_screen_2 = 0;}
		}
		/*-----------------------------------------------------------------------------*/
		/*--------Estrutura que realiza a tentativa de envio de novas instrucoes para o processador grafico---------*/
		if(number_screen == 2){
			if(IORD(WRFULL_BASE,0) == 0){                           //FIFO nao esta cheia
				number_screen = 0;
				/*-----------------------IF de PAUSE e START------------------------------------*/
				if(state_game == 0) { 
					if(tiro.collision  == 1){ tiro.ativo  = 0; tiro.collision  = 0; }
					if(tiro2.collision == 1){ tiro2.ativo = 0; tiro2.collision = 0; }
					if(tiro3.collision == 1){ tiro3.ativo = 0; tiro3.collision = 0; }
					if(tiro4.collision == 1){ tiro4.ativo = 0; tiro4.collision = 0; }
					if(tiro5.collision == 1){ tiro5.ativo = 0; tiro5.collision = 0; }
					if(refresh_coord == 1){ increase_coordinate(&nave,  1); }
					increase_coordinate(&tiro,  1);
					increase_coordinate(&tiro2, 1);
					increase_coordinate(&tiro3, 1);
					increase_coordinate(&tiro4, 1);
					increase_coordinate(&tiro5, 1);
					set_sprite(nave.data_register,  nave.coord_x, nave.coord_y ,   nave.offset, nave.ativo);
					set_sprite(tiro.data_register,  tiro.coord_x, tiro.coord_y ,   tiro.offset, tiro.ativo);
					set_sprite(tiro2.data_register, tiro2.coord_x, tiro2.coord_y , tiro2.offset, tiro2.ativo);
					set_sprite(tiro3.data_register, tiro3.coord_x,tiro3.coord_y ,  tiro3.offset, tiro3.ativo);
					set_sprite(tiro4.data_register, tiro4.coord_x,tiro4.coord_y ,  tiro4.offset, tiro4.ativo);
					set_sprite(tiro5.data_register, tiro5.coord_x,tiro5.coord_y ,  tiro5.offset, tiro5.ativo);
					refresh_coord   = 0;
					check_collision = 1; // Habilita a analise de colisao
				}
			}
		}
		/*-----------------------------------------------------------------------------------------------------------*/
		/*--------Estrutura que realiza a tentativa de envio de novas instrucoes para o processador grafico---------*/
		if(number_screen_3 == 1){
			if(IORD(WRFULL_BASE,0) == 0){
				number_screen_3 = 0;
				/*-----------------------IF de PAUSE e START------------------------------------*/
				if(state_game == 0) { 
					check_collision = 1;
					increase_coordinate(&ast_1,1);
					increase_coordinate(&ast_2,1);
					increase_coordinate(&ast_3,1);
					increase_coordinate(&ast_4,1);
					increase_coordinate(&ast_5,1);
					increase_coordinate(&ast_6,1);
					set_sprite(ast_1.data_register,ast_1.coord_x,ast_1.coord_y , ast_1.offset, ast_1.ativo);
					set_sprite(ast_2.data_register,ast_2.coord_x,ast_2.coord_y , ast_2.offset, ast_2.ativo);
					set_sprite(ast_3.data_register,ast_3.coord_x,ast_3.coord_y , ast_3.offset, ast_3.ativo);
					set_sprite(ast_4.data_register,ast_4.coord_x,ast_4.coord_y , ast_4.offset, ast_4.ativo);
					set_sprite(ast_5.data_register,ast_5.coord_x,ast_5.coord_y , ast_5.offset, ast_5.ativo);
					set_sprite(ast_6.data_register,ast_6.coord_x,ast_6.coord_y , ast_6.offset, ast_6.ativo);
				}
			}
		}
		/*-----------------------------------------------------------------------------------------------------------*/
		/*--------Estrutura que realiza a tentativa de envio de novas instrucoes para o processador grafico---------*/
		if(number_screen_4 == 3){
			if(IORD(WRFULL_BASE,0) == 0){
				number_screen_4 = 0;
				/*-----------------------IF de PAUSE e START------------------------------------*/
				if(state_game == 0) { 
					increase_coordinate(&ast_7,1);
					increase_coordinate(&ast_8,1);
					increase_coordinate(&ast_9,1);
					set_sprite(placar_dg1.data_register,placar_dg1.coord_x,placar_dg1.coord_y , placar_dg1.offset, placar_dg1.ativo);
					set_sprite(placar_dg2.data_register,placar_dg2.coord_x,placar_dg2.coord_y , placar_dg2.offset, placar_dg2.ativo);
					set_sprite(placar_dg3.data_register,placar_dg3.coord_x,placar_dg3.coord_y , placar_dg3.offset, placar_dg3.ativo);
					set_sprite(ast_7.data_register,ast_7.coord_x,ast_7.coord_y , ast_7.offset, ast_7.ativo);
					set_sprite(ast_8.data_register,ast_8.coord_x,ast_8.coord_y , ast_8.offset, ast_8.ativo);
					set_sprite(ast_9.data_register,ast_9.coord_x,ast_9.coord_y , ast_9.offset, ast_9.ativo);
				}
			}
		} 
		/*-----------------------------------------------------------------------------------------------------------*/
		if(start_pause == 1 && state_game == 0){ state_game = 1;}
		else if(start_pause == 1 && state_game == 1) { state_game = 0;}
	}
	/*--------------------------FIM DO LOOP PRINCIPAL----------------------*/	
	int send = 0;
	int lot1 = 0;
	/*---------Estrutura para desativar todos os asteroids e a nave----------*/
	while(send < 2){
		if(IORD(SCREEN_BASE,0) == 1){
			IOWR_ALTERA_AVALON_PIO_DATA(RESET_PULSECOUNTER_BASE,1);
			IOWR_ALTERA_AVALON_PIO_DATA(RESET_PULSECOUNTER_BASE,0);
			send++;
		}
		if(IORD(WRFULL_BASE,0) == 0 && send == 1 && lot1 == 0){
			set_sprite(ast_1.data_register,ast_1.coord_x,ast_1.coord_y , ast_1.offset, 0);
			set_sprite(ast_2.data_register,ast_2.coord_x,ast_2.coord_y , ast_2.offset, 0);
			set_sprite(ast_3.data_register,ast_3.coord_x,ast_3.coord_y , ast_3.offset, 0);
			set_sprite(ast_4.data_register,ast_4.coord_x,ast_4.coord_y , ast_4.offset, 0);
			set_sprite(ast_5.data_register,ast_5.coord_x,ast_5.coord_y , ast_5.offset, 0);
			set_sprite(ast_6.data_register,ast_6.coord_x,ast_6.coord_y , ast_6.offset, 0);
			lot1 = 1;
		}else if(IORD(WRFULL_BASE,0) == 0 && send == 2){
			set_sprite(ast_7.data_register,ast_7.coord_x,ast_7.coord_y , ast_7.offset, 0);
			set_sprite(ast_8.data_register,ast_8.coord_x,ast_8.coord_y , ast_8.offset, 0);
			set_sprite(ast_9.data_register,ast_9.coord_x,ast_9.coord_y , ast_9.offset, 0);
			set_sprite(nave.data_register ,nave.coord_x,nave.coord_y   , nave.offset,  0);
		}
	}
	send = 0;
	lot1 = 0;
	/*---------------------------------------------------------------*/
	/*---------Estrutura para a escrita da frase "GAME OVER"---------*/
	while(send < 2){
		if(IORD(SCREEN_BASE,0) == 1){
			IOWR_ALTERA_AVALON_PIO_DATA(RESET_PULSECOUNTER_BASE,1);
			IOWR_ALTERA_AVALON_PIO_DATA(RESET_PULSECOUNTER_BASE,0);
			send++;
		}
		if(IORD(WRFULL_BASE,0) == 0 && send == 1 && lot1 == 0){
			set_sprite(1,240,240, 25, 1); //G
			set_sprite(2,260,240, 26, 1); //A
			set_sprite(3,280,240, 27, 1); //M
			set_sprite(4,300,240, 28, 1); //E
			lot1 = 1;
		}else if(IORD(WRFULL_BASE,0) == 0 && send == 2){
			set_sprite(5,340,240, 29, 1); //O
			set_sprite(6,360,240, 30, 1); //V
			set_sprite(7,380,240, 28, 1); //E
			set_sprite(8,400,240, 31, 1); //R
		}
	}
	/*---------------------------------------------------------------*/
	return 0;
}
/*----------FIM DA FUNCAO PRINCIPAL--------------------------*/

void initialize_sprite_random(int offset, Sprite *sp){
	(*sp).collision = 0;
	(*sp).coord_x   = 1 + rand() % 639;     //sorteio da posicao x.
	(*sp).coord_y   = 1 + rand() % 439;     //sorteio da posicao y.
	(*sp).offset    = offset;               //definicao do offset de memoria.
	(*sp).direction = rand() % 7;           //sorteio do anngulo inicial de movimento do sprite.
}

void collision_between_tiro_and_ast(Sprite *tiro, Sprite* asteroids[], Sprite_Fixed* placar[]){
	for (int i = 0; i < number_of_asteroids; i++){
		Sprite *ast = asteroids[i];
		if((*ast).ativo == 1){
			if(collision(tiro, ast) == 1){
				increase_points(placar[0], placar[1], placar[2]);
				(*tiro).collision = 1;
				(*ast).offset += 1;
				if((*ast).offset == 2){
					(*ast).offset    = 0;
					(*ast).coord_x   = 1 + rand() % 639;     //sorteio de uma nova posicaoo x.
					(*ast).coord_y   = 1 + rand() % 439;     //sorteio de uma nova posicaoo y.
					(*ast).direction = rand() % 7;           //sorteio de um novo angulo inicial de movimento do sprite.
				}
			}
		}
	}
}

void increase_points(Sprite_Fixed *dg_1, Sprite_Fixed *dg_2, Sprite_Fixed *dg_3){
	int incresed = 0;
	while(incresed == 0 && state_placar != 3){
		if(state_placar == 0){ // controla o primeiro digito
			if((*dg_1).offset == 24){
				(*dg_1).offset = 15; // numero 0
				state_placar    = 1;
				incresed        = 0;
			}else {
				(*dg_1).offset += 1;
				state_placar    = 0;
				incresed        = 1;
			}		
		}else if(state_placar == 1){  // controla o segundo digito
			if((*dg_2).offset == 24){
				(*dg_2).offset = 15; // numero 0
				state_placar    = 2;
				incresed        = 0;
			}else {
				(*dg_2).offset += 1;
				state_placar    = 0;
				incresed        = 1;
			}	
		}else if(state_placar == 2){ // controla o terceiro digito
			if((*dg_3).offset == 24){
				state_placar = 3; // vai para um estado inexistente. Nao conta mais. Chegou na pontuacao limite (900).
				incresed     = 1;
			}else{
				(*dg_3).offset += 1;
				state_placar    = 0;
				incresed        = 1;
			}	
		}
	}
}


void atirar_sp(Sprite *nave, Sprite *tiro){
	switch((*nave).offset){
		case 9: //esquerda
			(*tiro).coord_x   = (*nave).coord_x - 20;
			(*tiro).coord_y   = (*nave).coord_y;
			(*tiro).offset    = 13;
			(*tiro).direction = LEFT;
			break;
		case 4: //direita diagonal superior
			(*tiro).coord_x   = (*nave).coord_x + 20;
			(*tiro).coord_y   = (*nave).coord_y - 20;
			(*tiro).offset    = 12;
			(*tiro).direction = UPPER_RIGHT;
			break;
		case 3: //para cima
			(*tiro).coord_x   = (*nave).coord_x;
			(*tiro).coord_y   = (*nave).coord_y - 20;
			(*tiro).offset    = 11;
			(*tiro).direction = UP;
			break;
		case 10: //esquerda diagonal superior
			(*tiro).coord_x   = (*nave).coord_x - 20;
			(*tiro).coord_y   = (*nave).coord_y - 20;
			(*tiro).offset    = 14;
			(*tiro).direction = UPPER_LEFT;
			break;
		case 5: //direita
			(*tiro).coord_x   = (*nave).coord_x + 20;
			(*tiro).coord_y   = (*nave).coord_y;
			(*tiro).offset    = 13;
			(*tiro).direction = RIGHT;
			break;
		case 8: //esquerda diagonal inferior
			(*tiro).coord_x   = (*nave).coord_x - 20;
			(*tiro).coord_y   = (*nave).coord_y + 20;
			(*tiro).offset    = 12;
			(*tiro).direction = BOTTOM_LEFT;
			break;
		case 7: //para baixo
			(*tiro).coord_x   = (*nave).coord_x;
			(*tiro).coord_y   = (*nave).coord_y + 20;
			(*tiro).offset    = 11;
			(*tiro).direction = DOWN;
			break;
		case 6: //diagonal direita inferior
			(*tiro).coord_x   = (*nave).coord_x + 20;
			(*tiro).coord_y   = (*nave).coord_y + 20;
			(*tiro).offset    = 14;
			(*tiro).direction = BOTTOM_RIGHT;
			break;
	}
}