  Org &8000

PrintChar:
  push hl
  push bc
  push de
  push af
    ld a,2
    call &1601
  pop af
  push af
    rst 16
  pop af
  pop de
  pop bc
  pop hl
  ret

PrintString:
  ld a,(hl)
  cp 255
  ret z
  inc hl
  call PrintChar
  jr PrintString

Message: db 'Hello World 323', 255

  ld hl,Message
  Call PrintString

  ret
