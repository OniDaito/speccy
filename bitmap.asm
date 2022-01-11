; A bitmap test program
org $8000

ScreenInit:
ifndef ScrColour16
  ld a, 1
else
  ld a, 0
endif
call &BC0E

  ld de, &0010           ; Xpos in pixels
  ld hl, &00A0           ; Ypos in pixels

  call &BC1D            ; screen dot position

  ld de, TestSprite      ; Load the sprite
  ld b, 8                ; lines

SpriteNextLine:
  push hl
    ld a, (de)           ; Source byte
    ld (hl), a           ; Screen destination

    inc de              ; increment sprite address
    inc hl              ; increment screen address

    ld a, (de)
    ld (hl), a 

    inc de
    inc hl
  pop hl
  call &BC26            ; screen next line

  djnz SpriteNextLine

  ret

TestSprite:
    db %00110000,%11000000
    db %01110000,%11100000
    db %11110010,%11110100
    db %11110000,%11110000
    db %11110000,%11110000
    db %11010010,%10110100
    db %01100001,%01101000
    db %00110000,%11000000