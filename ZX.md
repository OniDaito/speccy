# 48K Spectrum

32 columns by 24 rows, implemented using a pixel resolution of 256 by 192 pixels

## General notes
Only certain register combos are allowed. Pages 44/45 of the 'mastering machine code' book describe the various combos of loading into a register, or two registers from a constant or memory location.

Registers like D, E (and the combined DE) are special. HL is too. A is special as well. You can't just use them in any combo it seems.

## Speccy Memory Map

Start 	End 	Length 	Description
#FF58 	#FFFF 	168 	Reserved
#5CCB 	#FF57 	41,612 	Free memory
#5CC0 	#5CCA 	11 	Reserved
#5C00 	#5CBF 	192 	System variables
#5B00 	#5BFF 	256 	Printer buffer
#5800 	#5AFF 	768 	Attributes
#4000 	#57FF 	6,144 	Pixel data
#0000 	#3FFF 	16,384 	Basic ROM 

## Addressing attributes

Addressing attributes is as easy as you would expect, starting at #5800 there are 32 attributes per screen row and 24 rows.
  	0 	1 	2 	3 	4 	5 	6 	7 	8 	9 	A 	B 	C 	D 	E 	F 	… 	1F
#5800 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
#5820 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
#5840 	  	  	  	X 	  	  	  	  	  	  	  	  	  	  	  	  	  	 
#5860 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
… 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
#5EAO 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 

To set the attributes for character (3, 2) assuming (0,0) is at the top left of the screen you write to address #5800 + ((2*32)+ 3) or #5843 (and X marks the spot).

## Attribute values

Each block of 8x8 pixels has a single byte of attribute data packed as follows
7 	6 	5 	4 	3 	2 	1 	0
F 	B 	P2 	P2 	P1 	I0 	I1 	I0

    Bit 7 if set indicates the colour flashes between the fore and back colours.
    Bit 6 if set indicates the colours are rendered bright.
    Bits 5 to 3 contain the paper (background) colour 0..7
    Bits 2 to 0 contain the ink (foreground) colour 0..7

The flash attribute alternates a cell between its foreground and background colours on a timer, it is of limited use in games.

The bright attribute makes the foreground and background colours, err…, brighter. The bright attribute nearly doubles the effective number of colours the spectrum could display. I say nearly because bright black is still black.

The colour value 0..7 is the index into the colour table, the colour values at those indexes and their bright equivalents are*:
Decimal 	Binary 	Colour 	Normal 	Bright
0 	000 	Black 		
1 	001 	Blue 		
2 	010 	Red 		
3 	011 	Magenta 		
4 	100 	Green 		
5 	101 	Cyan 		
6 	110 	Yellow 		
7 	111 	White 		


## ASM colour stuffs

screen_width_pixels:    .equ 256
screen_height_pixels:   .equ 192
screen_width_chars:     .equ 32
screen_height_chars:    .equ 24

screen_start:           .equ #4000
screen_size:            .equ screen_width_chars * screen_height_pixels
attr_start:             .equ #5800
attributes_length:      .equ screen_width_chars * screen_height_chars

black:                  .equ %000000
blue:                   .equ %000001
red:                    .equ %000010
magenta:                .equ %000011
green:                  .equ %000100
cyan:                   .equ %000101
yellow:                 .equ %000110
white:                  .equ %000111

pBlack:                 .equ black << 3
pBlue:                  .equ blue  << 3
pRed:                   .equ red  << 3
pMagenta:               .equ magenta  << 3
pGreen:                 .equ green  << 3
pCyan:                  .equ cyan  << 3
pYellow:                .equ yellow  << 3
pWhite:                 .equ white  << 3
            
bright:                 .equ %1000000


The cls_attributes sub-routine is used to set all attributes for the screen to the same value

; 
; IN  - A contains the attribute value to initialize the screen to
; OUT - Trashes HL, DE, BC
;
 cls_attributes:        
        ld hl, attr_start               ; start at attribute start
        ld de, attr_start + 1           ; copy to next address in attributes
        ld bc, attributes_length - 1    ; 'loop' attribute size minus 1 times
        ld (hl), a                      ; initialize the first attribute
        ldir                            ; fill the attributes
        ret

Using the cls_attributes method is as simple as:

        ld a, pBlue | yellow | bright
        call cls_attributes


## Screen addressing

Pixel location

15	14	13	12	11	10	9	8	7	6	5 	4	3	2	1	0
0 	1 	0 	Y7 	Y6 	Y2	Y1	Y0 	Y5	Y4	Y3 	X4 	X3 	X2 	X1 	X0


### ASM to find memory from co-ords B and C
ld a,b 	; Work on the upper byte of the address
and %00000111 	; a = Y2 Y1 y0
or %01000000 		; first three bits are always 010
ld h,a 	; store in h
ld a,b 		; get bits Y7, Y6
rra 		; move them into place
rra 		;
rra 		;
and %00011000 		; mask off
or h 		; a = 0 1 0 Y7 Y6 Y2 Y1 Y0
ld h,a 		; calculation of h is now complete
ld a,b 		; get y
rla 		;
rla 		;
and %11100000 		; a = y5 y4 y3 0 0 0 0 0
ld l,a 		; store in l
ld a,c 		;
and %00011111 		; a = X4 X3 X2 X1
or l 		; a = Y5 Y4 Y3 X4 X3 X2 X1
ld l,a 		; calculation of l is complete
ret 		

### ASM to generate lookups (faster but more mem)

The code to perform our address translation (remember B is the Y coordinate and C the character X) becomes:

ld h, 0 	 	
ld l, b 	 	; hl = Y
add hl, hl 	 	; hl = Y * 2
ld de, screen_map 	 	; de = screen_map
add hl, de 	 	; hl = screen_map + (row * 2)
ld a, (hl) 	 	; implements ld hl, (hl)
inc hl  	
ld h, (hl) 	 	
ld l, a 	 	; hl = address of first pixel from screen_map
ld d, 0 	 	
ld e, c 	 	; de = X
add hl, de 	 	; add the char X offset
ret 	 	; return screen_map[Y*2] + X
 
screen_map: .defw #4000, #4100, #4200, #4300, #4400, #4500, #4600, #4700, #4020, #4120, #4220, #4320 