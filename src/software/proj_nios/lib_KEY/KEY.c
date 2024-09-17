#define MEMORIA_BASE_KEY 0x03010
#define REG_DATA_OFFSET 0
#define REG_CONTROLE_OFFSET 1


int open_KEY(){
    volatile int *p_led = (int *) MEMORIA_BASE_KEY;
    *(p_led + REG_CONTROLE_OFFSET) = 2047;
    return 1;
}


int read_KEY (int* kay_data){
    volatile int *p_led = (int *) MEMORIA_BASE_KEY;
    
    if (*(p_led + REG_DATA_OFFSET) != 0){
    	*kay_data = *(p_led + REG_DATA_OFFSET);
        *(p_led + REG_DATA_OFFSET) = 26;
        return 1;
    }
    *kay_data = 0;
    return 0;
}

int close_KEY(){
    volatile int *p_led = (int *) MEMORIA_BASE_KEY;
    *(p_led + REG_CONTROLE_OFFSET) = 0;
    return 1;
}
