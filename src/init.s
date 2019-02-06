;==============================================================================
;
;  Song 000 (initialization)
;
;==============================================================================

	.export song000
	.export speakertest
	.export speakertest_pat
	.export emptysong
	
	.include "song.inc"
	
	.segment "BANK0"
	
.proc song000
	POKEW	$2400,$0e9f
	VOICNT	$20
	TRKCNT	$20
	
	VOICE	$00,$01,$02,$03,$04,$05,$06,$07	; voice select
	INIT	050,050,050,050,050,050,050,050	; allocate voices
	TVOL	000								; 0=loudest
	TEMPO	80
	SPEED	30
	LINK	___,001,001,001,001,001,001,001 ; link channels
	WAVE	015,015,015,015,015,015,015,015 ; waveform
	VOL		000,030,030,050,060,070,080,090 ; volume
	ENV		001,001,001,001,001,001,001,001 ; envelope
	PAN		+00,+63,-64,+00,+40,-40,-20,+20 ; pan
	DEL		000,006,012,024,036,048,072,096 ; delay
	_FRQ	___,___,___,___,___,___,___,___
	_FRQ	Cn5,___,___,___,___,___,___,___
	
	TEMPO	64
	SPEED	2
	
	; Here is an example of some code implemented inside Quattro...
	SET		r00,1			; point register 00 to register 1
l1:
	SET		r00i,1			; set the derefenced register to 1
	WAIT	1				; wait a little
	SET		r00i,0			; then set it to 0
	ADD		r00,1			; increase counter
	JEQ		r00,$40,l2		; branch if we reached $40
	WAIT	1
	JUMP	l1				; loop...
l2:
	SET		r00,0			; now clear this too
	MSG		"QCK Ver. 2017-02-07"	
	RET
.endproc

;==============================================================================

.proc speakertest
	VOICE	$00,$01,$02,$03,$04,$05,$06,$07
	INIT	100,___,___,___,___,___,___,___
	TVOL	40
	TEMPO	64
	SPEED	48
	WAVE	000,___,___,___,___,___,___,___
	VOL		000,___,___,___,___,___,___,___
	ENV		000,___,___,___,___,___,___,___
	
	MSG		"LEFT"
	SET		r00,1
	SET		r01,0
	PAN		-32,___,___,___,___,___,___,___
	CALL	speakertest_pat
	
	MSG		"RIGHT"
	SET		r00,0
	SET		r01,1
	PAN		+32,___,___,___,___,___,___,___
	CALL	speakertest_pat
	
	MSG		"CENTER"
	SET		r00,1
	SET		r01,1
	PAN		000,___,___,___,___,___,___,___
	CALL	speakertest_pat
	
	MSG		""
	RET
.endproc

.proc speakertest_pat
	_FRQ	Cn5,___,___,___,___,___,___,___ ; 0
	_FRQ	Dn5,___,___,___,___,___,___,___ ; 1
	_FRQ	En5,___,___,___,___,___,___,___ ; 2
	_FRQ	Fn5,___,___,___,___,___,___,___ ; 3
	_FRQ	Gn5,___,___,___,___,___,___,___ ; 4
	_FRQ	An5,___,___,___,___,___,___,___ ; 5
	_FRQ	Bn5,___,___,___,___,___,___,___ ; 6
	_FRQ	Cn6,___,___,___,___,___,___,___ ; 7
	RET
.endproc

;==============================================================================

.proc emptysong
	TVOL	255
	RET
.endproc
