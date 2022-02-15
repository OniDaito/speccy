; A bitmap test program
org $8000

include "./lib/constants.asm"

start
    ld a, black | red | bright
    call cls_attributes
    ld de, 0x4000 ; load de with our first line position
    call draw_invader
    ret

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
include "./lib/invader.asm"