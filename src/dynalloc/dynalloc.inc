	.import dynalloc_note,dynalloc_note2,dynalloc_init

.macro note ch,val,vel,len,quant

	SET		r0a,ch
	SET		r0c,val
	.ifnblank quant
		SET		r0d,len-quant
	.else
		SET		r0d,len
	.endif
	.if (vel=0)
		CALL	dynalloc_note2
	.else
		SET		r0b,vel
		CALL	dynalloc_note
	.endif
	WAIT	len

.endmacro

.macro note2 ch,val,vel,len2,len

	SET		r0a,ch
	SET		r0c,val
	SET		r0d,len2
	SET		r0b,vel
	.if (vel=0)
		CALL	dynalloc_note2
	.else
		SET		r0b,vel
		CALL	dynalloc_note
	.endif
	.ifnblank len
		WAIT len
	.endif
	
.endmacro

.macro rest delay

	WAIT	delay

.endmacro

; r80 Wave
; r81 Volume
; r82 Envelope
; r83 Panning
; r84 Pitch envelope
; r85 Transpose
; r86 Detune

.macro preset no,wave,vol,env,pan,penv,trs,dtn,note
	SET		r80+(no*8),wave
	SET		r81+(no*8),vol
	SET		r82+(no*8),env
	SET		r83+(no*8),pan
	SET		r84+(no*8),penv
	SET		r85+(no*8),trs
	SET		r86+(no*8),dtn
	SET		r87+(no*8),note
.endmacro

.define	L1   16*6
.define L2D  12*6
.define L2   8*6
.define L4D  6*6
.define L4   4*6
.define L8D  3*6
.define L8   2*6
.define L16D 3*3
.define L16  2*3
.define L32  1*3
