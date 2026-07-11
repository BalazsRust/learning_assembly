section      .data                     ; this is where variables are initialized
    msg      db   "Hello, World!", 0xa ; 0xa is a newline
    msglen   equ  $ - msg
    numb     db 0x41,0x53,0x53,0x4d,0x45,0x4d,0x42,0x4c,0x59, 0xa ; assembly in hex codes
    numblen equ $ - numb

section      .text                     ; this is the code section
    global   _start                    ; declare entry point
_start:                                ; define entry point
    mov rax, 1                         ; sys_write(
    mov rdi, 1                         ;   STDOUT_FILENO,
    mov rsi, msg                       ;   msg,
    mov rdx, msglen                    ;   sizeof(msg)
    syscall                            ; );

    mov rax, 1                         ; sys_write(
    mov rdi, 1                         ;   STDOUT_FILENO,
    mov rsi, numb                       ;   msg,
    mov rdx, numblen                    ;   sizeof(numb)
    syscall                            ; );


    ; exit
    mov rax, 60                        ; exit
    mov rdi, 0                         ;   exit_status
    syscall                            ; );
