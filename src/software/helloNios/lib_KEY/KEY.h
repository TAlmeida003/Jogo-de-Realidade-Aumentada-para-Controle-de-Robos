#ifndef _KEY_INTERFACE_H_
#define _KEY_INTERFACE_H_

// Endereço base do periférico
#define MEMORIA_BASE_JOYSTICK 0x03000

// Offsets dos registradores
#define REG_DATA_OFFSET 0
#define REG_CONTROLE_OFFSET 1
#define REG_INTERRUPT_MASK_OFFSET 1

#define IRQ_JOYSTICK 1

// Definição dos botões
#define SELECT 0
#define START  1
#define TL     2
#define TR     3
#define B      4
#define A      5
#define Y      6
#define X      7

// Definição dos direcionais
#define LEFT   8
#define RIGHT  9
#define UP     10
#define DOWN   11

#include "sys/alt_irq.h"
#include "system.h"
#include <alt_types.h>
#include "io.h"

// Controle de acesso ao periférico

void initialize_joystick();

void close_joystick();


// KEY Interface
int is_KEY_pressed(int button);

int is_KEY_released(int button);

int detect_KEY_change(int button);

int state_KEY(int button);

#endif

