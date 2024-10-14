/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'Arquitetura'
 * SOPC Builder design path: ../../Arquitetura.sopcinfo
 *
 * Generated: Thu Feb 03 11:49:25 BRT 2022
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * A configuration
 *
 */

#define ALT_MODULE_CLASS_A altera_avalon_pio
#define A_BASE 0x11160
#define A_BIT_CLEARING_EDGE_REGISTER 0
#define A_BIT_MODIFYING_OUTPUT_REGISTER 0
#define A_CAPTURE 0
#define A_DATA_WIDTH 1
#define A_DO_TEST_BENCH_WIRING 0
#define A_DRIVEN_SIM_VALUE 0
#define A_EDGE_TYPE "NONE"
#define A_FREQ 50000000
#define A_HAS_IN 1
#define A_HAS_OUT 0
#define A_HAS_TRI 0
#define A_IRQ -1
#define A_IRQ_INTERRUPT_CONTROLLER_ID -1
#define A_IRQ_TYPE "NONE"
#define A_NAME "/dev/A"
#define A_RESET_VALUE 0
#define A_SPAN 16
#define A_TYPE "altera_avalon_pio"


/*
 * B configuration
 *
 */

#define ALT_MODULE_CLASS_B altera_avalon_pio
#define B_BASE 0x11130
#define B_BIT_CLEARING_EDGE_REGISTER 0
#define B_BIT_MODIFYING_OUTPUT_REGISTER 0
#define B_CAPTURE 0
#define B_DATA_WIDTH 1
#define B_DO_TEST_BENCH_WIRING 0
#define B_DRIVEN_SIM_VALUE 0
#define B_EDGE_TYPE "NONE"
#define B_FREQ 50000000
#define B_HAS_IN 1
#define B_HAS_OUT 0
#define B_HAS_TRI 0
#define B_IRQ -1
#define B_IRQ_INTERRUPT_CONTROLLER_ID -1
#define B_IRQ_TYPE "NONE"
#define B_NAME "/dev/B"
#define B_RESET_VALUE 0
#define B_SPAN 16
#define B_TYPE "altera_avalon_pio"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00010820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x11
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00008020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x11
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00008000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00010820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x11
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x11
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00008000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2


/*
 * Direction_Analogic configuration
 *
 */

#define ALT_MODULE_CLASS_Direction_Analogic altera_avalon_pio
#define DIRECTION_ANALOGIC_BASE 0x11170
#define DIRECTION_ANALOGIC_BIT_CLEARING_EDGE_REGISTER 0
#define DIRECTION_ANALOGIC_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIRECTION_ANALOGIC_CAPTURE 0
#define DIRECTION_ANALOGIC_DATA_WIDTH 4
#define DIRECTION_ANALOGIC_DO_TEST_BENCH_WIRING 0
#define DIRECTION_ANALOGIC_DRIVEN_SIM_VALUE 0
#define DIRECTION_ANALOGIC_EDGE_TYPE "NONE"
#define DIRECTION_ANALOGIC_FREQ 50000000
#define DIRECTION_ANALOGIC_HAS_IN 1
#define DIRECTION_ANALOGIC_HAS_OUT 0
#define DIRECTION_ANALOGIC_HAS_TRI 0
#define DIRECTION_ANALOGIC_IRQ -1
#define DIRECTION_ANALOGIC_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIRECTION_ANALOGIC_IRQ_TYPE "NONE"
#define DIRECTION_ANALOGIC_NAME "/dev/Direction_Analogic"
#define DIRECTION_ANALOGIC_RESET_VALUE 0
#define DIRECTION_ANALOGIC_SPAN 16
#define DIRECTION_ANALOGIC_TYPE "altera_avalon_pio"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x111f8
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x111f8
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x111f8
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "Arquitetura"


/*
 * TL configuration
 *
 */

#define ALT_MODULE_CLASS_TL altera_avalon_pio
#define TL_BASE 0x11140
#define TL_BIT_CLEARING_EDGE_REGISTER 0
#define TL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TL_CAPTURE 0
#define TL_DATA_WIDTH 1
#define TL_DO_TEST_BENCH_WIRING 0
#define TL_DRIVEN_SIM_VALUE 0
#define TL_EDGE_TYPE "NONE"
#define TL_FREQ 50000000
#define TL_HAS_IN 1
#define TL_HAS_OUT 0
#define TL_HAS_TRI 0
#define TL_IRQ -1
#define TL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TL_IRQ_TYPE "NONE"
#define TL_NAME "/dev/TL"
#define TL_RESET_VALUE 0
#define TL_SPAN 16
#define TL_TYPE "altera_avalon_pio"


/*
 * TR configuration
 *
 */

#define ALT_MODULE_CLASS_TR altera_avalon_pio
#define TR_BASE 0x11150
#define TR_BIT_CLEARING_EDGE_REGISTER 0
#define TR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TR_CAPTURE 0
#define TR_DATA_WIDTH 1
#define TR_DO_TEST_BENCH_WIRING 0
#define TR_DRIVEN_SIM_VALUE 0
#define TR_EDGE_TYPE "NONE"
#define TR_FREQ 50000000
#define TR_HAS_IN 1
#define TR_HAS_OUT 0
#define TR_HAS_TRI 0
#define TR_IRQ -1
#define TR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TR_IRQ_TYPE "NONE"
#define TR_NAME "/dev/TR"
#define TR_RESET_VALUE 0
#define TR_SPAN 16
#define TR_TYPE "altera_avalon_pio"


/*
 * X configuration
 *
 */

#define ALT_MODULE_CLASS_X altera_avalon_pio
#define X_BASE 0x11110
#define X_BIT_CLEARING_EDGE_REGISTER 0
#define X_BIT_MODIFYING_OUTPUT_REGISTER 0
#define X_CAPTURE 0
#define X_DATA_WIDTH 1
#define X_DO_TEST_BENCH_WIRING 0
#define X_DRIVEN_SIM_VALUE 0
#define X_EDGE_TYPE "NONE"
#define X_FREQ 50000000
#define X_HAS_IN 1
#define X_HAS_OUT 0
#define X_HAS_TRI 0
#define X_IRQ -1
#define X_IRQ_INTERRUPT_CONTROLLER_ID -1
#define X_IRQ_TYPE "NONE"
#define X_NAME "/dev/X"
#define X_RESET_VALUE 0
#define X_SPAN 16
#define X_TYPE "altera_avalon_pio"


/*
 * data_A configuration
 *
 */

#define ALT_MODULE_CLASS_data_A altera_avalon_pio
#define DATA_A_BASE 0x111d0
#define DATA_A_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_A_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_A_CAPTURE 0
#define DATA_A_DATA_WIDTH 32
#define DATA_A_DO_TEST_BENCH_WIRING 0
#define DATA_A_DRIVEN_SIM_VALUE 0
#define DATA_A_EDGE_TYPE "NONE"
#define DATA_A_FREQ 50000000
#define DATA_A_HAS_IN 0
#define DATA_A_HAS_OUT 1
#define DATA_A_HAS_TRI 0
#define DATA_A_IRQ -1
#define DATA_A_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_A_IRQ_TYPE "NONE"
#define DATA_A_NAME "/dev/data_A"
#define DATA_A_RESET_VALUE 0
#define DATA_A_SPAN 16
#define DATA_A_TYPE "altera_avalon_pio"


/*
 * data_B configuration
 *
 */

#define ALT_MODULE_CLASS_data_B altera_avalon_pio
#define DATA_B_BASE 0x111c0
#define DATA_B_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_B_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_B_CAPTURE 0
#define DATA_B_DATA_WIDTH 32
#define DATA_B_DO_TEST_BENCH_WIRING 0
#define DATA_B_DRIVEN_SIM_VALUE 0
#define DATA_B_EDGE_TYPE "NONE"
#define DATA_B_FREQ 50000000
#define DATA_B_HAS_IN 0
#define DATA_B_HAS_OUT 1
#define DATA_B_HAS_TRI 0
#define DATA_B_IRQ -1
#define DATA_B_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_B_IRQ_TYPE "NONE"
#define DATA_B_NAME "/dev/data_B"
#define DATA_B_RESET_VALUE 0
#define DATA_B_SPAN 16
#define DATA_B_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x111f8
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x8000
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "Arquitetura_onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 30000
#define ONCHIP_MEMORY2_0_SPAN 30000
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * reset_pulseCounter configuration
 *
 */

#define ALT_MODULE_CLASS_reset_pulseCounter altera_avalon_pio
#define RESET_PULSECOUNTER_BASE 0x111b0
#define RESET_PULSECOUNTER_BIT_CLEARING_EDGE_REGISTER 0
#define RESET_PULSECOUNTER_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RESET_PULSECOUNTER_CAPTURE 0
#define RESET_PULSECOUNTER_DATA_WIDTH 1
#define RESET_PULSECOUNTER_DO_TEST_BENCH_WIRING 0
#define RESET_PULSECOUNTER_DRIVEN_SIM_VALUE 0
#define RESET_PULSECOUNTER_EDGE_TYPE "NONE"
#define RESET_PULSECOUNTER_FREQ 50000000
#define RESET_PULSECOUNTER_HAS_IN 0
#define RESET_PULSECOUNTER_HAS_OUT 1
#define RESET_PULSECOUNTER_HAS_TRI 0
#define RESET_PULSECOUNTER_IRQ -1
#define RESET_PULSECOUNTER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RESET_PULSECOUNTER_IRQ_TYPE "NONE"
#define RESET_PULSECOUNTER_NAME "/dev/reset_pulseCounter"
#define RESET_PULSECOUNTER_RESET_VALUE 0
#define RESET_PULSECOUNTER_SPAN 16
#define RESET_PULSECOUNTER_TYPE "altera_avalon_pio"


/*
 * screen configuration
 *
 */

#define ALT_MODULE_CLASS_screen altera_avalon_pio
#define SCREEN_BASE 0x11180
#define SCREEN_BIT_CLEARING_EDGE_REGISTER 0
#define SCREEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SCREEN_CAPTURE 0
#define SCREEN_DATA_WIDTH 1
#define SCREEN_DO_TEST_BENCH_WIRING 0
#define SCREEN_DRIVEN_SIM_VALUE 0
#define SCREEN_EDGE_TYPE "NONE"
#define SCREEN_FREQ 50000000
#define SCREEN_HAS_IN 1
#define SCREEN_HAS_OUT 0
#define SCREEN_HAS_TRI 0
#define SCREEN_IRQ -1
#define SCREEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SCREEN_IRQ_TYPE "NONE"
#define SCREEN_NAME "/dev/screen"
#define SCREEN_RESET_VALUE 0
#define SCREEN_SPAN 16
#define SCREEN_TYPE "altera_avalon_pio"


/*
 * select_button configuration
 *
 */

#define ALT_MODULE_CLASS_select_button altera_avalon_pio
#define SELECT_BUTTON_BASE 0x110f0
#define SELECT_BUTTON_BIT_CLEARING_EDGE_REGISTER 0
#define SELECT_BUTTON_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SELECT_BUTTON_CAPTURE 0
#define SELECT_BUTTON_DATA_WIDTH 1
#define SELECT_BUTTON_DO_TEST_BENCH_WIRING 0
#define SELECT_BUTTON_DRIVEN_SIM_VALUE 0
#define SELECT_BUTTON_EDGE_TYPE "NONE"
#define SELECT_BUTTON_FREQ 50000000
#define SELECT_BUTTON_HAS_IN 1
#define SELECT_BUTTON_HAS_OUT 0
#define SELECT_BUTTON_HAS_TRI 0
#define SELECT_BUTTON_IRQ -1
#define SELECT_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SELECT_BUTTON_IRQ_TYPE "NONE"
#define SELECT_BUTTON_NAME "/dev/select_button"
#define SELECT_BUTTON_RESET_VALUE 0
#define SELECT_BUTTON_SPAN 16
#define SELECT_BUTTON_TYPE "altera_avalon_pio"


/*
 * start configuration
 *
 */

#define ALT_MODULE_CLASS_start altera_avalon_pio
#define START_BASE 0x11100
#define START_BIT_CLEARING_EDGE_REGISTER 0
#define START_BIT_MODIFYING_OUTPUT_REGISTER 0
#define START_CAPTURE 0
#define START_DATA_WIDTH 1
#define START_DO_TEST_BENCH_WIRING 0
#define START_DRIVEN_SIM_VALUE 0
#define START_EDGE_TYPE "NONE"
#define START_FREQ 50000000
#define START_HAS_IN 1
#define START_HAS_OUT 0
#define START_HAS_TRI 0
#define START_IRQ -1
#define START_IRQ_INTERRUPT_CONTROLLER_ID -1
#define START_IRQ_TYPE "NONE"
#define START_NAME "/dev/start"
#define START_RESET_VALUE 0
#define START_SPAN 16
#define START_TYPE "altera_avalon_pio"


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0x111f0
#define SYSID_QSYS_0_ID 0
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1643898709
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"


/*
 * wrfull configuration
 *
 */

#define ALT_MODULE_CLASS_wrfull altera_avalon_pio
#define WRFULL_BASE 0x11190
#define WRFULL_BIT_CLEARING_EDGE_REGISTER 0
#define WRFULL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WRFULL_CAPTURE 0
#define WRFULL_DATA_WIDTH 1
#define WRFULL_DO_TEST_BENCH_WIRING 0
#define WRFULL_DRIVEN_SIM_VALUE 0
#define WRFULL_EDGE_TYPE "NONE"
#define WRFULL_FREQ 50000000
#define WRFULL_HAS_IN 1
#define WRFULL_HAS_OUT 0
#define WRFULL_HAS_TRI 0
#define WRFULL_IRQ -1
#define WRFULL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WRFULL_IRQ_TYPE "NONE"
#define WRFULL_NAME "/dev/wrfull"
#define WRFULL_RESET_VALUE 0
#define WRFULL_SPAN 16
#define WRFULL_TYPE "altera_avalon_pio"


/*
 * wrreg configuration
 *
 */

#define ALT_MODULE_CLASS_wrreg altera_avalon_pio
#define WRREG_BASE 0x111a0
#define WRREG_BIT_CLEARING_EDGE_REGISTER 0
#define WRREG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WRREG_CAPTURE 0
#define WRREG_DATA_WIDTH 1
#define WRREG_DO_TEST_BENCH_WIRING 0
#define WRREG_DRIVEN_SIM_VALUE 0
#define WRREG_EDGE_TYPE "NONE"
#define WRREG_FREQ 50000000
#define WRREG_HAS_IN 0
#define WRREG_HAS_OUT 1
#define WRREG_HAS_TRI 0
#define WRREG_IRQ -1
#define WRREG_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WRREG_IRQ_TYPE "NONE"
#define WRREG_NAME "/dev/wrreg"
#define WRREG_RESET_VALUE 0
#define WRREG_SPAN 16
#define WRREG_TYPE "altera_avalon_pio"


/*
 * y configuration
 *
 */

#define ALT_MODULE_CLASS_y altera_avalon_pio
#define Y_BASE 0x11120
#define Y_BIT_CLEARING_EDGE_REGISTER 0
#define Y_BIT_MODIFYING_OUTPUT_REGISTER 0
#define Y_CAPTURE 0
#define Y_DATA_WIDTH 1
#define Y_DO_TEST_BENCH_WIRING 0
#define Y_DRIVEN_SIM_VALUE 0
#define Y_EDGE_TYPE "NONE"
#define Y_FREQ 50000000
#define Y_HAS_IN 1
#define Y_HAS_OUT 0
#define Y_HAS_TRI 0
#define Y_IRQ -1
#define Y_IRQ_INTERRUPT_CONTROLLER_ID -1
#define Y_IRQ_TYPE "NONE"
#define Y_NAME "/dev/y"
#define Y_RESET_VALUE 0
#define Y_SPAN 16
#define Y_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
