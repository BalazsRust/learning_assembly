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
    
