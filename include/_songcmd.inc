;==============================================================================
;
;  Quattro Creation Kit
;
;  Song commands
;
;  (Do not include this file directly, use "song.inc" instead)
;
;==============================================================================

; RR - Reset wait counter
;    Invoke this before a label to make sure jumps/repeats/etc end up in the
;    correct position. Only needed if the previous pattern ends with a
;	 row advancing command (i.e. key on).

;.macro RR (this is defined in songdef.inc)
;.endmacro

.macro _NOP
	RR
	.byt	$00
.endmacro

.macro MSG string
	RR
	.byte	$17
	.asciiz string
.endmacro

; POKE_B, POKE_W - write data to memory
;------------------------------------------------------------------------------
; dest .... Destination address
; data .... data to write
.macro POKEB dest, data
	RR
	.byte	$01
	.word	dest
	.byte	data
.endmacro
.macro POKEW dest, data
	RR
	.byte	$02
	.word	dest
	.word	data
.endmacro

; RLD_B - Load word from memory to register
; RST_B
; reg ..... Destination Register
; addr .... Source address
;.macro LDR_B reg, addr
;	RR
;	.byte	$02
;	.word	dest
;	.word	data
;.endmacro

; JUMP to location
;------------------------------------------------------------------------------
; addr .... destination address
.macro JUMP addr
	RR
	.byte	$10
	POS	addr
.endmacro

; CALL subroutine
;------------------------------------------------------------------------------
; addr .... destination address
.macro CALL addr
	RR
	.byte	$11
	POS	addr
.endmacro

; RETurn from subroutine or end song
;------------------------------------------------------------------------------
.macro RET
	RR
	.byt	$14
.endmacro

; END song
;------------------------------------------------------------------------------
.macro END
	RR
	.byt	$15
.endmacro

; REPEAT section
;------------------------------------------------------------------------------
;  put this at the end of the repeating section. When the section has been
;  repeated the specified number of times, the song continues from after this
;  instruction.
; count ... times to repeat
; addr .... starting point
.macro REPT count, addr
	RR
	.byte	$12
	.byt	count
	POS	addr
.endmacro

; begin LOOP
;------------------------------------------------------------------------------
;  put this at the beginning of the loop, then JUMP back at the end
;  When the count reaches zero. the track position changes to the specified
;  address.
; count ... times to loop
; addr .... exit address
.macro LOOP count, addr
	RR
	.byte	$13
	.byt	count
	POS	addr
.endmacro

; set register
;------------------------------------------------------------------------------
; p0 = destination
; p1 = source
.macro SET p0,p1
	__setreg $00,p0,p1
.endmacro
.macro ADD p0,p1
	__setreg $01,p0,p1
.endmacro
.macro SUB p0,p1
	__setreg $02,p0,p1
.endmacro
.macro MUL p0,p1
	__setreg $03,p0,p1
.endmacro
.macro DIV p0,p1
	__setreg $04,p0,p1
.endmacro
.macro MOD p0,p1
	__setreg $05,p0,p1
.endmacro
.macro RNG p0,p1 ; p1 = modulo
	__setreg $06,p0,p1
.endmacro
; bitwise operations have the B.. prefix in order to avoid clashing with
; the 6502 assembly instructions.
.macro BAND p0,p1
	__setreg $07,p0,p1
.endmacro
.macro BOR p0,p1
	__setreg $08,p0,p1
.endmacro
.macro BXOR p0,p1
	__setreg $09,p0,p1
.endmacro

; conditional jump
;------------------------------------------------------------------------------
; p0, p1 = operands
; j0 = jump location if true
; j1 = jump location if false (optional)
.macro JEQ p0,p1,j0,j1
	__cjump $00,p0,p1,j0,j1
.endmacro
.macro JNE p0,p1,j0,j1
	__cjump $01,p0,p1,j0,j1
.endmacro
.macro JGE p0,p1,j0,j1
	__cjump $02,p0,p1,j0,j1
.endmacro
.macro JLE p0,p1,j0,j1
	__cjump $03,p0,p1,j0,j1
.endmacro
.macro JGT p0,p1,j0,j1
	__cjump $04,p0,p1,j0,j1
.endmacro
.macro JLT p0,p1,j0,j1
	__cjump $05,p0,p1,j0,j1
.endmacro
.macro JCC j0,j1
	__cjump $06,r00,r00,j0,j1
.endmacro
.macro JCS j0,j1
	__cjump $07,r00,r00,j0,j1
.endmacro
.macro JPL j0,j1
	__cjump $08,r00,r00,j0,j1
.endmacro
.macro JMI j0,j1
	__cjump $09,r00,r00,j0,j1
.endmacro

; play subsong on track
;------------------------------------------------------------------------------
.macro TRACK slot, id
	RR
	.ifconst id
		.if (id < ___)
			.byte $0d,<slot
			.word id
		.else
			.byte $0e,<slot,<id
		.endif
	.else
		.byte $0d,<slot
		.word id
	.endif
.endmacro

; track variables
;------------------------------------------------------------------------------
; tempo (BPM=9600/tempo with a speed value of 12)
.macro TEMPO p0
	__trkvar $06,$07,p0
.endmacro
; speed  (tempo units per row)
.macro SPEED p0
	__trkvar $2d,$09,p0
.endmacro
; track volume
.macro TVOL p0
	__trkvar $07,$06,p0
.endmacro
; track volume register
.macro TVOLREG p0
	RR
	.byte $0a,<p0
.endmacro
; ttrack tempo register
.macro TEMPOREG p0
	RR
	.byte $09,<p0
.endmacro
; row buffer
.macro ROWBUF p0
	__trkvar $03,$13,p0
.endmacro

; configuration
.macro TRKCNT p0
	RR
	POKEB $4484,p0
.endmacro
.macro VOICNT p0
	RR
	POKEB $4482,p0
.endmacro
.macro PITCH p0
	RR
	POKEW $00dc,p0 & $ffff
.endmacro

.macro TEMPOSEQ args
	RR
	.local @temp
	.byt $0c, @temp-1-*
	.byt args
@temp:
.endmacro

; channel variables (initialization)
;------------------------------------------------------------------------------
; Set channel number
; p0-p7 : Voice number
.macro VOICE p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$11,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Allocates the channels
; p0-p7 : Priority
.macro INIT p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $1d,,,$00,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro

; channel variables
;------------------------------------------------------------------------------
; Waveform Select
.macro WAVE p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $1c,$1b,$1c,$00,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Volume
.macro VOL p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$02,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Volume register
.macro VOLREG p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$1c,p0,p1,p2,p3,p4,p5,p6,p7,1
.endmacro
; Pan (fixed)
.macro PAN p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $08,,,$03,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Get pan from register
.macro PANREG p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $1a,,,$03,p0,p1,p2,p3,p4,p5,p6,p7,1
.endmacro
; Set X/Y position (can't use at the same time as PAN)
.macro POSX p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$03,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
.macro POSY p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$0e,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Get position from register
.macro POSREG p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $2b,,,$03,p0,p1,p2,p3,p4,p5,p6,p7,1
.endmacro
; Pan envelope (use PAN with 0 to reset!)
.macro PANENV p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $29,,,$03,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Position envelope
.macro POSENV p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $2a,,,$03,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Detune (frequency low)
.macro DTN p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$04,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Note  (frequency high)
.macro FRQ p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$05,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Volume Envelope (0=disable)
.macro ENV p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,$30,$30,$06,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Pitch envelope (0=disable)
.macro PIT p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,$30,$30,$07,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Note Delay (in 120hz ticks)
.macro DEL p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$08,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Gate Time
.macro GTM p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$09,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Sample Offset
.macro OFF p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $28,,,$0a,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Transpose
.macro TRS p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$0b,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; LFO (0=disable)
.macro LFO p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$0c,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Portamento (glissando)
.macro PTA p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$0d,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Pitch reg
.macro FRQREG p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$0f,p0,p1,p2,p3,p4,p5,p6,p7,1
.endmacro
; Preset map select
.macro PSTMAP p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$10,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Legato (the following <n> notes will be tied)
.macro LEG p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$12,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; link channels (0=off, 1-8=specifies a 'parent')
.macro LINK p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$14,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Preset select
.macro PST p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $0f,,,$15,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; cutoff mode
.macro CUTOFF p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$1d,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro

; voice variables
;------------------------------------------------------------------------------
; Detune (frequency low)
.macro DTNSET p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$4c,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Note  (frequency high)
.macro FRQSET p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $04,,,$4b,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro

; key on
;------------------------------------------------------------------------------
; Note  (frequency high)
.macro _FRQ p0,p1,p2,p3,p4,p5,p6,p7
	__keyon $20,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Volume
.macro _VOL p0,p1,p2,p3,p4,p5,p6,p7
	__keyon $22,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Delay
.macro _DEL p0,p1,p2,p3,p4,p5,p6,p7
	__keyon $24,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Pan
.macro _PAN p0,p1,p2,p3,p4,p5,p6,p7
	__keyon $26,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro

; channel variables (multiple)
.macro CHANNEL id,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
	__multset $18,id,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
.endmacro
; write preset (used by PST or MACMAP commands)
.macro PRESET id,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
	__multset $19,id,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
.endmacro
