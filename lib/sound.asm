; https://chuntey.wordpress.com/2013/02/28/how-to-write-zx-spectrum-games-chapter-3/
; Frequency of G sharp in octave of middle C = 415.30
; Frequency of G sharp one octave higher = 830.60
; Duration = 830.6 / 4 = 207.65
; Pitch = 437500 / 830.6 - 30.125 = 496.6

; DE = Duration = Frequency * Seconds
; HL = Pitch = 437500 / Frequency – 30.125

; Middle C 261.63
; C# 277.18
; D 293.66
; D# 311.13
; E 329.63
; F 349.23
; F# 369.99
; G 392.00
; G# 415.30
; A 440.00
; A# 466.16
; B 493.88

; For each octave higher, simply double the frequency, to go an octave lower halve it.
; For example, to produce a note C one octave higher than middle C we take the value
; for Middle C – 261.63, and double it to 523.26.

; Defines for notes

; Notes for Octave 0
noteC0:     equ 3314
noteCS0:    equ 3126
noteD0:     equ 2950
noteDS0:    equ 2782
noteE0:     equ 2624
noteF0:     equ 2475
noteFS0:    equ 2335
noteG0:     equ 2202
noteGS0:    equ 2077
noteA0:     equ 1959
noteAS0:    equ 1847
noteB0:     equ 1741

; Split notes for loading into memory
noteC0A:     equ 0xC
noteC0B:     equ 0xF2
noteCS0A:    equ 0xC
noteCS0B:    equ 0x36
noteD0A:     equ 0xB
noteD0B:     equ 0x86
noteDS0A:    equ 0xA
noteDS0B:    equ 0xDE
noteE0A:     equ 0xA
noteE0B:     equ 0x40
noteF0A:     equ 0x9
noteF0B:     equ 0xAB
noteFS0A:    equ 0x9
noteFS0B:    equ 0x1F
noteG0A:     equ 0x8
noteG0B:     equ 0x9A
noteGS0A:    equ 0x8
noteGS0B:    equ 0x1D
noteA0A:     equ 0x7
noteA0B:     equ 0xA7
noteAS0A:    equ 0x7
noteAS0B:    equ 0x37
noteB0A:     equ 0x6
noteB0B:     equ 0xD3

; Quarter of a second per half note

noteC0DH:    equ 33
noteCS0DH:   equ 35
noteD0DH:    equ 37
noteDS0DH:   equ 39
noteE0DH:    equ 41
noteF0DH:    equ 44
noteFS0DH:   equ 46
noteG0DH:    equ 49
noteGS0DH:   equ 52
noteA0DH:    equ 55
noteAS0DH:   equ 58
noteB0DH:    equ 62

; Eigth of a second per quarter note

noteC0DQ:    equ 16
noteCS0DQ:   equ 17
noteD0DQ:    equ 18
noteDS0DQ:   equ 19
noteE0DQ:    equ 21
noteF0DQ:    equ 22
noteFS0DQ:   equ 23
noteG0DQ:    equ 25
noteGS0DQ:   equ 26
noteA0DQ:    equ 28
noteAS0DQ:   equ 29
noteB0DQ:    equ 31

; Notes for Octave 1
noteC1:     equ 1642
noteCS1:    equ 1548
noteD1:     equ 1460
noteDS1:    equ 1376
noteE1:     equ 1297
noteF1:     equ 1223
noteFS1:    equ 1152
noteG1:     equ 1086
noteGS1:    equ 1023
noteA1:     equ 964
noteAS1:    equ 908
noteB1:     equ 855

; Split notes for loading into memory
noteC1A:     equ 0x6
noteC1B:     equ 0x6A
noteCS1A:    equ 0x6
noteCS1B:    equ 0xC
noteD1A:     equ 0x5
noteD1B:     equ 0xB4
noteDS1A:    equ 0x5
noteDS1B:    equ 0x60
noteE1A:     equ 0x5
noteE1B:     equ 0x11
noteF1A:     equ 0x4
noteF1B:     equ 0xC7
noteFS1A:    equ 0x4
noteFS1B:    equ 0x80
noteG1A:     equ 0x4
noteG1B:     equ 0x3E
noteGS1A:    equ 0x3
noteGS1B:    equ 0xFF
noteA1A:     equ 0x3
noteA1B:     equ 0xC4
noteAS1A:    equ 0x3
noteAS1B:    equ 0x8C
noteB1A:     equ 0x3
noteB1B:     equ 0x57

; Quarter of a second per half note

noteC1DH:    equ 65
noteCS1DH:   equ 69
noteD1DH:    equ 73
noteDS1DH:   equ 78
noteE1DH:    equ 82
noteF1DH:    equ 87
noteFS1DH:   equ 92
noteG1DH:    equ 98
noteGS1DH:   equ 104
noteA1DH:    equ 110
noteAS1DH:   equ 117
noteB1DH:    equ 123

; Eigth of a second per quarter note

noteC1DQ:    equ 33
noteCS1DQ:   equ 35
noteD1DQ:    equ 37
noteDS1DQ:   equ 39
noteE1DQ:    equ 41
noteF1DQ:    equ 44
noteFS1DQ:   equ 46
noteG1DQ:    equ 49
noteGS1DQ:   equ 52
noteA1DQ:    equ 55
noteAS1DQ:   equ 58
noteB1DQ:    equ 62
