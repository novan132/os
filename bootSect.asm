;;; basic boot sector print characters using BIOS interrupts
;;;
    org 0x7c00                  ; 'origin'

    ;; set video mode
    mov ah, 0x00                ; int 0x10/ ah 0x00 - set video mode
    mov al, 0x03                ; 40x25 text mode
    int 0x10

    ;; change color/pallete
    mov ah, 0x0B
    mov bh, 0x00
    mov bl, 0x01
    int 0x10

    mov ah, 0x0e                ; BIOS teletype ouput
    mov bx, testString

    call print_string           ; call and return
    mov bx, string2
    call print_string
    jmp end_pgm                 ; finish print

print_string:
    mov al, [bx]                ; move character value at address bx
    cmp al, 0                    
    je end_print                ; jmp if equal (al = 0) to end_print label
    int 0x10                    ; print character
    add bx, 1                   ; move 1 byte forward
    jmp print_string            ; loop

end_print:
    ret

    ;; variables
testString: db 'TEST', 0xA, 0xD, 0        ; null terminated string
string2: db 'also a test string', 0

end_pgm:
    jmp $                       ; jump repeatedly to here

    times 510-($-$$) db 0

    dw 0xaa55                   ; BIOS magic number 
