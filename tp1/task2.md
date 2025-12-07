# Task 2

###### *07-12-2025*

[asm file](tp1/caps.asm)

## Write an assembly program (x86) that takes a string as input from STDIN and capitalizes all characters.

---

## Breakdown

---

### Section 1: .bss

#### .bss

This section is for memory that exists but has no initial data

```
section .bss
```

---

##### buffer resb 100

```
buffer resb 100
```

`resb` = reserve bytes

`100` = allocates 100 bytes of memory

This buffer stores input from user.

Equivalent in C:

```
char buffer[100];
```

---

##### length resq 1

```
length resq 1
```

`resq` = reserve quadword (8 bytes)

Used to store how many bytes were read from stdin.

Equivalent in C:

```
long length;
```

---

### Section 2: .text

```
section .text
global _start
```

`.text` = executable code

`global _start` = visible entry point for the linker

---

### Program start

```
_start:
```

This is where execution starts (like `main()` in C).

---

### Read input from user

```
mov rax, 0
mov rdi, 0
mov rsi, buffer
mov rdx, 100
syscall
```

Linux syscall: **read**

Registers:

* `rax = 0` → syscall: read
* `rdi = 0` → stdin
* `rsi = buffer` → where data is stored
* `rdx = 100` → max input size

After syscall:

```
rax = number of bytes read
```

---

### Save input length

```
mov [length], rax
```

Stores byte count for loop and output.

---

### Initialize counter

```
mov rcx, 0
```

Used as string index counter.

Equivalent in C:

```
int i = 0;
```

---

### Loop through string

```
loop:
cmp rcx, [length]
jge done
```

Means:

```
If i >= length → exit loop
```

Equivalent in C:

```
while (i < length)
```

---

### Load character

```
mov al, [buffer + rcx]
```

Reads a single byte:

```
char ch = buffer[i];
```

---

### Check lowercase range

```
cmp al, 'a'
jl skip

cmp al, 'z'
jg skip
```

Logic:

```
If char not between 'a' and 'z' → skip
```

Equivalent in C:

```
if (ch < 'a' || ch > 'z') skip;
```

---

### Convert to uppercase

```
sub al, 32
mov [buffer + rcx], al
```

ASCII rule:

```
'A' = 65
'a' = 97
difference = 32
```

So:

```
ch = ch - 32
```

---

### Loop increment

```
skip:
inc rcx
jmp loop
```

Equivalent in C:

```
i++;
```

---

### Print modified string

```
done:
mov rax, 1
mov rdi, 1
mov rsi, buffer
mov rdx, [length]
syscall
```

Linux syscall: **write**

Registers:

* `rax = 1` → write
* `rdi = 1` → stdout
* `rsi = buffer` → string output
* `rdx = length` → number of bytes

Equivalent in C:

```
write(1, buffer, length);
```

---

### Exit program

```
mov rax, 60
xor rdi, rdi
syscall
```

* `rax = 60` → exit syscall
* `rdi = 0` → success exit code

Equivalent in C:

```
exit(0);
```

