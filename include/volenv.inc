;==============================================================================
;
;  Quattro Creation Kit
;
;  Volume envelopes
;
;==============================================================================

; Notice that in Quattro, volumes are actually attenuation values.
; Therefore, 0 is the loudest and 255 silence.
; The envelope normally starts with a level of 255 (silence).

; Each envelope node consists of two values.
; First byte sets the envelope rate, and the second byte sets the target level.

; Three commands exist:
; CHANGE: Changes to another envelope.
;  The next byte (normally Level) will contain the ID of the next envelope,
;  but notice that the ID starts from 0 and not 1 as usual.
; STOP: Stop the envelope and silence the voice.
; SUST: Starts a sustain phase. You can have more than one of these in an
;  envelope, but then you will have to trigger a Key Off for each sustain
;  point in your envelope.

; Volume envelope structure (each node highlighted):
;       Initial rate (initial level is 255)      Rate
;       |   Target level                         |   Target level
;       |   |                                    |   |
; .byt 125, 0, 90, 30, 30, 200, SUST, 125, 170,  40, 255, STOP
;      ^^^^^^  ^^^^^^  ^^^^^^^        ^^^^^^^^   ^^^^^^^

SUST = $fe
STOP = $ff
MUTE = $ff ; you can use this too
CHANGE = 0
