#include "sys/alt_stdio.h"
#include "system.h"
#include "KEY.h"
// X, Y, A, B, TR, TL, START, SELECT,


int main() {
	printf("Test button\n");
	initialize_joystick();


	while (1){
		for (int i = 0; i < 12; i++){
			if (read_KEY(i, 1) && i < 8){
				printf("Button %d pressed\n", i);
			} //else if (read_JOYSTICK(i, 0) && i >= 8){
			//	alt_printf("Direction %d pressed\n", i);
			//}
		}

	}

	 return 0;
}

