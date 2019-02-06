;==============================================================================
;
;  Test songs
;
;==============================================================================

	.import speakertest_pat
	.export testsong
	.export test_temposeq
	.export test_presets
	
	.include "song.inc"
	
	.segment "BANK0"
	
;==============================================================================

; r10 = speed
; r12 = set to 1 to automatically restart

.proc testsong
	VOICE	$00,$01,$02,$03,$04,$05,$06,$07
	INIT	100,___,___,___,___,___,___,___
	; silence immediately when track ends
	CUTOFF	001,___,___,___,___,___,___,___
	TVOL	20
	TEMPO	64
	SPEED	2
restart:
	WAVE	r00,___,___,___,___,___,___,___
	VOL		r09,___,___,___,___,___,___,___
	ENV		r01,___,___,___,___,___,___,___
	TRS		r02,___,___,___,___,___,___,___
	DTN		r03,___,___,___,___,___,___,___
	PIT		r04,___,___,___,___,___,___,___
	LFO		r05,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___	; reset panning
	JEQ		r06,0,nopanenv					; setting pan envelope to 0 does not
	PANENV	r06,___,___,___,___,___,___,___ ; turn off the pan envelope!
nopanenv:
	GTM		r08,___,___,___,___,___,___,___ ; set this to >1 to test env decay
	VOL		r09,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___ ; 0

	SET		r11,$1000
loop:
	REST	1
	SUB		r11,r10
	JCC		loop
	JEQ		r12,0,restart
	RET
.endproc

;==============================================================================

.proc test_temposeq
	INIT	100,___,___,___,___,___,___,___
	TVOL		40
	TEMPO		64
	TEMPOSEQ	{24,23,22,21}
	WAVE	000,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	ENV		000,___,___,___,___,___,___,___
	CALL	speakertest_pat
	TEMPOSEQ	{12,24,<-1}
	CALL	speakertest_pat
	RET

.endproc

;==============================================================================

; PRESET definitions:
; 1: preset number
; 2: wave select,
; 3: volume
; 4: X position / pan
; 5: detune
; 6: base note
; 7: volume envelope
; 8: pitch envelope
; 9: note delay
;10: gate time
;11: sample offset
;12: transpose
;13: lfo
;14: portamento
;15: Y position / pan mode
;16: pitch register (0=disable)
.proc test_presets
	INIT	100,___,___,___,___,___,___,___
	TVOL		40
	TEMPO		128
	SPEED		48
 	
	PRESET	1,000,0,-20, 0,0,0,0,0, 0,0,  0,0, 0,0,0 ; PosX = -20
	PRESET	2,001,0,  0,10,0,0,0,0, 0,0,  0,0, 0,0,0 ; Wave=1, Detune=10
	PRESET	3,002,0,  0, 0,0,1,3,0, 0,0,  0,0, 0,0,0 ; Env=1, Pitch env=3
	PRESET	4,003,0,  0, 0,0,0,0,0,10,0,  0,0, 0,0,0 ; Gate time=10
	PRESET	5,004,0,  0, 0,0,0,0,0, 0,0,-12,0, 0,0,0 ; Transpose=-12
	PRESET	6,005,0,  0, 0,0,0,0,0, 0,0,  0,1, 0,0,0 ; LFO=1
	PRESET	7,006,0,  0, 0,0,0,0,0, 0,0,  0,0,20,0,0 ; Portamento=1
	PRESET	8,007,0, 20, 0,0,0,0,0, 0,0,  0,0, 0,127,0 ; Pan = 20
	
	WAVE	000,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	ENV		000,___,___,___,___,___,___,___
	PSTMAP  001,___,___,___,___,___,___,___
	CALL	speakertest_pat
	RET

.endproc


;==============================================================================

.if	0
	.export voice_test1
.proc voice_test1

	VOICE	030,___,___,___,___,___,___,___
	INIT	250,___,___,___,___,___,___,___
	TVOL	25
	TEMPO	128
	SPEED	14*6	; 1.4 sec

	WAVE	250,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	
	WAVE	256,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	RET
.endproc

	.export voice_test2
.proc voice_test2

	VOICE	030,___,___,___,___,___,___,___
	INIT	250,___,___,___,___,___,___,___
	TVOL	25
	TEMPO	128
	SPEED	19*6	; 1.9 sec

	WAVE	251,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	
	WAVE	257,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	RET
.endproc

	.export voice_test3
.proc voice_test3

	VOICE	030,___,___,___,___,___,___,___
	INIT	250,___,___,___,___,___,___,___
	TVOL	25
	TEMPO	128
	SPEED	14*6	; 1.4 sec

	WAVE	252,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	
	WAVE	258,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	PAN		000,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	RET
.endproc

.endif