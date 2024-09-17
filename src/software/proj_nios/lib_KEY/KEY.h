#ifndef _KEY_INTERFACE_H_
#define _KEY_INTERFACE_H_

#define MEMORIA_BASE_KEY 0x03000
#define REG_DATA_OFFSET 0
#define REG_CONTROLE_OFFSET 1

int initialize_joystick();

int close_joystick();

int read_KEY(int* kay_data);


#endif
