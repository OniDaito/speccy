image_width:
    defb 0
image_height:
    defb 0
image_x:
    defb 0
image_y:
    defb 0
image_offx:
    defb 0
image_offy:
    defb 0
draw_set_pos:
    ; Call this first to set DE to the correct drawing position.
    ; TODO could be a bug here if offx is 0 to begin with
    ld a, (image_offx)
loop_offx:
    inc de
    sub 1
    cp 0
    jr nz, loop_offx
    ld a, (image_offy)
    ; Now loop through the y offset
    ; upde uses the accumulator so we must be a bit more clever with offy loop
    ; TODO we always go one line down first. Naughty but easier :/
loop_offy:
    push af
    call upde
    pop af
    sub 1
    cp 0
    jr nz, loop_offy
    ret
draw_bitmap:
    ; Now we have our final start position in de so push it
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