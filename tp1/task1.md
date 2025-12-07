# Task 1

###### *07-12-2025*

## Write an assembly program (x86) that adds 2 arbitary numbers, and prints to the console.

## Breakdown

### Section 1: .data

##### .data

Tells the assembler "Below are varibales that already have data values"

`section .data`

##### num1 dq 5

`num1 dq 5`

`num1` = label (name/address)

`dq` = define quadword (8 bytes / 64 bits)

`5` = value stored there

`num1 → 0000000000000005   (8 bytes)`

##### msg db "Result: ", 0

`msg db "Result: ", 0`

* `db` = define bytes
* `"Result: "` is stored byte by byte
* `0` = NULL terminator (like C-strings)

##### msg_len equ $ - msg

`msg_len equ $ - msg`

`equ` = define a constant (`#define` in C)

`$` = current memory address

`msg` = address where the string started

this means : `msg_len = current_pos - start_of_msg`

##### nl db 10

`nl db 10`

`10` = newline character '\0'

#### Section 2: .bss

This section is for memory that exists but has no initial value

##### out_char resb  1

`out_char resb 1`

`resb` = reserve bytes

`1` = reserve 1 byte

`char out_char; //in C`


### Section 3: .text

```
section .text
global _start
```

`.text` = executable code 

`global _start` = start label visible as the entry point to the linker


#### Program start:

```
_start:
```

`similar to main() in C`


#### Adding the numbers

```
mov rax, [num1]

add rax, [num2]
```

This means: load the value stored at address `num1` into register `rax`

`num1` = address

`[num1]` = value at address

So now  `rax = 5`


`add rax, [num2]`

This adds the value stored at `num2` to rax

`rax = 5 + 4 = 9`


#### Int to char conversion

`add al, 0`

`RAX` = 64-bit

* `EAX` = low 32 bits
  * `AX` = low 16 bits
    * `AL` = low 8 bits (low byte)
    * `AH` = high 8 bits

ASCII:

`'0'`= 48

Then, `AL = 9 + 48 = 57`

ASCII of `9` is 57


#### mov [out_char], al

`mov [out_char], al`

`out_char = '9'`



### WRITE THE PREFIX

#### mov rax, 1

`mov rax, 1`

Set syscall number:

* `1` = `sys_write` in Linux


#### mov rdi, 1

* `rdi` = first argument to syscall
* `1` = file descriptor for **stdout**

#### mov rsi, msg

`mov rsi, msg`

* `rsi` = second argument
* pointer to the string `"Result: "`

#### mov rdx, msg_len

`mov rdx, msg_len`

* `rdx` = third argument
* number of bytes to write (length of the message)

#### syscall

`syscall`

Tells the CPU: "Call the kernel with: write(1, msg, msg_len)"


### Write the Digit

```
mov rsi, out_char
mov rdx, 1
syscall
```

* `rsi = out_char` → buffer with the single character (digit)
* `rdx = 1` → length = 1 byte
* `syscall` → same syscall (write), prints the digit


### Newline

```
mov rax, 1      ; write
mov rdi, 1      ; stdout
mov rsi, nl     ; buffer = newline
mov rdx, 1      ; length = 1
syscall
```

prints `'\n'`


### Exit program

```
mov rax, 60
mov rdi, 0
syscall
```

* `rax = 60` → syscall number for `exit`
* `rdi = 0` → exit status code (0 = success)
* `syscall` → kernel terminates your program

Same as  `exit(0); //C`
