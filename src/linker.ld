SECTION 
{
    .text.boot : { *(.text.boot)}
    .text : { *(.text)}
    .rodate : { *(.rodata)}
    .data : { *(.data)}
    . = ALIGN(0x8);
    bss_begin = .;
    .bss : { *(.bss*)}
    bss_end = .;
}