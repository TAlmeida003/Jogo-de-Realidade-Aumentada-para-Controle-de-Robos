#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include <string.h>

#define UART_BASE 0x00
#define REG_DATA 0
#define REG_CONTROL 1
#define REG_INT_ENABLE 2
#define REG_INT_STATUS 3

#define BUFFER_SIZE 100

#define TX_NOT_FULL 0x80
#define RX_NOT_EMPTY 0x08

volatile char txBuffer[BUFFER_SIZE] = {0};
volatile char rxBuffer[BUFFER_SIZE] = {0};

volatile unsigned int txlength = 0;
volatile unsigned int txIndex = 0;
volatile unsigned int rxIndex = 0;
volatile unsigned int send_command = 0;
volatile unsigned int receive_byte = 0;

volatile unsigned int *uart_ptr = (unsigned int *) UART_BASE;


/*Vers�o Bloqueante*//*
int sendReceive(const char* message, const char* expected){
    txlength = strlen(message);
    printf("tx: %s \n", message);
    for (int i = 0; i < txlength; i++){
        while (uart_ptr[REG_CONTROL] & (1<<7));
        uart_ptr[REG_DATA] = message[i];
    }

    rxIndex = 0;
    //alt_putstr("receiver\n ");
    while (1){

        if (!(uart_ptr[REG_CONTROL] & (1<<6))){
        	rxBuffer[rxIndex] = uart_ptr[REG_DATA];
            printf("%c", rxBuffer[rxIndex]);

            if (rxIndex < BUFFER_SIZE){
               rxIndex++;
            } else {
               rxIndex = 0;
            }
            rxBuffer[rxIndex] = '\0';

            if (strstr((const char *) rxBuffer, expected)){
                return 1;
            } else if (strstr((const char *) rxBuffer, "ERROR\r\n")){
                return 0;
            } else if (strstr((const char *) rxBuffer, "FAIL\r\n")){
                return 0;
            }
            //usleep(1000000);
        }
    }
}*/


static void interrupt (void* context){
    unsigned int status = uart_ptr[REG_INT_STATUS];

    if (status & TX_NOT_FULL){
        uart_ptr[REG_DATA] = txBuffer[txIndex++];
        uart_ptr[REG_INT_STATUS] = TX_NOT_FULL;

        if (txIndex >= txlength) {
            send_command = 1;
    	    uart_ptr[REG_INT_ENABLE] &= ~(TX_NOT_FULL);
        }
    } else if (status & RX_NOT_EMPTY){
        rxBuffer[rxIndex++] = uart_ptr[REG_DATA];  // Lê o dado e incrementa o índice
        rxBuffer[rxIndex] = '\0';
        printf("%c", rxBuffer[rxIndex - 1]);
        receive_byte = 1;
        uart_ptr[REG_INT_STATUS] = RX_NOT_EMPTY;

        if (rxIndex >= BUFFER_SIZE){
        	rxIndex = 0;
        }
	}
}

int sendReceive(const char* message, const char* expected){
    txlength = strlen(message);
    txIndex = 0;
    rxIndex = 0;
    rxBuffer[0] = '\0';

    // enviar os primeiros do tamanho do fifo
    for (int i = 0; (i < 16) && (txIndex < txlength); i++) {
        uart_ptr[REG_DATA] = message[txIndex++];
    }

    if (txIndex < txlength) {
    	strncpy((char*) txBuffer, message, BUFFER_SIZE - 1);
    	uart_ptr[REG_INT_ENABLE] |= TX_NOT_FULL;
    } else {
    	send_command = 1;
    }

    char local_rxBuffer[BUFFER_SIZE];

    while (1){
        if (send_command && receive_byte){
            receive_byte = 0;
            strncpy(local_rxBuffer, (const char *)rxBuffer, BUFFER_SIZE);
            if (strstr(local_rxBuffer, expected)) {
                return 1;
            } else if (strstr(local_rxBuffer, "ERROR\r\n")) {
                return 0;
            } else if (strstr(local_rxBuffer, "FAIL\r\n")) {
                return 0;
            }
        }
    } send_command = 0;
}

int executeCommand(const char* command, const char* expected) {
    if (sendReceive(command, expected)) {
        //printf("Comando '%s' executado com sucesso.\n", command);
        return 1;
    } else {
        //printf("Erro ao executar o comando '%s'.\n", command);
        return 0;
    }
}

int main(){
    alt_putstr("Teste ESP: \n");
/*
    uart_ptr[REG_CONTROL] =  0;
    uart_ptr[REG_CONTROL] =  0b11111;
    uart_ptr[REG_INT_ENABLE] = 0x08;
    alt_ic_isr_register(0, 2, (void *)interrupt, NULL, 0x0);

    executeCommand("ATE1\r\n", "OK\r\n");                        // Desabilita eco
    executeCommand("AT+UART_CUR=115200,8,1,0,3\r\n", "OK\r\n");  // Configura UART
    executeCommand("AT+CWLAP\r\n", "OK\r\n");                    // Lista redes
    executeCommand("AT+CWMODE=1\r\n", "OK\r\n");                 // Modo Station
    executeCommand("AT+CWJAP=\"Maria \",\"991102839\"\r\n", "OK\r\n"); // Conecta na rede
    executeCommand("AT+CIPSTART=\"TCP\",\"192.168.0.6\",5050\r\n", "OK\r\n"); // Conecta ao servidor
    executeCommand("AT+CIPSEND=13\r\n", ">");                    // Pronto para envio
    executeCommand("hello world!!!", "OK\r\n");                  // Envia mensagem
    executeCommand("AT+CIPCLOSE\r\n", "OK\r\n");
*/
    while (1){
    }
    return 0;
}
