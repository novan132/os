;;;
;;; Disk_Load: Read DH sectors into ES:BX memory localtion from drive DL
;;;

disk_load:
    push dx                         ; store DX on stack so we can check number of sectors actually read

    mov ah, 0x02                    ; int 13/ah=02h, BIOS read disk sectors into memory
    mov al, dh                      ; number of sectors we want to read ex. 1
    mov ch, 0x00                    ; cylinder 0
    mov dh, 0x00                    ; head 0
    mov cl, 0x02                    ; start reading at CL sector (sector 2 in this case, right after boot sector)

    int 0x13                        ; BIOS interrupt for disk functions

    jc disk_load                    ; retry if disk read error (carry flag set to 1)

    pop dx                          ; restore DX from the stack
    cmp dh, al                      ; if AL (# sectors actually read)  != DH (# sectors we wanted to read)
    jne disk_error                  ; errors, sectors read not equal to number we wanted to read
    ret                             ; return to caller

    ;; reset segment register for RAM
    mov ax, 0x1000
    mov ds, ax                      ; data segment

disk_error:
    mov si, DISK_ERROR_MSG
    call print_string
    hlt

    ;; Data
DISK_ERROR_MSG: db 'Disk read error!!!', 0

