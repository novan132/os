;;;
;;; Print hexamdecimal values using register DX and print_string.asm
;;;
;;; Ascii '0' - '9' = hex 0x30 - 0x39
;;; Ascii 'A' - 'F' = hex 0x41 - 0x46
;;; Ascii 'a' - 'f' = hex 0x61 - 0x66
;;;
print_hex:
    pusha                   ; save all registers to stack
    mov cx, 0               ; initialize loop counter

hex_loop:
    cmp cx, 4               ; are we at the end of loop?
    je end_hexloop

    ;; Conver DX hex values to ascii
    mov ax, dx           
    and ax, 0x000F          ; turn first 3 hex to 0, keep final digit to convert
    add al, 0x30            ; convert to ascii
    cmp al, 0x39            ; is hex value 0-9 (<= 0x39) or A-F (> 39)
    jle move_intoBX
    add al, 0x7             ; to get ascii 'A' - 'F'

    ;; Move ascii char into bx string
move_intoBX:
    mov bx, hexString + 5   ; base address of hexString + length of string
    sub bx, cx              ; substract loop counter
    mov [bx], al
    ror dx, 4               ; rotate right by 4 bits,
                            ; 0x12AB -> 0xB12A -> 0xAB12 -> 0x2AB1 -> 0x12AB

    add cx, 1               ; increment counter
    jmp hex_loop            ; loop for next hex digit


end_hexloop:
    mov bx, hexString
    call print_string

    popa
    ret

    ;; Data
hexString: db '0x0000', 0

