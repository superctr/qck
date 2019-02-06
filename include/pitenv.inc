;==============================================================================
;
;  Quattro Creation Kit
;
;  Pitch envelopes
;
;==============================================================================

; Three bytes are always read at the beginning of the pitch envelope.
; First byte sets the envelope speed. Can be calculated as 120*(speed/256) Hz.
; Second byte sets the depth.
; The rest defines the pitch sequence. Notice that the zero point is 100.
; The value of each step can be calculated as 50*(depth/256)*(step-100) cents.
; You can use the program 'pitenv.c' to calculate pitch envelopes.

; Three commands exist:
; CONT: This commands sets the loop position, and reads new speed and depth
;  values. You can see it as it "continues" to the next envelope, although it
;  does not care about the order of envelopes in the ID table.
; LOOP: Loops back to the start position, or the loop position if defined with
;  the CONT command.
; STOP: Stops the pitch envelope, the last value read will still affect the
;  sample frequency.

;      Speed
;      |   Depth
;      |   |    Pitch sequence...
;      |   |    |    |    |    |
; .byt 70, 150, 100, 101, 100, 99, LOOP

CONT = $fd
LOOP = $fe
STOP = $ff


; Helper defines for tracker-style arpeggios
ARP = 64 ; <- set this as Depth value
U0  = 100
U1  = 108
U2  = 116
U3  = 124
U4  = 132
U5  = 140
U6  = 148
U7  = 156
U8  = 164
U9  = 172
U10 = 180
U11 = 188
U12 = 196
U13 = 204
U14 = 212
U15 = 220
U16 = 228
D0  = 100
D1  = 92
D2  = 84
D3  = 76
D4  = 68
D5  = 60
D6  = 52
D7  = 44
D8  = 36
D9  = 28
D10 = 20
D11 = 12
D12 = 4

