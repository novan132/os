;;;
;;; print characters from register si
;;;

print_string:
    pusha                       ; push registers to stack
    mov ah, 0x0e

print_char:
    mov al, [si]                ; move character value at address si
    cmp al, 0                    
    je end_print                ; jmp if equal (al = 0) to end_print label
    int 0x10                    ; print character
    add si, 1                   ; move 1 byte forward
    jmp print_char              ; loop

end_print:
    popa                        ; return registers from stack before returning
    ret
