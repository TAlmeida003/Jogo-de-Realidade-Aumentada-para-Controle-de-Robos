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

void initialize_joystick(){
	IOWR(MEMORIA_BASE_WR_DATA_LSB,0, 0);
	IOWR(MEMORIA_BASE_WR_DATA_MSB,0, 0);
	IOWR(MEMORIA_BASE_WE,0, 0);
	IOWR(MEMORIA_BASE_IRQ, 2, 1);

	we_CTL(0, 0);
	we_CTL(0, 3);

	//alt_ic_isr_register(JOYSTICK_IRQ, JOYSTICK_IRQ, (void *)interrupt_handler, NULL, 0x0);
}

void close_joystick(){
	IOWR(MEMORIA_BASE_WR_DATA_LSB,0, 0);
	IOWR(MEMORIA_BASE_WR_DATA_MSB,0, 0);
	we_CTL(0, 0);
	IOWR(MEMORIA_BASE_IRQ, 2, 0);
}

int is_KEY_pressed(int button){
	if (button < 0 || button > 7) {
		printf("ExceptionKEY: Botao invalido\n");
		return -1;
	}

	int data_MSB, data_LSB;

	re_CTL(&data_MSB, &data_LSB);

	unsigned int data = 1 << (2 + button) | data_LSB; // Retirar o ruido
	data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
	we_CTL(data_MSB, data);

	re_DEC(&data_MSB, &data_LSB);
	if ((data_LSB & 1 << button) != 0){
		we_DEC(data_MSB, 1 << button);
		return 1;
	}
	return 0;
}

int is_KEY_released(int button){
	if (button < 0 || button > 7) {
		printf("ExceptionKEY: Botao invalido\n");
		return -1;
	}

	unsigned int data_MSB, data_LSB;

	re_CTL(&data_MSB, &data_LSB);

	unsigned int data = 1 << (2 + button) | data_LSB; // Retirar o ruido
	data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
	data = 1 << (14 + 2 * button) | data;
	we_CTL(data_MSB, data);

	re_DEC(&data_MSB, &data_LSB);
	if ((data_LSB & 1 << button) != 0){
		we_DEC(data_MSB, 1 << button);
		return 1;
	}
	return 0;
}

int detect_KEY_change(int button){
	if (button < 0 || button > 7) {
			printf("ExceptionKEY: Botao invalido\n");
			return -1;
		}

	unsigned int data_MSB, data_LSB;
	re_CTL(&data_MSB, &data_LSB);

	unsigned int data = 1 << (2 + button) | data_LSB; // Retirar o ruido
	data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
	data = 2 << (14 + 2 * button) | data;
	we_CTL(data_MSB, data);

	re_DEC(&data_MSB, &data_LSB);

	if ((data_LSB & 1 << button) != 0){
		we_DEC(data_MSB, 1 << button);
		return 1;
	}
	return 0;
}

int edge_KEY(int button, int edge){
	if (button < 0 || button > 7) {
			printf("ExceptionKEY: Botao invalido\n");
			return -1;
	}

	unsigned int data_MSB, data_LSB;
	re_CTL(&data_MSB, &data_LSB);
	unsigned int data;

	switch (edge) {
	case 0:
		data = 1 << (2 + button) | data_LSB; // Retirar o ruido
		data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
		we_CTL(data_MSB, data);
		break;
	case 1:
		data = 1 << (2 + button) | data_LSB; // Retirar o ruido
		data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
		data = 1 << (14 + 2 * button) | data;
		break;
	case 2:
		data = 1 << (2 + button) | data_LSB; // Retirar o ruido
		data = ~(3 << (14 + 2 * button)) & data; //limpar seletor de edge
		data = 2 << (14 + 2 * button) | data;
		break;
	default:
		printf("ExceptionKEY: Edge invalido\n");
		return -1;
		break;
	}

	we_CTL(data_MSB, data);

	re_DEC(&data_MSB, &data_LSB);
	if ((data_LSB & 1 << button) != 0){
		we_DEC(data_MSB, 1 << button);
		return 1;
	}
	return 0;
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

/*
int (*callback_all_buttons)();

void set_KEY_callback(void (*callback)(), int button){
	volatile int *p_led = (int *) MEMORIA_BASE_JOYSTICK;
	if (button < 0 || button > 8) {
		printf("ExceptionKEY: Botao invalido\n");
		return;
	}

	switch (button)
	{
	case 0:
		break;
	case 1:
		break;
	case 2:
		break;
	case 3:
		break;
	case 4:
		break;
	case 5:
		break;
	case 6:
		break;
	case 7:
		break;
	default:
		*(p_led + REG_INTERRUPT_MASK_OFFSET) = 255;
		callback_all_buttons = callback;
		break;
	}
}

void interrupt_handler (void* context, alt_u32 id){

}
*/
