; Handy defines
screen_width_pixels:    equ 256
screen_height_pixels:   equ 192
screen_width_chars:     equ 32
screen_height_chars:    equ 24

screen_start:           equ #4000
screen_size:            equ screen_width_chars * screen_height_pixels
attr_start:             equ #5800
attributes_length:      equ screen_width_chars * screen_height_chars

black:                  equ %000000
blue:                   equ %000001
red:                    equ %000010
magenta:                equ %000011
green:                  equ %000100
cyan:                   equ %000101
yellow:                 equ %000110
white:                  equ %000111

pBlack:                 equ black << 3
pBlue:                  equ blue  << 3
pRed:                   equ red  << 3
pMagenta:               equ magenta  << 3
pGreen:                 equ green  << 3
pCyan:                  equ cyan  << 3
pYellow:                equ yellow  << 3
pWhite:                 equ white  << 3
            
bright:                 equ %1000000