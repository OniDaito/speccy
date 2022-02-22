image_width:
    defb 0
image_height:
    defb 0
image_x:
    defb 0
image_y:
    defb 0
draw_bitmap:
    ; We need to do two things. One, figure out when to move to the next line and 
    ; two, when to stop drawing fully. We will need two counters I expect
    push de
loop_draw_bitmap:
    ; read the x pos and subtract. Call next line if needed
    ld a, (image_x)
    sub 1
    cp 0
    jr z, next_line
    ; write the xpos back to memory
    ld (image_x), a
    ; Now draw the next block of 8 pixels
    ld a, (bc)
    ld (de), a
    inc bc
    inc de
    jr loop_draw_bitmap
next_line:
    ; take the saved width and reset the x counter
    pop de
    ld a, (image_width)
    ld (image_x), a
    ; Now check that y isn't 0
    ld a, (image_y)
    sub 1
    cp 0
    ret z
    ; Write new Y-pos back to memory
    ld (image_y), a
    ; Find the next line down
    push bc
    call upde
    pop bc
    inc bc
    push de
    jr loop_draw_bitmap