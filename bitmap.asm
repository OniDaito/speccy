; A bitmap test program
org $8000

include "./lib/constants.asm"

start
    ld a, black | blue | bright
    call cls_attributes
    ; Set all the memory locations for drawing an image
    ld a, (image_horace_width)
    ld (image_width), a
    ld a, (image_horace_height)
    ld (image_height), a
    ld a, (image_horace_x)
    ld (image_x), a
    ld a, (image_horace_y)
    ld (image_y), a
    ld a, 8 ; offset in X in blocks
    ld (image_offx), a
    ld a, 55
    ld (image_offy), a ; offset in Y in lines
    ld de, 0x4000 ; load de with the screen memory positions first
    call draw_set_pos
    ld bc, image_horace ; load the bc with the image data
    ; Now make the call
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
include "./images/horace.asm"