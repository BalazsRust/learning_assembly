global _start

section .data

my_arr: db 0x12,0x34,0x56,0x78,0x90

    ; just as there is db there is also 
    ; dd declare word (2 bytes)
    ; dd: declare doubleword (4bytes)
    ; dq; declare quadword (8 bytes)

    ; litle endian meaning that the bytes order gets "reversed",the alst byte in the multi byte value goes first

    litle_endian_beef: dw 0xbeef ; becomes 0xef 0xbe in that order i breaks up 0x(last 2) -> 0xfe then another 2 0xbe 

    filled_with_zero:dw 0x42 ; becomes 0x42 0x00 in that order

    my_arr2:dw 0x9876,0x5432,0xAA
    my_arr3: dd 0xdeadbeef, 0xc0ffee  ; 0xc0ffe -> 0xee -> 0xff -> 0xc0 0x00
    my_arr4: dq 0x0102030405060708, 0x090a0b0c0d0e0f00

    ; the equ directive sets a name to the value of an experssion.
    ; Because this is an assembler directive, UNUSED is not written to 
    ; the resulting program. This is similar to #define in c 

    UNUSED: equ 3 

section .text
; the _start label ahs a special meaning it's the program's entry point,
; i.e the first instruction to be excecuted is at this address.
;
_start:
    ; all these are insturctions i.e operations the cpu know how 
    ; to carry out directly. there is a full list of them in the 
    ; inscrution set, but we'll only use a dozen or so.
    ; Instuctions are seperated from their operands by whitespace,
    ; and the operands are seperated from other with commas, like so;
    ; <instuction> <operand1>, <operand2>, .... <operand_n>
    ; The following instuctions are 'mov' which simply copy data.
    ; In case of such instuctions, which have a source and 
    ; a destination operand, the Interl syntax (which nasm uses)
    ; dictates the first operand is the destination, and the second is 
    ; the source
    ; <insturction> DESTINATION, SOURCE 
    ; Generally, the source and destination operands can be either 
    ; an address or a register - a small storage that lives inside
    ; the CPU. the source can also be an immediate value , i.e
    ; a simple number.

    mov rax,0 ; moves the value 0 to register rax

    ; There are several registers avalible  on x86_64. Some serve
    ; specific pupuses (e.g registers for stroing floating point numbers)
    ; while others are called "general purpose" registers.
    ; There are 16 of the,;

    ; rax: accumulator
    ; rbx: base;
    ; rxc: counter
    ; rdx: destination
    ; rsp and rbp : stack pointer and base pointer
    ; rsi and rdi : source and destinationn index
    ; r8 through r15: lack of creativity
    ;
    ; the prefix 'r' in all those mean we want to use all 64 bits 
    ; in the registers. For all those, expect r8 through 15,
    ; It's possible to acces
    ;   - the lowest 32 bits with 'e' prefix e.g eax, ebp
    ;   - the lowest 16 bits withouth any prefix, e.g ax, si 
