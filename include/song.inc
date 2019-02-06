;==============================================================================
;
;  Quattro Creation Kit
;
;  Song data defines and macros
;
;==============================================================================

	.list	-

.scope	Q
	RESTCNT		.set	0
	
	; register operation (this means 'rXX' will be treated as immediate)
	regop		.set	0
	
	; these are all filled in by __parse_arg or __parse_args macros
	arg0		.set	0
	arg1		.set	0
	arg2		.set	0
	arg3		.set	0
	arg4		.set	0
	arg5		.set	0
	arg6		.set	0
	arg7		.set	0
	arg8		.set	0
	arg9		.set	0
	arg10		.set	0
	arg11		.set	0
	arg12		.set	0
	arg13		.set	0
	arg14		.set	0
	
	imm_mask	.set	0	; bitmask of immediate type operands
	reg_mask	.set	0	; bitmask of register type operands
	nul_mask	.set	0	; bitmask of unused operands
	
	imm_equal	.set	0	; set if all immediate operands were equal
	imm_data	.set	0	; data of first immediate operand
	imm_word	.set	0	; set if at least one immediate operand is 16-bit
	
	reg_equal	.set	0	; set if all register operands were equal
	reg_data	.set	0	; data of first register operand
	
.endscope

.include	"_songdef.inc"

; System macros
.macro RR
	.if (Q::RESTCNT > 0)
		.byt	$7f + Q::RESTCNT
		Q::RESTCNT .set 0
	.endif
.endmacro
; use this
.macro WAIT count
	.if (Q::RESTCNT > 0)
		.if((Q::RESTCNT + count) < $81)
			.byt	$7f + Q::RESTCNT + count
		.else
			.byt	$ff
			.byt	$7f + (Q::RESTCNT + count-128)
		.endif
		Q::RESTCNT .set 0
	.else
		.if(count < $81)
			.byt	$7f + count
		.else
			.byt	$ff
			.byt	$7f + (count-128)
		.endif
	.endif
.endmacro
; deprecated
.macro REST count
	.if (Q::RESTCNT > 0)
		.if((Q::RESTCNT + count) < $81)
			.byt	$7f + Q::RESTCNT + count
		.else
			.byt	$ff
			.byt	$7f + count
		.endif
		Q::RESTCNT .set 0
	.else
		.byt	$7f + count
	.endif
.endmacro
.macro POS addr
	.addr	addr
	.byt	<.BANK(addr)
.endmacro

;==============================================================================
;
; Macro helpers for sequence commands
;
;==============================================================================

.macro __creg __arg, __mask
	.if ((__arg > ___) && (Q::reg_mask & __mask)>0)
		.byt	<__arg
	.endif
.endmacro

.macro __reg
	__creg Q::arg0, %10000000
	__creg Q::arg1, %01000000
	__creg Q::arg2, %00100000
	__creg Q::arg3, %00010000
	__creg Q::arg4, %00001000
	__creg Q::arg5, %00000100
	__creg Q::arg6, %00000010
	__creg Q::arg7, %00000001
.endmacro

.macro __cbyt __arg, __mask
	.if ((__arg < ___) && (Q::imm_mask & __mask)>0)
		.byt	<__arg
	.endif
.endmacro

.macro __byte
	__cbyt Q::arg0, %10000000
	__cbyt Q::arg1, %01000000
	__cbyt Q::arg2, %00100000
	__cbyt Q::arg3, %00010000
	__cbyt Q::arg4, %00001000
	__cbyt Q::arg5, %00000100
	__cbyt Q::arg6, %00000010
	__cbyt Q::arg7, %00000001
.endmacro

.macro __cword __arg, __mask
	.if ((__arg < ___) && (Q::imm_mask & __mask)>0)
		.word	__arg
	.endif
.endmacro

.macro __word
	__cword Q::arg0, %10000000
	__cword Q::arg1, %01000000
	__cword Q::arg2, %00100000
	__cword Q::arg3, %00010000
	__cword Q::arg4, %00001000
	__cword Q::arg5, %00000100
	__cword Q::arg6, %00000010
	__cword Q::arg7, %00000001
.endmacro

.macro  __parse_arg  __in, __out, __mask

	__out	.set	___
	.ifnblank __in
		__out	.set	__in
	.endif
	
	.if ((Q::regop > 0) && (__out >= r00) && (__out < r00i))
		__out .set __out&$ff
	.endif
	
	.if (__out>___)	; register
		.if(Q::reg_data = ___)
			Q::reg_data .set __out
		.elseif(__out <> Q::reg_data)
			Q::reg_equal .set 0
		.endif
		Q::reg_mask .set Q::reg_mask | __mask
	.elseif (__out<___)	; immediate
		.if(Q::imm_data = ___)
			Q::imm_data .set __out
		.elseif(__out <> Q::imm_data)
			Q::imm_equal .set 0
		.endif
		Q::imm_mask .set Q::imm_mask | __mask
		.if(__out>$ff)
			Q::imm_word .set Q::imm_word | __mask
		.endif
	.else				; neither
		Q::nul_mask .set Q::nul_mask | __mask
	.endif
	
.endmacro

.macro	__parse_args	p0,p1,p2,p3,p4,p5,p6,p7
	Q::imm_equal	.set	1
	Q::imm_data		.set	___
	Q::reg_equal	.set	1
	Q::reg_data		.set	___
	Q::imm_mask		.set	0
	Q::reg_mask		.set	0
	Q::nul_mask		.set	0
	Q::imm_word		.set	0

	__parse_arg		p0,Q::arg0,%10000000
	__parse_arg		p1,Q::arg1,%01000000
	__parse_arg		p2,Q::arg2,%00100000
	__parse_arg		p3,Q::arg3,%00010000
	__parse_arg		p4,Q::arg4,%00001000
	__parse_arg		p5,Q::arg5,%00000100
	__parse_arg		p6,Q::arg6,%00000010
	__parse_arg		p7,Q::arg7,%00000001
.endmacro

.macro	__parse_args_mult	p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
	Q::imm_equal	.set	1
	Q::imm_data		.set	___
	Q::reg_equal	.set	1
	Q::reg_data		.set	___
	Q::imm_mask		.set	0
	Q::reg_mask		.set	0
	Q::nul_mask		.set	0
	Q::imm_word		.set	0

	__parse_arg		p0,Q::arg0, %1000000000000000
	__parse_arg		p1,Q::arg1, %0100000000000000
	__parse_arg		p2,Q::arg2, %0010000000000000
	__parse_arg		p3,Q::arg3, %0001000000000000
	__parse_arg		p4,Q::arg4, %0000100000000000
	__parse_arg		p5,Q::arg5, %0000010000000000
	__parse_arg		p6,Q::arg6, %0000001000000000
	__parse_arg		p7,Q::arg7, %0000000100000000
	__parse_arg		p8,Q::arg8, %0000000010000000
	__parse_arg		p9,Q::arg9, %0000000001000000
	__parse_arg		p10,Q::arg10,%0000000000100000
	__parse_arg		p11,Q::arg11,%0000000000010000
	__parse_arg		p12,Q::arg12,%0000000000001000
	__parse_arg		p13,Q::arg13,%0000000000000100
	__parse_arg		p14,Q::arg14,%0000000000000010
	
	Q::imm_mask		.set	Q::imm_mask | Q::reg_mask
.endmacro

;==============================================================================
;
; Parser macros
;
;==============================================================================

; key-on
;------------------------------------------------------------------------------
; type .... opcode
; p0-p7	... operands
.macro __keyon type, p0,p1,p2,p3,p4,p5,p6,p7

	__parse_args p0,p1,p2,p3,p4,p5,p6,p7

	.if (Q::nul_mask = $ff)	
		Q::RESTCNT .set Q::RESTCNT + 1
		.if (Q::RESTCNT > 127)
			.byt	$ff
			Q::RESTCNT .set 0
		.endif
		.exitmacro
	.endif
	RR
	
	.if (Q::reg_mask > 0)
		.if (Q::reg_equal = 1)
			.byte	type+65
			.byte	Q::reg_mask
			.byte	<Q::reg_data
		.else
			.byte	type+1
			.byte	Q::reg_mask
			__reg
		.endif
	.else							; can't combine reg+imm for keyons
		.if (Q::imm_equal = 1)
			.byte	type+64
			.byte	Q::imm_mask
			.byte	<Q::imm_data
		.else
			.byte	type
			.byte	Q::imm_mask
			__byte
		.endif
	.endif

.endmacro


; set channel variable
;------------------------------------------------------------------------------
; btype	... opcode for byte commands
; wtype ... opcode for word commands
; rtype ... opcode for reg. commands
; subtype . channel variable ID
; p0-p7 ... operands
; rop ..... indicates register operation
.macro __chvar btype,wtype,rtype,subtype, p0,p1,p2,p3,p4,p5,p6,p7,rop

	.local _bt,_wt,_rt
	
	.ifnblank rop
		Q::regop .set rop
	.endif

	_rt .set 0
	_wt .set 0
	.ifnblank wtype
		_wt .set wtype
		_rt .set _wt
	.endif
	
	_bt .set 0
	.ifnblank btype
		_bt .set btype
		_rt .set _bt
	.endif
	
	.ifnblank rtype
		_rt .set rtype
	.endif

	__parse_args p0,p1,p2,p3,p4,p5,p6,p7
	
	.if (Q::nul_mask = $ff)	
		.exitmacro
	.endif
	
	RR
	
	.if (Q::reg_mask > 0)
		.if (Q::reg_equal = 1)
			.byte	_rt+64
			.byte	Q::reg_mask
			.byte	subtype|$80
			.byte	<Q::reg_data
		.else
			.byte	_rt
			.byte	Q::reg_mask
			.byte	subtype|$80
			__reg
		.endif
	.endif
	
	.if (Q::imm_mask > 0)
		.if((_wt > 0) && (Q::imm_word > 0))
			.if (Q::imm_equal = 1)
				.byte	_wt+64
				.byte	Q::imm_mask
				.byte	subtype
				.word	Q::imm_data
			.else
				.byte	_wt
				.byte	Q::imm_mask
				.byte	subtype
				__word
			.endif
		.else
			.if (Q::imm_equal = 1)
				.byte	_bt+64
				.byte	Q::imm_mask
				.byte	subtype
				.byte	<Q::imm_data
			.else
				.byte	_bt
				.byte	Q::imm_mask
				.byte	subtype
				__byte
			.endif
		.endif
	.endif

	Q::regop .set 0
.endmacro

; set track variable
;------------------------------------------------------------------------------
; type ....	opcode
; subtype .	track variable ID
; p0 ...... operand
.macro __trkvar type,subtype,p0

	__parse_args p0
	
	.if (Q::nul_mask = $ff)	
		.exitmacro
	.endif
	RR
	
	.if (Q::reg_mask > 0)
		.byte	type
		.byte	subtype|$80
		.byte	<Q::reg_data
	.else
		.byte	type
		.byte	subtype
		.byte	<Q::imm_data
	.endif
	
.endmacro

; set register
;------------------------------------------------------------------------------
; type .... operation
; p0 ...... operand 0
; p1 ...... operand 1
.macro __setreg type,p0,p1
	RR

	.local flag
	flag .set 0
	__parse_args p0,p1
	.if ((Q::nul_mask & $c0) > 0)
		.error "missing parameters for 'set' macro"
	.endif
	
	.if(Q::arg0 > rff)
		flag .set flag | $40
	.elseif(Q::arg0 < r00)
		.error "bad operand mode for 'set' macro"
	.endif
	
	.if(Q::arg1 > rff)
		flag .set flag | $10
	.elseif(Q::arg1 > ___)
	.elseif(Q::arg1 > $ff)
		flag .set flag | $30
	.else
		flag .set flag | $20
	.endif
	
	.byt $1e, flag+type, <Q::arg0

	.if((Q::imm_word = $40) > 0)
		.word	Q::arg1
	.else
		.byt	<Q::arg1
	.endif
.endmacro

; conditional jump
;------------------------------------------------------------------------------
; type .... compare operation
; p0 ...... operand 0
; p1 ...... operand 1
; p2 ...... true condition jump addr
; p3 ...... (optional) false condition jump addr
.macro __cjump type,p0,p1,p2,p3
	RR
	
	.local flag
	flag .set 0
	
	__parse_args p0,p1
	.if ((Q::nul_mask & $c0) > 0)
		.error "missing parameters for conditional jump"
	.endif
	
	.if(Q::arg0 > rff)
		flag .set flag | $40
	.elseif(Q::arg0 > ___)
	.elseif(Q::arg0 > $ff)
		flag .set flag | $c0
	.else
		flag .set flag | $80
	.endif
	
	.if(Q::arg1 > rff)
		flag .set flag | $10
	.elseif(Q::arg1 > ___)
	.elseif(Q::arg1 > $ff)
		flag .set flag | $30
	.else
		flag .set flag | $20
	.endif
	
	.byt $1f, flag+type

	.if((Q::imm_word & $80) > 0)
		.word	Q::arg0
	.else
		.byt	<Q::arg0
	.endif
	
	.if((Q::imm_word & $40) > 0)
		.word	Q::arg1
	.else
		.byt	<Q::arg1
	.endif
	
	.ifblank p2
		.error "conditional jump must have at least one branch address"
	.else
		POS p2
	.endif
	
	.scope
	.ifblank p3
		POS jumploc
	.else
		POS p3
	.endif
	
jumploc:
	.endscope

.endmacro

.macro __multset type,id,p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14

	RR
	
	__parse_args_mult p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
	
	.byte	type, <id
	.word	Q::imm_mask
	
	__cword Q::arg0,%1000000000000000
	__cbyt Q::arg1, %0100000000000000
	__cbyt Q::arg2, %0010000000000000
	__cbyt Q::arg3, %0001000000000000
	__cbyt Q::arg4, %0000100000000000
	__cbyt Q::arg5, %0000010000000000
	__cbyt Q::arg6, %0000001000000000
	__cbyt Q::arg7, %0000000100000000
	__cbyt Q::arg8, %0000000010000000
	__cbyt Q::arg9, %0000000001000000
	__cbyt Q::arg10,%0000000000100000
	__cbyt Q::arg11,%0000000000010000
	__cbyt Q::arg12,%0000000000001000
	__cbyt Q::arg13,%0000000000000100
	__cbyt Q::arg14,%0000000000000010
	
.endmacro
	.include "_songcmd.inc"

	.list +
