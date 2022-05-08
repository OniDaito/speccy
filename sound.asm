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

; Play a set of notes from memory
play_song:
	; Set hl to be the address of the start of the song
	; Save this address in song address
	ld hl, song_notes
	ld (song_address), hl
play_song_loop:
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
	; store hl back into song address
	inc hl
	ld (song_address), hl
	
	ld hl, (song_current_note)
	ld de, (song_current_duration) ;(song_address_duration)
	call 949

	; Progress song counter
	ld a,(song_length) 
	sub 1
	ld (song_length), a
	cp 0
	jr nz, play_song_loop
	ret

song_length: ; one less than the total number
	defb	44
song_address:
	defb 0, 0
song_current_note:
	defb 0, 0
song_current_duration:
	defb 0, 0
song_notes: ; Song is note low byte, note high byte, duration
	defb	noteC0B, noteC0A, noteC0DH
	defb	noteCS0B, noteCS0A, noteCS0DH
	defb	noteD0B, noteD0A, noteD0DH
	defb	noteDS0B, noteDS0A, noteDS0DH
	defb	noteE0B, noteE0A, noteE0DH
	defb	noteF0B, noteF0A, noteF0DH
	defb	noteFS0B, noteFS0A, noteFS0DH
	defb	noteG0B, noteG0A, noteG0DH
	defb	noteGS0B, noteGS0A, noteGS0DH
	defb	noteA0B, noteA0A, noteA0DH
	defb	noteAS0B, noteAS0A, noteAS0DH
	defb	noteB0B, noteB0A, noteB0DH
	defb	noteC0B, noteC0A, noteC0DQ
	defb	noteCS0B, noteCS0A, noteCS0DQ
	defb	noteD0B, noteD0A, noteD0DQ
	defb	noteDS0B, noteDS0A, noteDS0DQ
	defb	noteE0B, noteE0A, noteE0DQ
	defb	noteF0B, noteF0A, noteF0DQ
	defb	noteFS0B, noteFS0A, noteFS0DQ
	defb	noteG0B, noteG0A, noteG0DQ
	defb	noteGS0B, noteGS0A, noteGS0DQ
	defb	noteA0B, noteA0A, noteA0DQ
	defb	noteAS0B, noteAS0A, noteAS0DQ
	defb	noteB0B, noteB0A, noteB0DQ
	defb	noteC1B, noteC1A, noteC1DH
	defb	noteCS1B, noteCS1A, noteCS1DH
	defb	noteD1B, noteD1A, noteD1DH
	defb	noteDS1B, noteDS1A, noteDS1DH
	defb	noteE1B, noteE1A, noteE1DH
	defb	noteF1B, noteF1A, noteF1DH
	defb	noteFS1B, noteFS1A, noteFS1DH
	defb	noteG1B, noteG1A, noteG1DH
	defb	noteGS1B, noteGS1A, noteGS1DH
	defb	noteA1B, noteA1A, noteA1DH
	defb	noteAS1B, noteAS1A, noteAS1DH
	defb	noteB1B, noteB1A, noteB1DH
	defb	noteC1B, noteC1A, noteC1DQ
	defb	noteCS1B, noteCS1A, noteCS1DQ
	defb	noteD1B, noteD1A, noteD1DQ
	defb	noteDS1B, noteDS1A, noteDS1DQ
	defb	noteE1B, noteE1A, noteE1DQ
	defb	noteF1B, noteF1A, noteF1DQ
	defb	noteFS1B, noteFS1A, noteFS1DQ
	defb	noteG1B, noteG1A, noteG1DQ
	defb	noteGS1B, noteGS1A, noteGS1DQ
	defb	noteA1B, noteA1A, noteA1DQ
	defb	noteAS1B, noteAS1A, noteAS1DQ
	defb	noteB1B, noteB1A, noteB1DQ