;;;
;;; Kernel.asm: basic 'kernel' loaded from our bootsector
;;;
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
    mov si, testString
    call print_string           ; call and return

    hlt                         ; halt the cpu

    ;; included files
    include 'print_string.asm'

    ;; Data
testString: db 'Kernel Booted, Welcome to OS', 0xA, 0xD, 0        ; null terminated string

    ;; sector padding magic
    times 510-($-$$) db 0
