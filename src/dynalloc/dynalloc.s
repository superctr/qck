;==============================================================================
;
;  Dynamic channel allocation
; 
;  proof of concept
;
;==============================================================================

	.export dynalloc_set0,dynalloc_set1,dynalloc_set2,dynalloc_set3
	.import dynalloc0,dynalloc1,dynalloc2,dynalloc3
	
	.export dynalloc_note,dynalloc_note2,dynalloc_init
	
	.export dynalloc_test
	
	.include "song.inc"
	
	.segment "BANK2"

.proc dynalloc_init

	MSG		"Dynamic allocation init"
	
	SET		r05,0
	SET		r07,64
	
	SET		r08,$10
	SET		r06,7
	SET		r09,$10
	SET		r0a,$80
	CALL	clrregs
	
	TRACK	28,dynalloc0
	TRACK	29,dynalloc1
	TRACK	30,dynalloc2
	TRACK	31,dynalloc3
	
	RET
.endproc
	
; Register map

; r05  Global volume
; r06  voice count
; r07  global tempo
; r08  Voice counter
; r09  Reg counter
; r0a-r0f  Temp registers
; r10  V#0 Key on flag / Channel #
;          Bit 15 : busy
;          Bit 14 : key on
;          Bit 0-7: Channel#
; r11  V#0 Velocity
; r12  V#0 Note #
; r13  V#0 Length
; ...
	
	
; r80 Wave
; r81 Volume
; r82 Envelope
; r83 Panning
; r84 Pitch envelope
; r85 Transpose
; r86 Detune
	
	
.define SR0 BASEREG
.define SR1 BASEREG+4
.define SR2 BASEREG+8
.define SR3 BASEREG+12
.define SR4 BASEREG+16
.define SR5 BASEREG+20
.define SR6 BASEREG+24
.define VR0 BASEREG+1
.define VR1 BASEREG+5
.define VR2 BASEREG+9
.define VR3 BASEREG+13
.define VR4 BASEREG+17
.define VR5 BASEREG+21
.define VR6 BASEREG+25

.proc update

	SET		r0e,0
	
loop:
	SET		r0a,r09i		; keyon flags
	BAND	r0a,$c000
	JEQ		r0a,0,done
	
	SET		r0b,r09
	ADD		r0b,1
	SET		r0d,r0bi		; velocity
	ADD		r0b,1
	SET		r0c,r0bi		; note #
	ADD		r0b,1
	JEQ		r0a,$4000,keyon,busy

busy:
	SUB		r0bi,1			; decrease time left
	JCC		done	
	BAND	r09i,$7fff		; not busy anymore
	CALL	getlink
	ROWBUF	1
	_FRQ	Q__,___,___,___,___,___,___,___
	JUMP	done

keyon:
	BAND	r09i,$bfff		; not starting anymore
	BOR		r09i,$8000		; now busy
	CALL	getlink
	CALL	writech
	ROWBUF	1
	_FRQ	r0c,___,___,___,___,___,___,___
	JUMP	done
	
done:
	ADD		r09,4
	
	ADD		r0e,1
	JNE		r0e,7,loop
	WAIT	1
	
	RET
	
.endproc

.proc getlink
	JEQ		r0e,0,l0
	JEQ		r0e,1,l1
	JEQ		r0e,2,l2
	JEQ		r0e,3,l3
	JEQ		r0e,4,l4
	JEQ		r0e,5,l5
	JEQ		r0e,6,l6
l0:
	LINK	___,001,000,000,000,000,000,000
	RET
l1:
	LINK	___,000,001,000,000,000,000,000
	RET
l2:
	LINK	___,000,000,001,000,000,000,000
	RET
l3:
	LINK	___,000,000,000,001,000,000,000
	RET
l4:
	LINK	___,000,000,000,000,001,000,000
	RET
l5:
	LINK	___,000,000,000,000,000,001,000
	RET
l6:
	LINK	___,000,000,000,000,000,000,001
	RET
.endproc

.proc writech

	SET		r0b,$80		; temp register set
	SET		r0a,r09i	; get preset #
	BAND	r0a,$ff
	MUL		r0a,8
	ADD		r0a,$80
	
loop:
	SET		r0bi,r0ai	; copy presets
	ADD		r0b,1
	ADD		r0a,1
	REPT	7,loop

	ADD		r81,r0d		; add velocity to channel volume
	
	JEQ		r0e,0,l0
	JEQ		r0e,1,l1
	JEQ		r0e,2,l2
	JEQ		r0e,3,l3
	JEQ		r0e,4,l4
	JEQ		r0e,5,l5
	JEQ		r0e,6,l6
l0:
	WAVE	___,r80,___,___,___,___,___,___
	VOL		___,r81,___,___,___,___,___,___
	ENV		___,r82,___,___,___,___,___,___
	PAN		___,r83,___,___,___,___,___,___
	PIT		___,r84,___,___,___,___,___,___
	TRS		___,r85,___,___,___,___,___,___
	DTN		___,r86,___,___,___,___,___,___
	FRQ		___,r87,___,___,___,___,___,___
	RET
l1:
	WAVE	___,___,r80,___,___,___,___,___
	VOL		___,___,r81,___,___,___,___,___
	ENV		___,___,r82,___,___,___,___,___
	PAN		___,___,r83,___,___,___,___,___
	PIT		___,___,r84,___,___,___,___,___
	TRS		___,___,r85,___,___,___,___,___
	DTN		___,___,r86,___,___,___,___,___
	FRQ		___,___,r87,___,___,___,___,___
	RET
l2:
	WAVE	___,___,___,r80,___,___,___,___
	VOL		___,___,___,r81,___,___,___,___
	ENV		___,___,___,r82,___,___,___,___
	PAN		___,___,___,r83,___,___,___,___
	PIT		___,___,___,r84,___,___,___,___
	TRS		___,___,___,r85,___,___,___,___
	DTN		___,___,___,r86,___,___,___,___
	FRQ		___,___,___,r87,___,___,___,___
	RET
l3:
	WAVE	___,___,___,___,r80,___,___,___
	VOL		___,___,___,___,r81,___,___,___
	ENV		___,___,___,___,r82,___,___,___
	PAN		___,___,___,___,r83,___,___,___
	PIT		___,___,___,___,r84,___,___,___
	TRS		___,___,___,___,r85,___,___,___
	DTN		___,___,___,___,r86,___,___,___
	FRQ		___,___,___,___,r87,___,___,___
	RET
l4:
	WAVE	___,___,___,___,___,r80,___,___
	VOL		___,___,___,___,___,r81,___,___
	ENV		___,___,___,___,___,r82,___,___
	PAN		___,___,___,___,___,r83,___,___
	PIT		___,___,___,___,___,r84,___,___
	TRS		___,___,___,___,___,r85,___,___
	DTN		___,___,___,___,___,r86,___,___
	FRQ		___,___,___,___,___,r87,___,___
	RET
l5:
	WAVE	___,___,___,___,___,___,r80,___
	VOL		___,___,___,___,___,___,r81,___
	ENV		___,___,___,___,___,___,r82,___
	PAN		___,___,___,___,___,___,r83,___
	PIT		___,___,___,___,___,___,r84,___
	TRS		___,___,___,___,___,___,r85,___
	DTN		___,___,___,___,___,___,r86,___
	FRQ		___,___,___,___,___,___,r87,___
	RET
l6:
	WAVE	___,___,___,___,___,___,___,r80
	VOL		___,___,___,___,___,___,___,r81
	ENV		___,___,___,___,___,___,___,r82
	PAN		___,___,___,___,___,___,___,r83
	PIT		___,___,___,___,___,___,___,r84
	TRS		___,___,___,___,___,___,___,r85
	DTN		___,___,___,___,___,___,___,r86
	FRQ		___,___,___,___,___,___,___,r87
	RET
.endproc

.proc clrregs
l1:
	SET		r09i,0
	ADD		r09,1
	JNE		r09,r0a,l1		; branch if we reached $40
	RET
.endproc

.proc dynalloc_set0

.define BASEREG r10
	VOICE	___,004,005,006,007,008,009,010
	INIT	___,025,025,025,025,025,025,025
	TVOLREG	r05
	TEMPOREG r07
loop:
	SET		r09,$10
	CALL	update
	JUMP	loop
.endproc

.proc dynalloc_set1

.undefine BASEREG
.define BASEREG r2c
	VOICE	___,011,012,013,014,015,016,017
	INIT	___,025,025,025,025,025,025,025
	TVOLREG	r05
	TEMPOREG r07
loop:
	SET		r09,$2c
	CALL	update
	JUMP	loop

.endproc

.proc dynalloc_set2

.undefine BASEREG
.define BASEREG r48
	VOICE	___,018,019,020,021,022,023,024
	INIT	___,025,025,025,025,025,025,025
	TVOLREG	r05
	TEMPOREG r07
loop:
	SET		r09,$48
	CALL	update
	JUMP	loop

.endproc

.proc dynalloc_set3

.undefine BASEREG
.define BASEREG r64
	VOICE	___,025,026,027,028,029,030,031
	INIT	___,025,025,025,025,025,025,025
	TVOLREG	r05
	TEMPOREG r07
loop:
	SET		r09,$64
	CALL	update
	JUMP	loop

.endproc

.proc dynalloc_note2
	SET		r0b,0
.endproc

.proc dynalloc_note

loop:
	SET		r0e,31
	SET		r09,r08i
	BAND	r09,$c000		; is voice free?
	JEQ		r09,0,voiceok
	ADD		r08,4			; check next voice
	JNE		r08,$80,no_ovf
	SET		r08,$10
no_ovf:
	SUB		r0e,1			; if we checked enough times
	JNE		r0e,0,loop		; just pick a voice
	
voiceok:

	SET		r08i,$4000
	BOR		r08i,r0a		; preset #
	ADD		r08,1
	SET		r08i,r0b		; volume
	ADD		r08,1
	SET		r08i,r0c		; note #
	ADD		r08,1
	SET		r08i,r0d		; length
	ADD		r08,1
	
	JNE		r08,$80,no_ovf2
	SET		r08,$10
no_ovf2:
	RET
.endproc

.macro note ch,val,vel,len,quant

	SET		r0a,ch
	SET		r0b,vel
	SET		r0c,val
	.ifnblank quant
		SET		r0d,len-quant
	.else
		SET		r0d,len
	.endif
	CALL	dynalloc_note
	WAIT	len

.endmacro

.macro note2 ch,val,vel,len2,len

	SET		r0a,ch
	SET		r0b,vel
	SET		r0c,val
	SET		r0d,len2
	CALL	dynalloc_note
	.ifnblank len
		WAIT len
	.endif
	
.endmacro


.macro rest delay

	WAIT	delay

.endmacro

.macro preset no,wave,vol,env,pan,penv,trs,dtn
	SET		r80+(no*8),wave
	SET		r81+(no*8),vol
	SET		r82+(no*8),env
	SET		r83+(no*8),pan
	SET		r84+(no*8),penv
	SET		r85+(no*8),trs
	SET		r86+(no*8),dtn
.endmacro

.proc dynalloc_test

.define	L1   16*12
.define L2D  12*12
.define L2   8*12
.define L4D  6*12
.define L4   4*12
.define L8D  3*12
.define L8   2*12
.define L16D 3*6
.define L16  2*6
.define L32  1*6

	TEMPO	64
	SPEED	1
	
	CALL	dynalloc_init
	SET		r07,64
	
	preset	1,3,0,3,0,0,0,0
	
	WAIT	1
loop:
	note	1,Cn5,0,L4
	note	1,Dn5,10,L4
	note	1,En5,20,L4
	note	1,Fn5,30,L4
	note	1,Gn5,40,L4
	note	1,An5,50,L4
	note	1,Bn5,40,L4
	note	1,Cn6,30,L4
	JUMP	loop
	
.endproc



