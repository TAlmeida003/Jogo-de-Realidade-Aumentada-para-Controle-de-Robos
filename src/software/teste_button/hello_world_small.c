#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
//#include "lib_KEY/KEY.h"
#include "io.h"


int main() {
	printf("init\n");
	IOWR(0x3050,0,3 << 3);
    //alt_ic_isr_register(1, 1, (void *)interrupt_handler, NULL, 0x0);


	while (1){
		/*
			for (int i = 0; i < 8; i++){
 				if (is_KEY_released(i)){
					printf("Bot�o %d foi solto\n",i);
				}
				if (is_KEY_pressed(i)){
					printf("Bot�o %d foi precionado\n",i);
				}
			}
			*/
	}
	 return 0;
}