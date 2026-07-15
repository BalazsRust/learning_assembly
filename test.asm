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
    ; Als, for registers rax through rdx, it's possible to access:
    ;   - the highest byte in the 16 bits with the 'h' suffix, in 
    ;   the same way as above, e.g ah
    ; This is summarized in figure 3-5 of section 3.4.1
    ; basic architecture. These first 8 named registers and their extra
    ; access modes are historical, dating back to the first Intel proccessors.
    ;
    ; (Note: we use 'byte' as a synonym of '8 bits', because it
    ; indeed is in the x86 architecture.)
    ;
    mov eax, 0x12345678 ; copies 4 bytes to eax
    ; still copies 4 bytes to eax: the reaming 2 bytes are filled 
    ; with zeroes, i.e this is the same as 
    ; mov eax,0x0000abcd
    ; note that this is different from 'mov ax, 0xabcd'
    ; in that the previous instuction would only change the lowest 
    ; 2 bytes of the register.
    ;
    mov eax, 0xabcd

    ; copies to the lowest byte: now ax will be 0xab12

    mov al, 0x12
    ;
    mov ah, 0x34

    ; and of course you can make arithemic too.

    mov rdi, 10
    mov rsi, 7
    mov rbx, 14

    inc rdi ; INC : increment
    dec rsi ; DEC: decrement

    ; ADD : adds the two operands and stores the result in the destination
    ; one (again, that's the first one, because we'are using Intel syntax.)
    ;
    add rdi,rbx ; Equivalent to rdi += rbx;

    sub rsi,rbx ; SUB: subtract. equivalent to rsi -= rbx

    ; Naturally, we also have instuctions for multiplying and ividing 
    ; integers, but they come with a few catches.
    ; 
    ; First, there's two variants for each: MUL and DIV interpret their
    ; operands as unsigned integers, while IMUL and IDIV interpret their
    ; operands as signed integers in two's complement
    ; (This changes wether or not the operands' most significant bits are 
    ; interpreted as sign bits).
    ;
    ; Second,while both multiplication and division need two numbers,
    ; the MUL and DIV instructions can take a single operand because they use 
    ; fixed registers for the other number.
    ; For exa,ple, when a 64-bit operand is used in
    ;
    ;   - MUL, the result is rax * <operand>, and it's a 128-bit value
    ;  stored in rdx:rax - meaning the 64 lower bits are stored in rdx
    ;  while the 64 upper bits are stored in rax
    ;
    ; - DIV, the operand is the divisor and the dividend is rdx:rax,
    ;   meaning it's a 128-bit value whose 64 upper bits are in rdx and 
    ;   whole 64 lower bits are in rax. The quotient is a 64 bit value
    ;   stored in rax, and the remainder is also a 64 bit value, stored 
    ;   in rdx
    ;
    mov rax,7 
    mov rdx 4 ; will be overwritten by mul
    mov rdi, 3

    mul rdi 
    ; here rax <- 3 * 7 = 21 rdx <- 0 (*)

    mov rax, 22
    mov rdx, 0
    mov rdi, 4
    
    div rdi
    ; here rax is floor(22 /4) = 5, and rdx is 22 mod 4 = 2 (*)

    ; finnally we ahve bitwise operations to 
    mov rdi,0x35
    mov rsi,0x44

    and rdi,rsi ; bitwise AND
    or rdi,rsi ; bitwise OR
    xor rdi,rsi ; bitwise XOR

    shr rsi,2 ; right (logical) bitshift: equivalnet to rsi >> 2
    shl rsi,3 ; left (logical) bitshift: equivalent to rsi << 3

    ; Note that there's SAR for arithmetic right shift.
    ; Ther's also SAL, but it's equivalent to SHL.

    ;the code below is a system calll to exit cleanly
    ; we'll explain it in the next file.
    ;
    mov rax, 60
    xor rdi,rdi 
    syscall
    ; Exercises
;
; === First Things First ===
; Assemble and link this file into a program, then run it.
; (The program should do nothing other than exit cleanly)
;
; === St Thomas' Wisdom ===
; Verify all claims marked with (*).
;	- Print a hexdump of the program to verify db, dw, etc. work as stated,
;	including the endianess.
;	- Run the program in gdb to verify that the instructions work as stated,
;	stepping through each one and printing the affected registers' value
;	as needed. (Refer to the "Debugging" section of README.md to learn how.)
;
; === Changing Stuff and Seeing What Happens ===
;	- Comment out the syscall instruction and run again.
;	- Change DIV's operand to zero and run again.
;
