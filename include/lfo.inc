;==============================================================================
;
;  Quattro Creation Kit
;
;  LFO presets
;
;==============================================================================

; Depth = (depth/128)*1200 cents 

;      Waveform select
;      |     Delay
;      |     |  Initial freq
;      |     |   |   Initial depth
;      |     |   |   |  Target freq
;      |     |   |   |  |   Target depth
;      |     |   |   |  |   |  Freq delta
;      |     |   |   |  |   |  |    Depth delta
;      |     |   |   |  |   |  |    |
; .byt SINE, 30, 27, 0, 27, 3, 127, 30

; Available waveforms
SINE      = $00 ; sine wave
TRIANGLE  = $01 ; trangle
SQUARE    = $02 ; square
SQUARE_P  = $03 ; square (positive bias)
SQUARE_N  = $04 ; square (negative bias)
SAW_P     = $05 ; sawtooth (positive bias)
SAW_N     = $06 ; sawtooth (negative bias)
RSAW_P    = $07 ; reverse sawtooth (positive bias)
RSAW_N    = $08 ; reverse sawtooth (negative bias)
MODSQUARE = $09 ; modulated square wave
TRISQUARE = $0a ; combined triangle + square
SAW       = $0c ; sawtooth
RANDOMTRI = $0d ; random amplitude triangle
RANDOM    = $0e
RANDOM2   = $0f
