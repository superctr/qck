;==============================================================================
;
;  Quattro Creation Kit
;
;  Panning envelopes
;
;==============================================================================

; Pan envelopes are used to create panning effects....

; Pan values in Quattro are signed 8-bit bytes.

; The range is as follows.
;    0-32 = Center -> Front Right
;   32-63 = Front Right -> Right
;   64-95 = Right -> Rear Right
;  96-127 = Rear Right -> Rear Center
; (negative bytes for left speaker)

; Two bytes are read at the beginning of the pan envelope
; The first byte specifies delay. If this is -1 (assembler syntax <-1), then
;  this specifies a continuous envelope; that means it will not be reset by
;   new notes. (You can still force a reset using commands)
; Second byte is the initial panning value. See above for a reference...

; Commands:
; STOP: stops the envelope
; CONT: Continues to the next envelope and sets new loop position (just
;  like pitch envelopes, this doesn't necessarily mean the next envelope ID)
; LOOP: jumps to the first node of the envelope, without reading the initial
;  value.
; NEXT: Continues to the next envelope ID, also reads new initial value and
;  delay.
; REST: Sets panning to the initial value and jumps to the first node of the
;  envelope.

; Volume envelope structure (each node highlighted):
;        Continuous mode     Delta       Reset
;        |    Initial value  |    Target |
;        |    |              |    |      |
;  .byt  <-1, <-32, 35, 32, <-35, <-32, REST
;                   ^^^^^^  ^^^^^^^^^^

STOP = $80
CONT = $81
LOOP = $82
NEXT = $83
REST = $84
