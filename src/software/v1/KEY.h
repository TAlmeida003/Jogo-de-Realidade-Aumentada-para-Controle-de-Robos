#ifndef _KEY_INTERFACE_H_
#define _KEY_INTERFACE_H_

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


void initialize_joystick();

void close_joystick();

int read_KEY(unsigned int KEY, unsigned int state);

int read_JOYSTICK(unsigned int direction, unsigned int state);

/*
// KEY Interface
int state_KEY(unsigned int button);

int edge_KEY(unsigned int button, unsigned int edge);

void set_KEY_callback(void (*callback)());

void set_KET_interrput(int data_button, int data_edge);
*/
#endif

