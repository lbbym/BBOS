void uart_init(void)
{
    unsigned int selector;

    selector = get32(GPFSEL1);
    selector &= ~(7<<12);                   //clean gpio14
    selector |= 2<<12;                      //set alt5 for gpio14
    selector &= ~(7<<15);                   //clean gpio15
    selector |= 2<<15;                      //set alt5 for gpio15
    put32(GPFSEL1, selector);

    put32(GPPUD, 0);
    delay(150);
    put32(GPPUDCLK0, (1<<14)|(1<<15));
    delay(150);
    put32(GPPUDCLK0, 0);

    put32(AUX_ENABLES, 1);                  //Enable mini uart (this also enables access to it register)
    put32(AUX_MU_CNTL_REG, 0);              //Disable auto flow control and disable receiver and transmitter (for now)
    put32(AUX_MU_IER_REG, 0);               //Disable receive and transmit interrupts
    put32(AUX_MU_LCR_REG, 3);               //Enable 8 bit mode
    
}