#ifndef _KEY_INTERFACE_H_
#define _KEY_INTERFACE_H_

/*
===============================
Perifericos
===============================
*/

#define SELECT_BUTTON 0
#define START_BUTTON  1
#define TL_BUTTON     2
#define TR_BUTTON     3
#define B_BUTTON      4
#define A_BUTTON      5
#define Y_BUTTON      6
#define X_BUTTON      7

#define LEFT_DIR   8
#define RIGHT_DIR  9
#define UP_DIR     10
#define DOWN_DIR   11

/*
===============================
Bordas de leitura
===============================
*/

#define POS_EDGE 0
#define NEG_EDGE 1
#define BOTH_EDGE 2
#define LEVEL 3

void initialize_joystick();

void close_joystick();

int read_KEY(unsigned int KEY, unsigned int state);

int read_JOYSTICK(unsigned int direction, unsigned int state);

void set_callback(void (*callback)());

void peripheral_disable_callback(unsigned int peripheral);

void peripheral_enable_callback(unsigned int peripheral, unsigned int state);


#endif

