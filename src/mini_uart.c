void uart_init(void)
{
    unsigned int selector;

    selector = get32(GPFSEL1);
    selector &= ~(7<<12);                   //clean gpio14
    selector |= 2<<12;                      //set alt5 for gpio14
    selector &= ~(7<<15);                   //clean gpio15
    selector |= 2<<15;                      //set alt5 for gpio15
    put32(GPFSEL1, selector);
}