#define MEMORIA_BASE_JOYSTICK 0x03000

#define REG_DATA_OFFSET 0
#define REG_CONTROLE_OFFSET 1
#define REG_INTERRUPT_MASK_OFFSET 2

#define JOYSTICK_IRQ 1

#define RDEC  0
#define RCTL  1
#define RMIRQ 2
#define WDEC  4
#define WCTL  5
#define WMIRQ 6

#define MEMORIA_BASE_RD_DATA_LSB 0X3050
#define MEMORIA_BASE_RD_DATA_MSB 0X3040

#define MEMORIA_BASE_WR_DATA_LSB 0X3030
#define MEMORIA_BASE_WR_DATA_MSB 0X3020

#define MEMORIA_BASE_WE 0x3010
#define MEMORIA_BASE_IRQ 0x3000

#include "io.h"
#include <stdio.h>
#include <unistd.h>
#include "sys/alt_irq.h"

void (*callback_button0)() = NULL;
int edge0 = 0;
void (*callback_button1)() = NULL;
int edge1 = 0;
void (*callback_button2)() = NULL;
int edge2 = 0;
void (*callback_button3)() = NULL;
int edge3 = 0;
void (*callback_button4)() = NULL;
int edge4 = 0;
void (*callback_button5)() = NULL;
int edge5 = 0;
void (*callback_button6)() = NULL;
int edge6 = 0;
void (*callback_button7)() = NULL;
int edge7 = 0;

void pulse_we(){
	IOWR(MEMORIA_BASE_WE,0, 1);
	IOWR(MEMORIA_BASE_WE,0, 0);
}

void we_DEC(unsigned int data_MSB, unsigned int data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, data_LSB << 3 | WDEC);
	IOWR(MEMORIA_BASE_WR_DATA_MSB, 0, data_MSB);

	pulse_we();
}

void we_CTL(unsigned int data_MSB, unsigned int data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, data_LSB << 3 | WCTL);
	IOWR(MEMORIA_BASE_WR_DATA_MSB, 0, data_MSB);

	pulse_we();
}

void we_MIRQ(unsigned int data_MSB, unsigned int data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, data_LSB << 3 | WMIRQ);
	IOWR(MEMORIA_BASE_WR_DATA_MSB, 0, data_MSB);

	pulse_we();
}

void re_DEC(unsigned int* data_MSB,unsigned int* data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, RDEC);
	*data_LSB = IORD(MEMORIA_BASE_RD_DATA_LSB, 0);
	*data_MSB = IORD(MEMORIA_BASE_RD_DATA_MSB, 0);
}

void re_CTL(unsigned int* data_MSB, unsigned int* data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, RCTL);
	*data_LSB = IORD(MEMORIA_BASE_RD_DATA_LSB, 0);
	*data_MSB = IORD(MEMORIA_BASE_RD_DATA_MSB, 0);
}

void re_MIRQ(unsigned int* data_MSB, unsigned int* data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, RMIRQ);
	*data_LSB = IORD(MEMORIA_BASE_RD_DATA_LSB, 0);
	*data_MSB = IORD(MEMORIA_BASE_RD_DATA_MSB, 0);
}

int edge_KEY(int button, int edge){
	if (button < 0 || button > 7) {
			printf("ExceptionKEY: Botao invalido\n");
			return -1;
	}

	unsigned int data_MSB, data_LSB;
	re_CTL(&data_MSB, &data_LSB);
	unsigned int data, data_msb;

	switch (edge) {
		case 0:
			data = 1 << (2 + button) | data_LSB; // Retirar o ruido
			data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
			if (button == 7){
				data_msb = ~1 & data_MSB;
				we_CTL(data_msb, data);
			} else{
				we_CTL(data_MSB, data);
			}
			break;
		case 1:
			data = 1 << (2 + button) | data_LSB; // Retirar o ruido
			data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
			data = 1 << (14 + 2 * button) | data;
			if (button == 7){
				data_msb = ~1 & data_MSB;
				we_CTL(data_msb, data);
			} else{
				we_CTL(data_MSB, data);
			}
			break;
		case 2:
			data = 1 << (2 + button) | data_LSB; // Retirar o ruido
			data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge

			data = 2 << (14 + 2 * button) | data;
			if (button == 7){
				data_msb = 1 | data_MSB;
				we_CTL(data_msb, data);
			}else{
				we_CTL(data_MSB, data);
			}
			break;
		default:
			printf("ExceptionKEY: Edge invalido\n");
			return -1;
			break;
	}


	re_DEC(&data_MSB, &data_LSB);
	if ((data_LSB & 1 << button) != 0){
		we_DEC(data_MSB, 1 << button);
		return 1;
	}
	return 0;
}


void initialize_joystick(){
	IOWR(MEMORIA_BASE_WR_DATA_LSB,0, 0);
	IOWR(MEMORIA_BASE_WR_DATA_MSB,0, 0);
	IOWR(MEMORIA_BASE_WE,0, 0);
	IOWR(MEMORIA_BASE_IRQ, 2, 1);

	we_CTL(0, 0);
	we_CTL(0, 3);
	we_MIRQ(0, 255);

	usleep(100000);

	for (int i = 0; i < 8; i++){
		edge_KEY(i,1);
		edge_KEY(i,2);
	}

	//alt_ic_isr_register(JOYSTICK_IRQ, JOYSTICK_IRQ, (void *)interrupt_handler, NULL, 0x0);
}

void close_joystick(){
	IOWR(MEMORIA_BASE_WR_DATA_LSB,0, 0);
	IOWR(MEMORIA_BASE_WR_DATA_MSB,0, 0);
	we_CTL(0, 0);
	IOWR(MEMORIA_BASE_IRQ, 2, 0);
}


int state_KEY(int button){
	if (button < 0 || button > 7) {
		printf("ExceptionKEY: Botao invalido\n");
		return -1;
	}

	unsigned int data_MSB, data_LSB;
	re_CTL(&data_MSB, &data_LSB);

	unsigned int data = data_LSB & ~(1 << (2 + button));
	we_DEC(data_MSB, data);

	re_DEC(&data_MSB, &data_LSB);

	if ((data_LSB & 1 << button) != 0){
		we_DEC(data_MSB, 1 << button);
		return 1;
	}
	return 0;
}

void interrupt_handler (void* context, alt_u32 id){
	
	if (callback_button0 != NULL){
		callback_button0();
		edge_KEY(0, edge0);
	}
	if (callback_button1 != NULL){
		callback_button1();
		edge_KEY(1, edge1);
	}
	if (callback_button2 != NULL){
		callback_button2();
		edge_KEY(2, edge2);
	}
	if (callback_button3 != NULL){
		callback_button3();
		edge_KEY(3, edge3);
	}
	if (callback_button4 != NULL){
		callback_button4();
		edge_KEY(4, edge4);
	}
	if (callback_button5 != NULL){
		callback_button5();
		edge_KEY(5, edge5);
	}
	if (callback_button6 != NULL){
		callback_button6();
		edge_KEY(6, edge6);
	}
	if (callback_button7 != NULL){
		callback_button7();
		edge_KEY(7, edge7);
	}
}

void set_KEY_callback(void (*callback)(), int button, int edge){

	if (edge < 0 || edge > 2) {
		printf("ExceptionKEY: Edge invalido\n");
		return;
	}

	unsigned int data_MSB, data_LSB, data;
	re_MIRQ(&data_MSB, &data_LSB);
	data = 1 << button | data_LSB;
	data = ~(3 << (12 + 2 * button)) & data;
	data = edge << (12 + 2 * button) | data;

	switch (button){
	case 0:
		we_MIRQ(data_MSB, data);
		callback_button0 = callback;
		edge0 = edge;
		break;
	case 1:
		we_MIRQ(data_MSB, data);
		callback_button1 = callback;
		edge1 = edge;
		break;
	case 2:
		we_MIRQ(data_MSB, data);
		callback_button2 = callback;
		edge2 = edge;
		break;
	case 3:
		we_MIRQ(data_MSB, data);
		callback_button3 = callback;
		edge3 = edge;
		break;
	case 4:
		we_MIRQ(data_MSB, data);
		callback_button4 = callback;
		edge4 = edge;
		break;
	case 5:
		we_MIRQ(data_MSB, data);
		callback_button5 = callback;
		edge5 = edge;
		break;
	case 6:
		we_MIRQ(data_MSB, data);
		callback_button6 = callback;
		edge6 = edge;
		break;
	case 7:
		we_MIRQ(data_MSB, data);
		callback_button7 = callback;
		edge7 = edge;
		break;
	default:
		printf("ExceptionKEY: Botao invalido\n");
		return;
		break;
	}

	alt_ic_isr_register(0, 1, (void *)interrupt_handler, NULL, 0x0);
}
