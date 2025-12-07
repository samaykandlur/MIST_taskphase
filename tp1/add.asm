section .data
    num1    dq 5
    num2    dq 4
    msg     db "Result: ", 0
    msg_len equ $ - msg
    nl      db 10

section .bss
    out_char resb 1

section .text
    global _start

_start:
    mov rax, [num1]
    add rax, [num2]

    add al, '0'
    mov [out_char], al

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, out_char
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

