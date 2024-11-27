section .bss
    num resb 16             ; Reserve 16 bytes for user input (multi-digit numbers)

section .data
    prompt db "Enter a number: ", 0       ; Prompt message
    zero_msg db "ZERO", 0                 ; Message for zero
    positive_msg db "POSITIVE", 0         ; Message for positive numbers
    negative_msg db "NEGATIVE", 0         ; Message for negative numbers
    invalid_msg db "INVALID INPUT", 0     ; Message for invalid input

section .text
    global _start

_start:
    ; Print the prompt
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; file descriptor (stdout)
    mov ecx, prompt            ; address of the prompt message
    mov edx, 17                ; length of the message
    int 0x80                   ; call kernel

    ; Read user input
    mov eax, 3                 ; sys_read
    mov ebx, 0                 ; file descriptor (stdin)
    mov ecx, num               ; buffer to store input
    mov edx, 16                ; number of bytes to read
    int 0x80                   ; call kernel

    ; Check the first character of the input
    mov al, byte [num]         ; Load the first character into AL

    ; Check for newline or empty input
    cmp al, 10                 ; Check if it's a newline character ('\n')
    je invalid_input           ; If so, classify as INVALID INPUT

    ; Check for '-'
    cmp al, '-'                ; Check if the first character is '-'
    je check_negative_digit    ; If '-', ensure there’s a valid digit next

    ; Check for '0'
    cmp al, '0'                ; Check if the first character is '0'
    je is_zero                 ; If '0', classify as ZERO

    ; Check for digits '1' to '9'
    cmp al, '1'                ; Check if it’s between '1' and '9'
    jl invalid_input           ; If less than '1', it’s invalid
    cmp al, '9'
    jg invalid_input           ; If greater than '9', it’s invalid

    ; If it's a digit, classify as POSITIVE
    jmp is_positive

check_negative_digit:
    ; Ensure the next character is a digit
    mov al, byte [num + 1]     ; Check the next character
    cmp al, '0'                ; Valid digits start from '0'
    jl invalid_input           ; If less, classify as INVALID INPUT
    cmp al, '9'
    jg invalid_input           ; If greater, classify as INVALID INPUT
    jmp is_negative            ; Otherwise, classify as NEGATIVE

is_zero:
    ; Print "ZERO"
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; file descriptor (stdout)
    mov ecx, zero_msg          ; Address of the message
    mov edx, 4                 ; Length of the message
    int 0x80                   ; Call kernel
    jmp end_program            ; Terminate the program

is_positive:
    ; Print "POSITIVE"
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; file descriptor (stdout)
    mov ecx, positive_msg      ; Address of the message
    mov edx, 8                 ; Length of the message
    int 0x80                   ; Call kernel
    jmp end_program            ; Terminate the program

is_negative:
    ; Print "NEGATIVE"
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; file descriptor (stdout)
    mov ecx, negative_msg      ; Address of the message
    mov edx, 8                 ; Length of the message
    int 0x80                   ; Call kernel
    jmp end_program            ; Terminate the program

invalid_input:
    ; Print "INVALID INPUT"
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; file descriptor (stdout)
    mov ecx, invalid_msg       ; Address of the invalid input message
    mov edx, 14                ; Length of the message
    int 0x80                   ; Call kernel

end_program:
    ; Exit the program
    mov eax, 1                 ; sys_exit
    xor ebx, ebx               ; Exit code 0
    int 0x80                   ; Call kernel