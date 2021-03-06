;==============================================================================
;
;  Empty pattern template
;
;==============================================================================

	.include "song.inc"
	.segment "BANK1"
	.export empty
;	.import emptya_id
	
.proc empty
	VOICE	000,001,002,003,004,005,006,007
	INIT	050,050,050,050,050,050,050,050
	TVOL	000
	TEMPO	80
	SPEED	30
	
	WAVE	___,___,___,___,___,___,___,___	; waveform #
	VOL		___,___,___,___,___,___,___,___	; volume
	FRQ		___,___,___,___,___,___,___,___ ; base note
	ENV		___,___,___,___,___,___,___,___	; envelope
	PAN		___,___,___,___,___,___,___,___	; pan
	PANENV	___,___,___,___,___,___,___,___	; pan envelope
	DEL		___,___,___,___,___,___,___,___	; note delay
	GTM		___,___,___,___,___,___,___,___	; gate time
	TRS		___,___,___,___,___,___,___,___	; transpose
	DTN		___,___,___,___,___,___,___,___	; detune
	PIT		___,___,___,___,___,___,___,___	; pitch envelope
	PTA		___,___,___,___,___,___,___,___	; portamento
	LINK	___,___,___,___,___,___,___,___ ; link mode
	CUTOFF	___,___,___,___,___,___,___,___	; cutoff mode
	
	_FRQ	___,___,___,___,___,___,___,___ ; 0
	_FRQ	___,___,___,___,___,___,___,___ ; 1
	_FRQ	___,___,___,___,___,___,___,___ ; 2
	_FRQ	___,___,___,___,___,___,___,___ ; 3
	_FRQ	___,___,___,___,___,___,___,___ ; 4
	_FRQ	___,___,___,___,___,___,___,___ ; 5
	_FRQ	___,___,___,___,___,___,___,___ ; 6
	_FRQ	___,___,___,___,___,___,___,___ ; 7
	_FRQ	___,___,___,___,___,___,___,___ ; 8
	_FRQ	___,___,___,___,___,___,___,___ ; 9
	_FRQ	___,___,___,___,___,___,___,___ ;10
	_FRQ	___,___,___,___,___,___,___,___ ;11
	_FRQ	___,___,___,___,___,___,___,___ ;12
	_FRQ	___,___,___,___,___,___,___,___ ;13
	_FRQ	___,___,___,___,___,___,___,___ ;14
	_FRQ	___,___,___,___,___,___,___,___ ;15
	
	_FRQ	___,___,___,___,___,___,___,___ ;16
	_FRQ	___,___,___,___,___,___,___,___ ;17
	_FRQ	___,___,___,___,___,___,___,___ ;18
	_FRQ	___,___,___,___,___,___,___,___ ;19
	_FRQ	___,___,___,___,___,___,___,___ ;20
	_FRQ	___,___,___,___,___,___,___,___ ;21
	_FRQ	___,___,___,___,___,___,___,___ ;22
	_FRQ	___,___,___,___,___,___,___,___ ;23
	_FRQ	___,___,___,___,___,___,___,___ ;24
	_FRQ	___,___,___,___,___,___,___,___ ;25
	_FRQ	___,___,___,___,___,___,___,___ ;26
	_FRQ	___,___,___,___,___,___,___,___ ;27
	_FRQ	___,___,___,___,___,___,___,___ ;28
	_FRQ	___,___,___,___,___,___,___,___ ;29
	_FRQ	___,___,___,___,___,___,___,___ ;30
	_FRQ	___,___,___,___,___,___,___,___ ;31
	
	_FRQ	___,___,___,___,___,___,___,___ ;32
	_FRQ	___,___,___,___,___,___,___,___ ;33
	_FRQ	___,___,___,___,___,___,___,___ ;34
	_FRQ	___,___,___,___,___,___,___,___ ;35
	_FRQ	___,___,___,___,___,___,___,___ ;36
	_FRQ	___,___,___,___,___,___,___,___ ;37
	_FRQ	___,___,___,___,___,___,___,___ ;38
	_FRQ	___,___,___,___,___,___,___,___ ;39
	_FRQ	___,___,___,___,___,___,___,___ ;40
	_FRQ	___,___,___,___,___,___,___,___ ;41
	_FRQ	___,___,___,___,___,___,___,___ ;42
	_FRQ	___,___,___,___,___,___,___,___ ;43
	_FRQ	___,___,___,___,___,___,___,___ ;44
	_FRQ	___,___,___,___,___,___,___,___ ;45
	_FRQ	___,___,___,___,___,___,___,___ ;46
	_FRQ	___,___,___,___,___,___,___,___ ;47

	_FRQ	___,___,___,___,___,___,___,___ ;48
	_FRQ	___,___,___,___,___,___,___,___ ;49
	_FRQ	___,___,___,___,___,___,___,___ ;50
	_FRQ	___,___,___,___,___,___,___,___ ;51
	_FRQ	___,___,___,___,___,___,___,___ ;52
	_FRQ	___,___,___,___,___,___,___,___ ;53
	_FRQ	___,___,___,___,___,___,___,___ ;54
	_FRQ	___,___,___,___,___,___,___,___ ;55
	_FRQ	___,___,___,___,___,___,___,___ ;56
	_FRQ	___,___,___,___,___,___,___,___ ;57
	_FRQ	___,___,___,___,___,___,___,___ ;58
	_FRQ	___,___,___,___,___,___,___,___ ;59
	_FRQ	___,___,___,___,___,___,___,___ ;60
	_FRQ	___,___,___,___,___,___,___,___ ;61
	_FRQ	___,___,___,___,___,___,___,___ ;62
	_FRQ	___,___,___,___,___,___,___,___ ;63
	
	_VOL	___,___,___,___,___,___,___,___ ; 0
	_VOL	___,___,___,___,___,___,___,___ ; 1
	_VOL	___,___,___,___,___,___,___,___ ; 2
	_VOL	___,___,___,___,___,___,___,___ ; 3
	_VOL	___,___,___,___,___,___,___,___ ; 4
	_VOL	___,___,___,___,___,___,___,___ ; 5
	_VOL	___,___,___,___,___,___,___,___ ; 6
	_VOL	___,___,___,___,___,___,___,___ ; 7
	_VOL	___,___,___,___,___,___,___,___ ; 8
	_VOL	___,___,___,___,___,___,___,___ ; 9
	_VOL	___,___,___,___,___,___,___,___ ;10
	_VOL	___,___,___,___,___,___,___,___ ;11
	_VOL	___,___,___,___,___,___,___,___ ;12
	_VOL	___,___,___,___,___,___,___,___ ;13
	_VOL	___,___,___,___,___,___,___,___ ;14
	_VOL	___,___,___,___,___,___,___,___ ;15

	_VOL	___,___,___,___,___,___,___,___ ;16
	_VOL	___,___,___,___,___,___,___,___ ;17
	_VOL	___,___,___,___,___,___,___,___ ;18
	_VOL	___,___,___,___,___,___,___,___ ;19
	_VOL	___,___,___,___,___,___,___,___ ;20
	_VOL	___,___,___,___,___,___,___,___ ;21
	_VOL	___,___,___,___,___,___,___,___ ;22
	_VOL	___,___,___,___,___,___,___,___ ;23
	_VOL	___,___,___,___,___,___,___,___ ;24
	_VOL	___,___,___,___,___,___,___,___ ;25
	_VOL	___,___,___,___,___,___,___,___ ;26
	_VOL	___,___,___,___,___,___,___,___ ;27
	_VOL	___,___,___,___,___,___,___,___ ;28
	_VOL	___,___,___,___,___,___,___,___ ;29
	_VOL	___,___,___,___,___,___,___,___ ;30
	_VOL	___,___,___,___,___,___,___,___ ;31
	
	RET
.endproc

