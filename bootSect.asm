;;;
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

    ;; tele-type output strings
    mov bx, testString

    call print_string           ; call and return
    mov bx, string2
    call print_string

    ;; halt
    hlt                         ; halt the cpu

    include 'print_string.asm'

    ;; variables
testString: db 'Test string', 0xA, 0xD, 0        ; null terminated string
string2: db 'Hex string: 0x12AB', 0

    times 510-($-$$) db 0

    dw 0xaa55                   ; BIOS magic number 
