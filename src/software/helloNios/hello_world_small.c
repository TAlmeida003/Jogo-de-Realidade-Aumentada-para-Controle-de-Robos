#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "sys/alt_irq.h"
#include "lib_KEY/KEY.h"
#include "io.h"


void interrupt_handler(void* context, alt_u32 id);


int main() {
	printf("init\n");
	//initialize_joystick();
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

void interrupt_handler(void* context, alt_u32 id) {
	printf("Bot�o X foi precionado\n");
	is_KEY_pressed(X);
}

