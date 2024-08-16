;;;
;;; Simple boot loader use INT13 AH2 to read from disk into memory
;;;
    org 0x7c00                  ; 'origin'

    ;; setup ES:BX memory address/segment:offset to load sector(s) into
    mov bx, 0x1000              ; load sector to memory addres 0x1000
    mov es, bx
    mov bx, 0x0                 ; memory address 0x1000:0x0

    ;; set up disk read
    mov dh, 0x0                     ; head 0
    mov dl, 0x0                     ; drive 0
    mov ch, 0x0                     ; cylinder 0
    mov cl, 0x02

read_disk:
    mov ah, 0x02                    ; int 13/ah=02h, BIOS read disk sectors into memory
    mov al, 0x01                    ; number of sectors we want to read ex. 1
    int 0x13                        ; BIOS interrupt for disk functions

    jc read_disk                    ; retry if disk read error (carry flag set to 1)

    ;; reset segment register for RAM
    mov ax, 0x1000
    mov ds, ax                      ; data segment
    mov es, ax                      ; extra segment
    mov fs, ax                      ; -
    mov gs, ax                      ; -
    mov ss, ax                      ; stack segment

    jmp 0x1000:0x0

    ;; variables

    ;; Boot sector magic
    times 510-($-$$) db 0

    dw 0xaa55                   ; BIOS magic number 
