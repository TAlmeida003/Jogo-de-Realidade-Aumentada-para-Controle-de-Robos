#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include "lib_KEY/KEY.h"

int main() {
	open_KEY();
    int valor;

    printf("init \n");

    int num = 0;
    while (1) {
        if (read_KEY(&valor)) {
            printf("Bot�o foi pressionado %u \n", valor);
            num++;
        }
    }

    close_KEY();

    return 0;
}
