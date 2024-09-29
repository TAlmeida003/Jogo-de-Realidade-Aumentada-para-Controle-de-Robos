#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "KEY.h"


int main() {
	printf("init\n");
	initialize_joystick();
	//close_joystick();
    //alt_ic_isr_register(1, 1, (void *)interrupt_handler, NULL, 0x0);

	while (1){
		if (edge_KEY(0, 0)){
			printf("SELECT\n");
		}
		if (edge_KEY(1, 0)){
			printf("START\n");
		}
		if (edge_KEY(0, 0)){
			printf("TL\n");
		}
		if (edge_KEY(3, 0)){
			printf("TR\n");
		}
		if (edge_KEY(4, 0)){
			printf("B\n");
		}
		if (edge_KEY(5, 0)){
			printf("A\n");
		}
		if (edge_KEY(6, 0)){
			printf("Y\n");
		}
		if (edge_KEY(7, 0)){
			printf("X\n");
		}
	}

	 return 0;
}
