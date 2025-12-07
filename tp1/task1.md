# Task 1

###### *07-12-2025*

## Write an assembly program (x86) that adds 2 arbitary numbers, and prints to the console.

## Breakdown

---

### Section 1: .data

##### .data

Tells the assembler "Below are variables that already have data values"

`section .data`

---

##### num1 dq 5

`num1 dq 5`

`num1` = label (name/address)

`dq` = define quadword (8 bytes / 64 bits)

`5` = value stored there

```
num1 → 0000000000000005   (8 bytes)
```

---

##### num2 dq 4

`num2 dq 4`

Same idea as `num1`.

---

##### msg db "Result: ", 0

`msg db "Result: ", 0`

* `db` = define bytes
* `"Result: "` is stored byte by byte
* `0` = NULL terminator (like C-strings)

Memory becomes:

```
R e s u l t : _ 0
```

ASCII values:

```
52 65 73 75 6C 74 3A 20 00
```

---

##### msg_len equ $ - msg

`msg_len equ $ - msg`

`equ` = define a constant

`$` = current memory address

`msg` = address where the string started

This means:

```
msg_len = current_pos - start_of_msg
```

Which gives length of `"Result: "`.

---

##### nl db 10

`nl db 10`

`10` = newline character `'\n'`

---

### Section 2: .bss

This section is for memory that exists but has no initial value.

---

##### out_char resb 1

`out_char resb 1`

`resb` = reserve bytes

`1` = reserve 1 byte

Equivalent in C:

```c
char out_char;
```

---

### Section 3: .text

```
section .text
global _start
```

`.text` = executable code

`global _start` = start label visible as the entry point to the linker

---

### Program start

```
_start:
```

Similar to `main()` in C.

---

### Adding the numbers

```
mov rax, [num1]
add rax, [num2]
```

This loads the value stored at address `num1` into `rax`.

`num1` = address

`[num1]` = value at the address

So:

```
rax = 5
```

Then:

```
rax = 5 + 4 = 9
```

---

### Int to char conversion

```
add al, '0'
```

Register layout:

`RAX` = 64-bit

* `EAX` = low 32 bits
  * `AX` = low 16 bits
    * `AL` = low 8 bits (low byte)
    * `AH` = high 8 bits

ASCII:

```
'0' = 48
```

So:

```
AL = 9 + 48 = 57
```

ASCII 57 = character `'9'`.

---

### Store character

```
mov [out_char], al
```

Result:

```
out_char = '9'
```

---

### Write the prefix

#### mov rax, 1

```
mov rax, 1
```

Syscall number:

* `1` = `sys_write`

---

#### mov rdi, 1

```
mov rdi, 1
```

* `rdi` = first argument
* `1` = stdout

---

#### mov rsi, msg

```
mov rsi, msg
```

Pointer to `"Result: "`.

---

#### mov rdx, msg_len

```
mov rdx, msg_len
```

Number of bytes to write.

---

#### syscall

```
syscall
```

Calls:

```
write(1, msg, msg_len)
```

---

### Write the digit

```
mov rsi, out_char
mov rdx, 1
syscall
```

* Writes one byte (the digit)

---

### Newline

```
mov rax, 1
mov rdi, 1
mov rsi, nl
mov rdx, 1
syscall
```

Prints newline.

---

### Exit program

```
mov rax, 60
mov rdi, 0
syscall
```

* `rax = 60` → exit
* `rdi = 0` → success

Equivalent C:

```c
exit(0);
```
