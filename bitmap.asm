; A bitmap test program
org $8000

include "./lib/constants.asm"

start
    ld a, black | white | bright
    ; call cls_attributes
    call draw_invader

test
    ld hl, 0x4000     ; Screen memory load into hl
    ld (hl), 0xff     ; load ff into screen mem
    ld de, 0x4001     ; load the next byte address of screen mem into de
    ld bc, 31         ; something something 1 byte copy
    ldir              ; something copy byte in hl to de's location
    ret

; This sets attributes for the whole screen
; looks like this ldir bc de trick copies a value multiple times.
cls_attributes:        
    ld hl, attr_start               ; start at attribute start
    ld de, attr_start + 1           ; copy to next address in attributes
    ld bc, attributes_length - 1    ; 'loop' attribute size minus 1 times
    ld (hl), a                      ; initialize the first attribute
    ldir                            ; fill the attributes
    ret


include "./lib/upde.asm"

draw_invader:
    ld hl, 0x4000
    ld (hl), 24
    ld de, 0x4000
    call upde
    ld a, 60
    ld (de), a
    call upde
    ld a, 126
    ld (de), a
    call upde
    ld a, 219
    ld (de), a
    call upde
    ld a, 255
    ld (de), a
    call upde
    ld a, 90
    ld (de), a
    call upde
    ld a, 129
    ld (de), a
    call upde
    ld a, 68
    ld (de), a
    
