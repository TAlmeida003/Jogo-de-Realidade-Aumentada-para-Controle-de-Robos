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

	}

	 return 0;
}
