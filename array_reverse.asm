; Array Manipulation with Looping and Reversal
; Accepts an array of integers (e.g., five values) as input from the user, reverses the array and outputs it.

section .data
    prompt db "Enter five single digits separated by spaces (e.g., 1 2 3 4 5): ", 0
    prompt_len equ $ - prompt
    newline db 10                                   ; Newline character
    invalid_input_msg db "Invalid input! Please try again.", 0
    invalid_input_len equ $ - invalid_input_msg

section .bss
    input resb 16      ; Reserve space for the user input line
    array resb 5       ; Reserve space for the digits (5 bytes)

section .text
    global _start

_start:
    ; Prompt the user for input
input_loop:
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, prompt         ; Address of prompt
    mov rdx, prompt_len     ; Length of prompt
    syscall

    ; Read input from the user
    mov rax, 0              ; sys_read
    mov rdi, 0              ; stdin
    mov rsi, input          ; Address of input buffer
    mov rdx, 16             ; Maximum length to read
    syscall

    ; Parse the input and extract digits
    xor r12, r12            ; Index for the array
    mov rdi, input          ; Address of the input buffer

parse_input:
    ; Check if we've processed 5 digits
    cmp r12, 5
    je reverse_array

    ; Load a character from the input buffer
    mov al, [rdi]
    cmp al, 0               ; Check for null terminator (end of string)
    je invalid_input        ; If reached, input is invalid (not enough digits)

    ; Check if the character is a digit
    cmp al, '0'
    jl skip_char            ; Skip non-digit characters
    cmp al, '9'
    jg skip_char            ; Skip non-digit characters

    ; Store valid digit in the array
    mov [array + r12], al
    inc r12                 ; Increment the array index

skip_char:
    inc rdi                 ; Move to the next character in the input buffer
    jmp parse_input         ; Continue parsing

reverse_array:
    ; Reverse the array
    mov r12, 0              ; Left index
    mov r13, 4              ; Right index

reverse_loop:
    cmp r12, r13            ; Check if indices have crossed
    jge print_array

    ; Swap array[r12] and array[r13]
    mov al, [array + r12]
    mov bl, [array + r13]
    mov [array + r12], bl
    mov [array + r13], al

    ; Move indices
    inc r12
    dec r13
    jmp reverse_loop

print_array:
    mov r12, 0              ; Start printing from index 0

print_loop:
    ; Load character from the array
    mov al, [array + r12]
    mov [input], al         ; Store character in input buffer

    ; Print the character
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, input
    mov rdx, 1
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Increment index and check bounds
    inc r12
    cmp r12, 5
    jl print_loop

    ; Exit program
    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; Exit code 0
    syscall

invalid_input:
    ; Print invalid input message
    mov rax, 1
    mov rdi, 1
    mov rsi, invalid_input_msg
    mov rdx, invalid_input_len
    syscall

    ; Restart input loop
    jmp input_loop