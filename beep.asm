; Laser Beep!

org $8000

	di
	ld d,#28
loop:
	add hl,de
	dec de
	ld a,h
	out (#fe),a
	ld a,e
	or d
	jr nz,loop
	
	ei
	ret