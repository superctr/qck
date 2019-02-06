;==============================================================================
;
;  Trademark Infringement theme
;
;==============================================================================

; resources:
; https://en.wikipedia.org/wiki/Deep_Note
; https://www.uspto.gov/trademark/soundmarks/trademark-sound-mark-examples
; http://tsdr.uspto.gov/#caseNumber=74309951&caseType=SERIAL_NO&searchType=statusSearch
; http://cdm.link/2015/04/thx-deep-note-creator-remade-iconic-sound/
; http://musicthing.blogspot.se/2005/05/tiny-music-makers-pt-3-thx-sound.html
; http://earslap.com/article/recreating-the-thx-deep-note.html

	.include "song.inc"
	.segment "BANK1"
	.export trademark
	.export trademark_a
	.import trademark_a_id
	.export trademark_b
	.import trademark_b_id
	.export trademark_c
	.import trademark_c_id
;.define WAV 026
;.define BASEVOL 050
.define WAV r07
.define BASEVOL 000

; r08	-	pitch change speed

; r01/r10	-	starting pitch
; r02/r20	-	final pitch
; r03/r30	-	current pitch
; r04/r40   -   current pan
; r05/r50   -   freq delta
.proc mapchannels
	SET		r01,r00		; starting pitch
	SET		r02,r00		; final pitch
	ADD		r02,$10
	SET		r03,r00		; current pitch
	ADD		r03,$20
	SET		r04,r00		; current pan
	ADD		r04,$30
	SET		r05,r00		; freq delta
	ADD		r05,$40
	RET
.endproc
; Update pitch slides for channels
.proc updatepitch
	JNE		r08,0,cont
notdone:
	RET
cont:
	CALL	mapchannels
	JEQ		r03i,r02i,notdone					; actually done
	JGT		r01i,r02i,sweepdown,sweepup			;start>final
sweepdown:
	SET		r05i,r01i	; starting pitch
	SUB		r05i,r02i	; final
	DIV		r05i,r08
	ADD		r05i,1
	SUB		r03i,r05i
	JGT		r03i,r02i,notdone
	SET		r03i,r02i
	RET
sweepup:
	SET		r05i,r02i	; final
	SUB		r05i,r01i	; starting
	DIV		r05i,r08
	ADD		r05i,1
	ADD		r03i,r05i
	JLT		r03i,r02i,notdone
	SET		r03i,r02i
	RET
.endproc
; Update channels
.proc updatech
rept:
	CALL	updatepitch
	ADD		r00,1
	REPT	7,rept
	RET
.endproc
; Set initial random frequencies
.proc setrandom
rept:
	CALL	mapchannels
	RNG		r01i,13<<8	; starting
	ADD		r01i,Gn3<<8
	SET		r03i,r01i
	RNG		r02i,13<<8	; final
	ADD		r02i,Gn3<<8
	RNG		r04i,30		; panning
	SUB		r04i,15
	ADD		r00,1
	REPT	7,rept
	RET
.endproc
; Set random freqs, but in a set order
.proc setrandom2
	SET		r09,(Gn3<<8)+(12<<8)
rept:
	CALL	mapchannels
	SET		r01i,r03i	; starting
	RNG		r02i,(12<<8)/8	; final
	ADD		r02i,r09
	SUB		r09,(12<<8)/8
	ADD		r00,1
	REPT	7,rept
	RET
.endproc
; Set random freqs
.proc setrandom3
rept:
	CALL	mapchannels
	SET		r01i,r03i	; starting
	RNG		r02i,12<<8	; final
	ADD		r02i,Gn3<<8
	ADD		r00,1
	REPT	7,rept
	RET
.endproc
; Set target freq
.proc setfreq
	CALL	mapchannels
	SET		r01i,r03i
	SET		r02i,r09
	ADD		r00,1
	RET
.endproc
; Set final target frequencies
.proc setfinal
	SET		r09,(Dn3<<8)+$80
	CALL	setfreq
	CALL	setfreq
	SET		r09,(Dn4<<8)+$80
	CALL	setfreq
	CALL	setfreq
	SET		r09,(An4<<8)+$80
	CALL	setfreq
	SET		r09,(Dn5<<8)+$80
	CALL	setfreq
	SET		r09,(An5<<8)+$80
	CALL	setfreq
	SET		r09,(Dn6<<8)+$80
	CALL	setfreq
	RET
.endproc
.proc trademark
	VOICE	000,001,002,003,004,005,006,007
	INIT	050,050,050,050,050,050,050,050
	;TVOL	000
	TVOLREG	r0a
	TEMPO	80
	SPEED	12
	
	TRACK	01,trademark_a_id
	TRACK	02,trademark_b_id
	TRACK	03,trademark_c_id
	
	SET		r08,30
	SET		r0b,80+BASEVOL	; target volume
	SET		r0c,05	; vol change speed
	CALL	init
	
	WAVE	WAV,WAV,WAV,WAV,WAV,WAV,WAV,WAV	; waveform #
	VOL		000,005,010,015,020,025,030,035	; volume
	ENV		001,001,001,001,001,001,001,001	; envelope
	PAN		-02,+02,-05,+05,-10,+10,-15,+15	; pan
	LFO		006,007,006,007,006,007,006,007 ; LFO
	PTA		020,020,020,020,020,020,020,020	; portamento
	LINK	___,___,___,___,___,___,___,___ ; link mode
	CUTOFF	___,___,___,___,___,___,___,___	; cutoff mode
	FRQREG	r30,r31,r32,r33,r34,r35,r36,r37
	
	_FRQ	Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5 ; 0
p1:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	30,p1
	CALL	rand
	REPT	1,p1
	
	SET		r08,100
	SET		r0b,60+BASEVOL	; target volume
	SET		r0c,1	; vol change speed
	CALL	final
p2:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	20,p2
	
	SET		r08,40
	SET		r0b,0+BASEVOL	; target volume
	SET		r0c,2	; vol change speed
p3:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	70,p3
	
	SET		r0b,255+BASEVOL	; target volume
	SET		r0c,2	; vol change speed
p4:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	120,p4
	RET
	
init:
	SET		r0a,200+BASEVOL
	SET		r00,$10
	JUMP	setrandom
; r0a - curr vol
; r0b - target vol
update:
	JEQ		r0a,r0b,nochange
	JGT		r0a,r0b,voldown,volup
voldown:
	SUB		r0a,r0c
	JUMP	nochange
volup:
	ADD		r0a,r0c
	JUMP	nochange
nochange:
	SET		r00,$10
	JUMP	updatech
rand:
	SET		r00,$10
	JUMP	setrandom2
final:
	SET		r00,$10
	JUMP	setfinal
	
.endproc

.proc trademark_a
	VOICE	008,009,010,011,012,013,014,015
	INIT	050,050,050,050,050,050,050,050
	TVOLREG	r0a
	TEMPO	80
	SPEED	12
	
	CALL	init
	
	WAVE	WAV,WAV,WAV,WAV,WAV,WAV,WAV,WAV	; waveform #
	VOL		010,015,020,025,030,035,040,045	; volume
	ENV		001,001,001,001,001,001,001,001	; envelope
	PAN		r48,r49,r4a,r4b,r4c,r4d,r4e,r4f	; pan
	LFO		006,007,006,007,006,007,006,007 ; LFO
	PTA		020,020,020,020,020,020,020,020	; portamento
	LINK	___,___,___,___,___,___,___,___ ; link mode
	CUTOFF	___,___,___,___,___,___,___,___	; cutoff mode
	FRQREG	r38,r39,r3a,r3b,r3c,r3d,r3e,r3f
	
	_FRQ	Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5 ; 0
p1:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	30,p1
	CALL	rand
	REPT	1,p1
	
	CALL	final
p2:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	210,p2
	RET
	
init:
	SET		r00,$18
	JUMP	setrandom
update:
	SET		r00,$18
	JUMP	updatech
rand:
	SET		r00,$18
	JUMP	setrandom2
final:
	SET		r00,$18
	JUMP	setfinal
	
.endproc

.proc trademark_b
	VOICE	016,017,018,019,020,021,022,023
	INIT	050,050,050,050,050,050,050,050
	TVOLREG	r0a
	TEMPO	80
	SPEED	12
	
	CALL	init
	
	WAVE	WAV,WAV,WAV,WAV,WAV,WAV,WAV,WAV	; waveform #
	VOL		020,025,030,035,040,045,050,055	; volume
	ENV		001,001,001,001,001,001,001,001	; envelope
	PAN		-02,+02,-05,+05,-10,+10,-15,+15	; pan
	LFO		006,007,006,007,006,007,006,007 ; LFO
	PTA		020,020,020,020,020,020,020,020	; portamento
	LINK	___,___,___,___,___,___,___,___ ; link mode
	CUTOFF	___,___,___,___,___,___,___,___	; cutoff mode
	FRQREG	r80,r81,r82,r83,r84,r85,r86,r87
	
	_FRQ	Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5 ; 0
p1:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	30,p1
	CALL	rand
	REPT	1,p1
	
	CALL	final
p2:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	210,p2
	RET
	
init:
	SET		r00,$60
	JUMP	setrandom
update:
	SET		r00,$60
	JUMP	updatech
rand:
	SET		r00,$60
	JUMP	setrandom3
final:
	SET		r00,$60
	JUMP	setfinal
	
.endproc

.proc trademark_c
	VOICE	024,025,026,027,028,029,030,031
	INIT	050,050,050,050,050,050,050,050
	TVOLREG	r0a
	TEMPO	80
	SPEED	12
	
	CALL	init
	
	WAVE	WAV,WAV,WAV,WAV,WAV,WAV,WAV,WAV	; waveform #
	VOL		030,035,040,045,050,055,060,065	; volume
	ENV		001,001,001,001,001,001,001,001	; envelope
	PAN		r98,r99,r9a,r9b,r9c,r9d,r9e,r9f	; pan
	LFO		006,007,006,007,006,007,006,007 ; LFO
	PTA		020,020,020,020,020,020,020,020	; portamento
	LINK	___,___,___,___,___,___,___,___ ; link mode
	CUTOFF	___,___,___,___,___,___,___,___	; cutoff mode
	FRQREG	r88,r89,r8a,r8b,r8c,r8d,r8e,r8f
	
	_FRQ	Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn5 ; 0
p1:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	30,p1
	CALL	rand
	REPT	1,p1
	
	CALL	final
p2:
	CALL	update
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	REPT	210,p2
	RET
	
init:
	SET		r00,$68
	JUMP	setrandom
update:
	SET		r00,$68
	JUMP	updatech
rand:
	SET		r00,$68
	JUMP	setrandom3
final:
	SET		r00,$68
	JUMP	setfinal
	
.endproc