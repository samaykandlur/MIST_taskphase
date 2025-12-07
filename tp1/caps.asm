section .bss
    buffer  resb 100
    length  resq 1

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 100
    syscall

    mov [length], rax

    mov rcx, 0

loop:
    cmp rcx, [length]
    jge done

    mov al, [buffer + rcx]

    cmp al, 'a'
    jl skip

    cmp al, 'z'
    jg skip

    sub al, 32
    mov [buffer + rcx], al

skip:
    inc rcx
    jmp loop

done:
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, [length]
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
