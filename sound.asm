	org $8000

include "./lib/sound.asm"

	call play_song
	ret
; Basic tone
basic:
	ld hl,noteC1        ; pitch.
	ld de,noteC1DH      ; duration.
	call 949            ; ROM beeper routine.
	ret

bend:
	ld hl,noteGS1           ; starting pitch.
    ld b,500            ; length of pitch bend.
bend_loop:  
	push bc
	push hl             ; store pitch.
	ld de,1             ; very short duration.
	call 949            ; ROM beeper routine.
	pop hl              ; restore pitch.
	inc hl              ; pitch going up.
	pop bc
	djnz bend_loop           ; repeat.
	;ret

noise:
  	ld e,250            ; repeat 250 times.
    ld hl,0             ; start pointer in ROM.
noise2:
	push de
    ld b,32             ; length of step.
noise0:
 	push bc
    ld a,(hl)           ; next "random" number.
    inc hl              ; pointer.
    and 248             ; we want a black border.
    out (254),a         ; write to speaker.
    ld a,e              ; as e gets smaller...
    cpl                 ; ...we increase the delay.
noise1:
	dec a               ; decrement loop counter.
    jr nz,noise1        ; delay loop.
    pop bc
    djnz noise0         ; next step.
    pop de
    ld a,e
    sub 24              ; size of step.
    cp 30               ; end of range.
    ret z
    ret c
    ld e,a
    cpl
noise3:
	ld b,40             ; silent period.
noise4:
	djnz noise4
    dec a
    jr nz,noise3
    jr noise2

play_song:
	ld hl, song_notes
	ld (song_address), hl

	; Load the first note into the two bytes
	ld hl,(song_address)
	ld a,(hl)
	ld (song_current_note), a
	
	; Second note byte
	inc hl
	ld a, (hl)
	ld (song_current_note+1), a

	; Load the duration two bytes
	inc hl
	ld a, (hl)
	ld (song_current_duration), a
	ld a, 0
	ld (song_current_duration+1), a
	
play_song_loop:
	ld hl, (song_current_note)
	ld de, (song_current_duration) ;(song_address_duration)
	call 949

	; Now advance
	; Load the first note into the two bytes
	inc hl
	ld a,(hl)
	ld (song_current_note), a
	
	; Second note byte
	inc hl
	ld a, (hl)
	ld (song_current_note+1), a

	; Load the duration two bytes
	inc hl
	ld a, (hl)
	ld (song_current_duration), a
	ld a, 0
	ld (song_current_duration+1), a

	; Progress song counter
	ld a,(song_length) 
	sub 1
	ld (song_length), a
	cp 0
	jr nz, play_song_loop
	ret

song_length:
	defb	2
song_address:
	defb 0, 0
song_current_note:
	defb 0, 0
song_current_duration:
	defb 0, 0
song_notes: ; Song is note low byte, note high byte, duration
	defb	noteC1B, noteC1A, noteC1DH, noteD1A, noteD1B, noteD1DH 