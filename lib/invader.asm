draw_invader:
    ; using some pop and ret magic we read the bytes that are data immediately following
    ; this little function - p82 of machine language speccy book
    ; Or posibly better, copying our hello-world asm
    ld bc, invader

loop_invader
    ld a, (bc)
    cp 0
    ret z ; if compare to 0 happened, we return
    ld (de), a
    push bc
    call upde
    pop bc
    inc bc
    jr loop_invader
    ret

invader:
    defb 24, 60, 126, 219, 255, 90, 129, 68, 00
    ret
    
draw_invader_old:
    ld a, 24
    ld (de), a
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
