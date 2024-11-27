; Sensor Control Simulation
; Simulates sensor-based control of motor and alarm


global _start

section .data
    sensor_value    dd 0        ; Simulated sensor input
    motor_status    db 0        ; Motor status: 0=OFF, 1=ON
    alarm_status    db 0        ; Alarm status: 0=OFF, 1=ON

    HIGH_LEVEL      equ 80
    MODERATE_LEVEL  equ 50

    prompt          db 'Enter sensor value: ', 0
    input_buffer    db 10 dup(0)
    motor_msg       db 'Motor Status: ', 0
    alarm_msg       db 'Alarm Status: ', 0
    on_msg          db 'ON', 10, 0
    off_msg         db 'OFF', 10, 0

section .text
_start:
    ; Prompt for sensor value
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, prompt
    mov     edx, 20             ; Length of the prompt
    int     0x80

    ; Read user input
    mov     eax, 3
    mov     ebx, 0
    mov     ecx, input_buffer
    mov     edx, 10
    int     0x80

    ; Convert input to integer
    mov     esi, input_buffer
    call    atoi                ; Result in EAX

    ; Store sensor value
    mov     [sensor_value], eax

    ; Read sensor value
    mov     eax, [sensor_value]

    ; Determine actions based on sensor value
    cmp     eax, HIGH_LEVEL
    jg      high_level

    cmp     eax, MODERATE_LEVEL
    jg      moderate_level

low_level:
    ; Low level: Motor ON, Alarm OFF
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 0
    jmp     display_status

moderate_level:
    ; Moderate level: Motor OFF, Alarm OFF
    mov     byte [motor_status], 0
    mov     byte [alarm_status], 0
    jmp     display_status

high_level:
    ; High level: Motor ON, Alarm ON
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 1

display_status:
    ; Display motor status
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, motor_msg
    mov     edx, 14
    int     0x80

    mov     al, [motor_status]
    cmp     al, 1
    je      motor_on
    jmp     motor_off

motor_on:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, on_msg
    mov     edx, 3
    int     0x80
    jmp     display_alarm

motor_off:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, off_msg
    mov     edx, 4
    int     0x80

display_alarm:
    ; Display alarm status
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, alarm_msg
    mov     edx, 13
    int     0x80

    mov     al, [alarm_status]
    cmp     al, 1
    je      alarm_on
    jmp     alarm_off

alarm_on:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, on_msg
    mov     edx, 3
    int     0x80
    jmp     exit_program

alarm_off:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, off_msg
    mov     edx, 4
    int     0x80

exit_program:
    ; Exit the program
    mov     eax, 1
    xor     ebx, ebx
    int     0x80

; Subroutine: ASCII to Integer Conversion (atoi)
atoi:
    xor     eax, eax                ; Clear EAX (result)
    xor     ebx, ebx                ; Clear EBX (multiplier)
atoi_loop:
    mov     bl, byte [esi]          ; Load character from buffer
    cmp     bl, 10                  ; Check for newline
    je      atoi_done
    sub     bl, '0'                 ; Convert ASCII to digit
    imul    eax, eax, 10            ; Multiply result by 10
    add     eax, ebx                ; Add digit to result
    inc     esi                     ; Move to the next character
    jmp     atoi_loop
atoi_done:
    ret