; A bitmap test program
org $8000

include "./lib/constants.asm"

start
    ld a, black | white | bright
    call cls_attributes
    ld de, 0x4000 ; load de with our first line position
    call draw_bitmap
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
include "./lib/draw_bitmap.asm"
include "./images/you.asm"