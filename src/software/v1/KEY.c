/*
===============================
Memoria Base
===============================
*/
#define MEMORIA_BASE_RD_DATA_LSB 0X9050
#define MEMORIA_BASE_RD_DATA_MSB 0X9040

#define MEMORIA_BASE_WR_DATA_LSB 0X9030
#define MEMORIA_BASE_WR_DATA_MSB 0X9020

#define MEMORIA_BASE_WE 0x9010
#define MEMORIA_BASE_IRQ 0x9000

/*
===============================
Conjunto de instrucoes
===============================
*/
#define RDEC  4
#define RCTL  5
#define RMIRQ 6
#define WDEC  7
#define WCTL  8
#define WMIRQ 9

/*
===============================
Bordas de leitura
===============================
*/

#define POS_EDGE 0
#define NEG_EDGE 1
#define BOTH_EDGE 2
#define NO_EDGE 3

/*
===============================
Perifericos
===============================
*/

#define SELECT 0
#define START  1
#define TL     2
#define TR     3
#define B      4
#define A      5
#define Y      6
#define X      7

#define LEFT   8
#define RIGHT  9
#define UP     10
#define DOWN   11

#include "io.h"
#include <unistd.h>
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"


//static void (*callback_button)() = NULL;

static void pulse_we(){
	IOWR(MEMORIA_BASE_WE,0, 1);
	IOWR(MEMORIA_BASE_WE,0, 0);
}

static void we_DEC(unsigned int data_MSB, unsigned int data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, data_LSB << 4  | WDEC);
	IOWR(MEMORIA_BASE_WR_DATA_MSB, 0, data_MSB);

	pulse_we();
}

static void we_CTL(unsigned int data_MSB, unsigned int data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, data_LSB << 4 | WCTL);
	IOWR(MEMORIA_BASE_WR_DATA_MSB, 0, data_MSB);

	pulse_we();
}

static void we_MIRQ(unsigned int data_MSB, unsigned int data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, data_LSB << 4 | WMIRQ);
	IOWR(MEMORIA_BASE_WR_DATA_MSB, 0, data_MSB);

	pulse_we();
}

static void re_DEC(unsigned int* data_MSB,unsigned int* data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, RDEC);
	
	*data_LSB = IORD(MEMORIA_BASE_RD_DATA_LSB, 0);
	*data_MSB = IORD(MEMORIA_BASE_RD_DATA_MSB, 0);
}

static void re_CTL(unsigned int* data_MSB, unsigned int* data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, RCTL);
	
	*data_LSB = IORD(MEMORIA_BASE_RD_DATA_LSB, 0);
	*data_MSB = IORD(MEMORIA_BASE_RD_DATA_MSB, 0);
}

static void re_MIRQ(unsigned int* data_MSB, unsigned int* data_LSB){
	IOWR(MEMORIA_BASE_WR_DATA_LSB, 0, RMIRQ);
	*data_LSB = IORD(MEMORIA_BASE_RD_DATA_LSB, 0);
	*data_MSB = IORD(MEMORIA_BASE_RD_DATA_MSB, 0);
}

static void config_pin_state(unsigned int peripheral, unsigned int state){
	unsigned int data_MSB, data_LSB, mask;

	re_CTL(&data_MSB, &data_LSB);
	mask = data_MSB << 18 | data_LSB >> 14; // Pegar os bits de sele��o

	mask = ~(3 << (2 * peripheral)) & mask; //limpar seletor de edge
	mask = (state << (2 * peripheral)) | mask;
	we_CTL(mask, data_LSB);
}

static int read_pin(unsigned int peripheral){
	unsigned int data_MSB, data_LSB;

	re_DEC(&data_MSB, &data_LSB);
	if ((data_LSB & 1 << peripheral) != 0){
		we_DEC(1 << peripheral, data_LSB);
		return 1;
	}
	return 0;
}

int read_KEY(unsigned int KEY, unsigned int state){
	if (KEY > 7 || KEY < 0 || state > 3 || state < 0){
		return -1;
	}

	config_pin_state(KEY, state);
	return read_pin(KEY);
}

int read_JOYSTICK(unsigned int direction, unsigned int state){
	if (direction > 11 || direction < 8 || state > 3 || state < 0){
		return -1;
	}

	config_pin_state(direction, state);
	return read_pin(direction);
}

static void interrupt (void* context){
	//if (callback_button != NULL){
	//	callback_button();
	//}
}

void initialize_joystick(){
	IOWR(MEMORIA_BASE_WR_DATA_LSB,0, 0);
	IOWR(MEMORIA_BASE_WR_DATA_MSB,0, 0);
	IOWR(MEMORIA_BASE_WE,0, 0);
	IOWR(MEMORIA_BASE_IRQ, 2, 1);

	we_CTL(0, 0);
	we_CTL(0, 16383);

	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(MEMORIA_BASE_IRQ, 0x01);
	alt_ic_isr_register(IRQ_IRQ_INTERRUPT_CONTROLLER_ID, IRQ_IRQ, (void *)interrupt, NULL, 0x0);
}

void close_joystick(){
	IOWR(MEMORIA_BASE_WR_DATA_LSB,0, 0);
	IOWR(MEMORIA_BASE_WR_DATA_MSB,0, 0);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(MEMORIA_BASE_IRQ, 0x00);

	we_CTL(0, 0);
}


/*
void set_KEY_callback(void (*callback)()){
	callback_button = callback;
}

void set_KET_interrput(int data_button, int data_edge){
	unsigned int data_MSB, data_LSB;
	re_MIRQ(&data_MSB, &data_LSB);

	unsigned int data;
	data = data_edge << 12 | data_button;
	we_MIRQ(data_MSB, data);
}
*/
