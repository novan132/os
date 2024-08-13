;;;
;;; print characters from register bx
;;;

print_string:
    pusha                       ; push registers to stack
    mov ah, 0x0e

print_char:
    mov al, [bx]                ; move character value at address bx
    cmp al, 0                    
    je end_print                ; jmp if equal (al = 0) to end_print label
    int 0x10                    ; print character
    add bx, 1                   ; move 1 byte forward
    jmp print_char              ; loop

end_print:
    popa                        ; return registers from stack before returning
    ret
