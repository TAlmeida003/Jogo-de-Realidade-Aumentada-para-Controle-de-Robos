#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "KEY.h"
#include "io.h"


void as0() {
	printf("Interrupo 0\n");
}
void as1() {
	printf("Interrupo 1\n");
}
void as2() {
	printf("Interrupo 2\n");
}
void as3() {
	printf("Interrupo 3\n");
}
void as4() {
	printf("Interrupo 4\n");
}
void as5() {
	printf("Interrupo 5\n");
}
void as6() {
	printf("Interrupo 6\n");
}
void as7() {
	printf("Interrupo 7 \n");
}

int main() {
	//printf("Teste de Boto\n");
	initialize_joystick();
	set_KEY_callback((void *)as0, 0,0);
	set_KEY_callback((void *)as1, 1,0);
	set_KEY_callback((void *)as2, 2,0);
	set_KEY_callback((void *)as3, 3,0);
	set_KEY_callback((void *)as4, 4,0);
	set_KEY_callback((void *)as5, 5,0);
	set_KEY_callback((void *)as6, 6,0);
	set_KEY_callback((void *)as7, 7,0);
	//close_joystick();
	//alt_ic_isr_register(0, 1, (void *)interrupt_handler, NULL, 0x0);

	while (1){
		/*
		if (edge_KEY(7, 2)){
			printf("O botao X trocou de estado\n");
		}
		if (is_KEY_released(7)){
			printf("O botao X foi solto\n");
		}*/
		//if (is_KEY_pressed(7)){
			//printf("O botao X foi precionado\n");
		//}
	}

	 return 0;
}
