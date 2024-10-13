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
	printf("Teste de Boto\n");
	initialize_joystick();
	set_KEY_callback(as0, 0,0);
	set_KEY_callback(as1, 1,0);
	set_KEY_callback(as2, 2,0);
	set_KEY_callback(as3, 3,0);
	set_KEY_callback(as4, 4,0);
	set_KEY_callback(as5, 5,0);
	set_KEY_callback(as6, 6,0);
	set_KEY_callback(as7, 7,0);

	while (1){
	}

	 return 0;
}

