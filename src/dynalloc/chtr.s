;****************************************
; extreme optimization measures in place
;****************************************

	.export chtr

	.export chtr_a   ,chtr_b   ,chtr_c   ,chtr_d
	.import chtr_a_id,chtr_b_id,chtr_c_id,chtr_d_id
	
	.include "song.inc"
	.include "dynalloc.inc"
	
	.segment "BANK2"
	
.proc chtr

	TEMPO	140
	SPEED	1
	
	CALL	dynalloc_init
	SET		r07,140
	MSG		"CHRONO TRIGGER - Wings of Time"
	TRACK	01,chtr_a_id
	TRACK	02,chtr_b_id
	TRACK	03,chtr_c_id
	TRACK	04,chtr_d_id
	
	preset	1,41,10,2,0,0,12,0,Cn5
	
bar01:
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L8,L16
	note	1,Fn4,0,L4
	note	1,Fn4,0,L8,L16
	note	1,Fn4,0,L8,L16
	note	1,Fn4,0,L8,L16
	RR
bar02:
	note	1,Ds4,0,L8,L16
	note	1,Ds4,0,L8,L16
	note	1,Ds4,0,L8,L16
	note	1,Dn4,0,L4
	note	1,Dn4,0,L8,L16
	note	1,Dn4,0,L8,L16
	note	1,Dn4,0,L8,L16
	RR
bar03:
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L4
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L8,L16
	note	1,Gn4,0,L8,L16
	REPT	1,bar03
bar05:
	note	1,Gn3,0,L8,L16
	REPT	15,bar05
bar07:
	note	1,An3,0,L8,L16
	REPT	15,bar07
bar09:
	note	1,Gn3,0,L8,L16
	REPT	15,bar09
bar11:
	note	1,Ds4,0,L8,L16
	REPT	15,bar11
bar13:
	note	1,As3,0,L8,L16
	REPT	7,bar13
bar14:
	note	1,An3,0,L8,L16
	REPT	7,bar14
bar15:
	note	1,Dn4,0,L8,L16
	REPT	6,bar15
	note	1,Ds4,0,L4
	RR
bar16:
	note	1,Ds4,0,L8,L16
	REPT	6,bar16
bar17:
	note	1,As3,0,L8,L16
	REPT	7,bar17
bar18:
	note	1,Cn4,0,L8,L16
	REPT	7,bar18
bar19:
	note	1,Dn4,0,L8,L16
	REPT	15,bar19
	REPT	1,bar05
bar37:
	note	1,Fn3,0,L8D
	note	1,Fn3,0,L8D
	note	1,Fn3,0,L4
	note	1,Cn4,0,L8
	note	1,Fn4,0,L8
	note	1,Fn3,0,L4
	note	1,Fn3,0,L4D
	note	1,Fn3,0,L8D
	note	1,Cn4,0,L8D
	note	1,Fn4,0,L8
bar39:
	note	1,Bn3,0,L8D
	note	1,Bn3,0,L8D
	note	1,Bn3,0,L4
	note	1,Fs4,0,L8
	note	1,Bn4,0,L8
	note	1,Bn3,0,L4
	note	1,Bn3,0,L4D
	note	1,Bn3,0,L8D
	note	1,Fs4,0,L8D
	note	1,Bn4,0,L8
bar41:
	note	1,As3,0,L8D
	note	1,As3,0,L8D
	note	1,As3,0,L4
	note	1,Fn4,0,L4
	note	1,As4,0,L4
	note	1,As3,0,L4
	note	1,As3,0,L8
	note	1,As3,0,L8D
	note	1,Fn4,0,L8D
	note	1,As4,0,L8
bar43:
	note	1,Ds4,0,L8D
	note	1,As4,0,L8D
	note	1,Ds5,0,L4
	note	1,Cs5,0,L4
	note	1,Ds5,0,L4
	note	1,As4,0,L4
	note	1,Cs5,0,L4
	note	1,Gs4,0,L8
	note	1,As4,0,L4
	REPT	1,bar37
	JUMP	bar01
	
	RET
.endproc

.proc chtr_a

	TEMPO	140
	SPEED	1
	
	preset	2,3,60,2,0,0,0,0,Cn5
	
bar01:
	note2	2,As4,0,L4D
	note2	2,Dn5,0,L4D
	note	2,Fn5,0,L4D

	note2	2,As4,0,L2+L8
	note2	2,Cn5,0,L2+L8
	note	2,Fn5,0,L2+L8
	
	note2	2,As4,0,L4D
	note2	2,Dn5,0,L4D
	note	2,Gn5,0,L4D

	note2	2,As4,0,L2+L8
	note2	2,Cn5,0,L2+L8
	note	2,Fn5,0,L2+L8
	
bar03:
	note2	2,Cn5,0,L2+L8
	note2	2,Dn5,0,L2D
	note2	2,Gn5,0,L2+L4D,L2+L8
	
	note2	2,Cn5,0,L4D,L8
	note2	2,Dn5,0,L4,L8
	note2	2,Gn5,0,L8,L8
	
	note2	2,Bn4,0,L2+L8
	note2	2,Dn5,0,L2+L8
	note	2,Gn5,0,L2+L8
	
	note2	2,Bn4,0,L8D
	note2	2,Dn5,0,L8D
	note	2,Gn5,0,L8D
	
	note2	2,Bn4,15,L8
	note2	2,Dn5,15,L8
	note	2,Gn5,15,L8
	
	note2	2,Bn4,30,L16
	note2	2,Dn5,30,L16
	note	2,Gn5,30,L16
	
bar05:
	note2	2,As4,0,L8D
	note2	2,Fn5,0,L8D
	note	2,Cn6,0,L8D

	note2	2,As4,0,L8D
	note2	2,Fn5,0,L8D
	note	2,Cn6,0,L8D

	note2	2,As4,0,L2D
	note2	2,Fn5,0,L2D
	note	2,Cn6,0,L2D

	note2	2,As4,0,L8D
	note2	2,Fn5,0,L8D
	note	2,Cn6,0,L8D

	note2	2,As4,0,L8D
	note2	2,Fn5,0,L8D
	note	2,Cn6,0,L8D

	note2	2,As4,0,L2+L8
	note2	2,Fn5,0,L2+L8
	note	2,Cn6,0,L2+L8
	
bar07:
	note2	2,En5,0,L4D
	note2	2,Gn5,0,L4D
	note	2,Dn6,0,L4D

	note2	2,Cn5,0,L2
	note2	2,En5,0,L2
	note	2,Cn6,0,L2
	
	note2	2,Bn4,0,L8D
	note2	2,Dn5,0,L8D
	note	2,Bn5,0,L8D

	note2	2,Cn5,0,L4+L16
	note2	2,En5,0,L4+L16
	note	2,Cn6,0,L4+L16

	note2	2,Cn5,0,L16
	note2	2,En5,0,L16
	note	2,Cn6,0,L16

	note2	2,Cn5,0,L8
	note2	2,En5,0,L8
	note	2,Cn6,0,L8
	
	note2	2,Cn5,0,L8
	note2	2,En5,0,L8
	note	2,Cn6,0,L8
	
	note2	2,Cn5,15,L8
	note2	2,En5,15,L8
	note	2,Cn6,15,L8
	
	note2	2,Cn5,30,L16
	note2	2,En5,30,L16
	note	2,Cn6,30,L16

bar09:
	note2	2,As4,0,L8
	note2	2,Fn5,0,L4
	note	2,Cn6,0,L8

	note2	2,As4,0,L4,L8
	note2	2,Fn5,0,L8,L8
	
	note2	2,As4,0,L2D
	note2	2,Fn5,0,L2D
	note	2,Cn6,0,L2D

	note2	2,As4,0,L8D
	note2	2,Fn5,0,L8D
	note	2,Cn6,0,L8D

	note2	2,As4,0,L8D
	note2	2,Fn5,0,L8D
	note	2,Cn6,0,L8D

	note2	2,As4,0,L2
	note2	2,Fn5,0,L2
	note	2,Cn6,0,L2

bar11:
	note2	2,Fn5,0,L4D
	note2	2,An5,0,L4D
	note	2,Cn6,0,L4D

	note2	2,Fn5,0,L2
	note2	2,An5,0,L2
	note	2,Cn6,0,L2
	
	note2	2,Ds5,0,L4D
	note2	2,Gn5,0,L4D
	note	2,As5,0,L4D
	
	note2	2,Ds5,0,L4D
	note2	2,Gn5,0,L4D
	note	2,As5,0,L4D
	
	note2	2,Fn5,0,L4
	note2	2,An5,0,L4
	note	2,Cn6,0,L4
	
	note2	2,Ds5,0,L8
	note2	2,Gn5,0,L8
	note	2,As5,0,L8
	
bar13:
	note2	2,Dn5,0,L2+L8
	note2	2,Fn5,0,L2D
	note2	2,An5,0,L2+L4D,L2+L8

	note2	2,Dn5,0,L4D,L8
	note2	2,Fn5,0,L4,L8
	note2	2,An5,0,L8,L8

	note2	2,Cn5,0,L4D
	note2	2,En5,0,L2+L8
	note2	2,Gn5,0,L2D,L4D

	note2	2,Cn5,0,L2,L4
	note2	2,En5,0,L4,L8
	note2	2,Gn5,0,L8,L8
	
	note2	2,Cn5,0,L2+L8
	note2	2,Fn5,0,L2+L8
	note	2,An5,0,L2+L8
	
bar15:
	note2	2,Cn5,0,L4D
	note2	2,Fn5,0,L4D
	note	2,An5,0,L8D
	
	note	2,Cn6,0,L8D
	
	note2	2,As4,0,L1+L8
	note2	2,Dn5,0,L1+L8
	note	2,Gn5,0,L1+L8
	
bar17:	; a real mess
	note2	2,As4,0,L4D
	note2	2,Dn5,0,L4D
	note	2,Fn5,0,L4D-L16
	
	note2	2,Fn5,0,L2D+L16,L16
	note2	2,As4,0,L2
	note	2,Dn5,0,L2
	
	note2	2,As4,0,L2
	note2	2,Dn5,0,L2,L4
	note	2,Gn5,0,L8D
	
	note2	2,Gn5,0,L4+L16,L16
	note2	2,Gn4,0,L2+L8
	note2	2,Cn5,0,L2+L4+L16,L4
	note	2,Gn5,0,L4D
	
bar19:
	note2	2,Dn5,0,L4D,L8D
	note2	2,Gn5,0,L8D
	note	2,An5,0,L8D

	note2	2,Dn5,0,L4
	note2	2,Gn5,0,L4
	note	2,An5,0,L4

	note2	2,Dn5,0,L4
	note2	2,Gn5,0,L4
	note	2,An5,0,L4
	
	note2	2,Dn5,0,L2D
	note2	2,Fs5,0,L2D
	note2	2,An5,0,L2D,L8
	
	LOOP	1,bar36
bar20:
	rest	L2+L8
	
	note2	2,Dn5,0,L4D,L8
	note2	2,Fs5,0,L4,L8
	note2	2,An5,0,L8,L8
	JUMP	bar05
	
bar36:
	rest	L1
	RR
bar37:
	note2	2,Gs4,0,L8D
	note2	2,Ds5,0,L8D
	note	2,Gn5,0,L8D
	
	note2	2,Gs4,0,L8D
	note2	2,Ds5,0,L8D
	note	2,Gn5,0,L8D
	
	note2	2,Gs4,0,L2
	note2	2,Ds5,0,L2
	note	2,Gn5,0,L2
	
	note2	2,Gs4,0,L4
	note2	2,Ds5,0,L4
	note	2,Gn5,0,L4
	
	note2	2,Gs4,0,L4D
	note2	2,Ds5,0,L4D
	note	2,Gn5,0,L4D
	
	note2	2,Gs4,0,L4
	note2	2,Ds5,0,L4
	note	2,Gn5,0,L4
	
	note2	2,Gs4,0,L4
	note2	2,Ds5,0,L4
	note	2,Gn5,0,L4
	
bar39:
	note2	2,Ds5,0,L8D
	note2	2,Fs5,0,L8D
	note	2,As5,0,L8D
	
	note2	2,Ds5,0,L8D
	note2	2,Fs5,0,L8D
	note	2,As5,0,L8D
	
	note2	2,Ds5,0,L2
	note2	2,Fs5,0,L2
	note	2,As5,0,L2
	
	note2	2,Ds5,0,L4
	note2	2,Fs5,0,L4
	note	2,As5,0,L4
	
	note2	2,Ds5,0,L4D
	note2	2,Fs5,0,L4D
	note	2,As5,0,L4D
	
	note2	2,Ds5,0,L4
	note2	2,Fs5,0,L4
	note	2,As5,0,L4
	
	note2	2,Ds5,0,L4
	note2	2,Fs5,0,L4
	note	2,As5,0,L4

bar41:
	note2	2,Cs5,0,L8D
	note2	2,Ds5,0,L8D
	note	2,Gs5,0,L8D
	
	note2	2,Cs5,0,L8D
	note2	2,Ds5,0,L8D
	note	2,Gs5,0,L8D
	
	note2	2,Cs5,0,L2
	note2	2,Ds5,0,L2
	note	2,Gs5,0,L2
	
	note2	2,Cs5,0,L4
	note2	2,Ds5,0,L4
	note	2,Gs5,0,L4
	
	note2	2,Cs5,0,L4D
	note2	2,Ds5,0,L4D
	note	2,Gs5,0,L4D
	
	note2	2,Cs5,0,L4
	note2	2,Ds5,0,L4
	note	2,Gs5,0,L4
	
	note2	2,Cs5,0,L4
	note2	2,Ds5,0,L4
	note	2,Gs5,0,L4

bar43:
	note2	2,Gs4,0,L8D
	note2	2,Cs5,0,L8D
	note	2,Fn5,0,L8D
	
	note2	2,Gs4,0,L8D
	note2	2,Cs5,0,L8D
	note	2,Fn5,0,L8D
	
	note2	2,Gs4,0,L2
	note2	2,Cs5,0,L2
	note	2,Fn5,0,L2
	
	note2	2,Gs4,0,L4
	note2	2,As4,0,L4
	note	2,Ds5,0,L4
	
	note2	2,Gn4,0,L4D
	note2	2,As4,0,L4D
	note	2,Ds5,0,L4D
	
	note2	2,Gn4,0,L4
	note2	2,As4,0,L4
	note	2,Ds5,0,L4
	
	note2	2,Gn4,0,L4
	note2	2,As4,0,L4
	note	2,Ds5,0,L4
	
	REPT	1,bar37
	JUMP	bar01
	
	RET

.endproc

.proc chtr_b

	TEMPO	140
	SPEED	1
	
	preset	3,3,25,2,0,0,0,0,Cn5
	preset	4,45,40,2,0,14,0,0,Cn5
	
bar01:
	note	3,As5,0,L8
	note	3,An5,0,L8
	note	3,As5,0,L8
	note	3,An5,0,L4
	note	3,Gn5,0,L4
	note	3,Fn5,0,L8

	note	3,Gn5,0,L8
	note	3,Fn5,0,L8
	note	3,Gn5,0,L8
	note	3,Fn5,0,L4
	note	3,Dn5,0,L4
	note	3,Fn5,0,L4
	
	note	3,Gn5,0,L8,L16
	note	3,Gn5,0,L2D+L1
	RR
	
bar05:
	rest	L4D
	note	4,As4,0,L8
	note	4,As4,0,L8D
	note	4,Cn5,0,L8D
	note	4,Dn5,0,L8
	note	4,Fn5,0,L4D
	note	4,Fn5,0,L4
	note	4,Fs5,0,3
	note	4,Gn5,0,L4-3
	note	4,Dn5,0,L8
	note	4,Dn5,0,L4D
	note	4,En5,0,L16
	note	4,Dn5,0,L16
	note2	4,Cn5,0,L1+L1-L8,L1+L2
	
bar09:
	rest	L4D
	note	4,As4,0,L8
	note	4,As4,0,L8D
	note	4,Cn5,0,L8D
	note	4,Dn5,0,L8
	note	4,Fn5,0,L4D
	note	4,Fn5,0,L4
	note	4,Gn5,0,L4
	note	4,An5,0,L16
	note	4,Fn5,0,L16
	note	4,An5,0,L2+L4D
	note	4,Gn5,0,L2
	note	4,Gn5,0,L4
	note	4,An5,0,L4
	note	4,As5,0,L16
	note	4,Cn6,0,L16
	
bar13:
	note	4,Dn6,0,L2+L8
	note	4,An5,0,L4
	note	4,Cn6,0,L4
	note	4,Gn5,0,L4
	note	4,Fn5,0,L4
	note	4,Gn5,0,L4
	note	4,Fn5,0,L2+L8
	note	4,Dn5,0,L8D
	note	4,Fn5,0,L8D
	note	4,Gn5,0,L1

	note	4,En5,0,3
	note2	4,Fn5,0,L2-3,L8-3
	
bar17:
	rest	L4D
	note	4,Dn5,0,L2
	note	4,En5,0,3
	note	4,Fn5,0,L4-3
	note	4,En5,0,L4
	note	4,Dn5,0,L4
	note	4,Cn5,0,L4
	note2	4,Dn5,0,L8+L1+L1,L1+L8
	
	LOOP	1,bar36
bar20:
	rest	L1
	JUMP	bar05
bar36:
	rest	L2
	note	3,Cs6,0,3
	note	3,Dn6,0,L4-3
	note	3,An5,0,L8
bar37:	; -L8
	note	3,As5,0,L1+L8
	note	3,Gs5,0,L16
	note	3,As5,0,L8
	note	3,As5,0,L4+L16
	note	3,Gs5,0,L16
	note	3,As5,0,L8
	note	3,As5,0,L4+L16
	
	note	3,As5,0,L8D
	note	3,Bn5,0,L8D
	note	3,Cs6,0,L8
	note	3,Ds6,0,L8D
	note	3,As6,0,L8D
	note	3,Fs6,0,L8+L2D
	note	3,Ds6,0,L4
	
bar41:
	note	3,Fn6,0,L8D
	note	3,Fs6,0,L8D
	note	3,Fn6,0,L4
	note	3,Ds6,0,L4
	note	3,Cs6,0,L8+L2D
	note	3,As5,0,L4
	
	note	3,Cs6,0,L2+L4D
	note	3,Cs6,0,L16
	note	3,Dn6,0,L16
	note	3,Ds6,0,L1
	
bar45:
	rest	L2
	note	3,An5,0,3
	note	3,As5,0,L8D-3
	note	3,Gs5,0,L8D
	note	3,Gn5,0,L4
	note	3,Gs5,0,L4
	note	3,As5,0,L4
	note	3,Cn6,0,L4
	note	3,Ds6,0,L8
	note	3,Ds6,0,L2D+L8
	
	note	3,Ds6,0,L16
	note	3,Fn6,0,L16
	note	3,Fs6,0,L8D
	note	3,Fn6,0,L8D
	note	3,Ds6,0,L4
	note	3,Cs6,0,L4
bar51: ; -L8
	note	3,Ds6,0,L4
	note	3,As5,0,L4
	note	3,Gs5,0,L2+L8
	rest	L1
	rest	L1
	rest	L1
	JUMP	bar01

	RET
	
.endproc

.define	bdr 128+10
.define	sdr 128+11
.define hhc 128+13
.define hho 128+14

.proc chtr_c

	TEMPO	140
	SPEED	1
	
	preset	7,12,0,0,0,0,0,0,Cn5
	preset	8,12,0,0,12,0,0,0,Cn5
	
bar01:
	CALL	pat00
	CALL	pat00
	CALL	pat00
	CALL	pat01
bar05:
	CALL	pat02	;5
	CALL	pat03	;6
	REPT	4,bar05	;7,8 9,10 11,12 13,14
	CALL	pat04	;15
	CALL	pat05	;16
	CALL	pat04	;17
	CALL	pat04	;18
	CALL	pat04	;19
	CALL	pat06	;20
	REPT	1,bar05
bar37:
	CALL	pat02
	REPT	6,bar37
	CALL	pat07
	REPT	1,bar37
	JUMP	bar01	
	RET
	
pat00:
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	REPT	3,pat00
	RET
pat01:
	note2	7,bdr,0,L4,L16
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L8
	
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	7,sdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L16
	note2	7,sdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hho,50,L8,L16
	note2	7,sdr,0,L4,L16
	RET
pat02:
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16

	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	RET
pat03:
	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16

	note2	8,hhc,25,L16,L16
	note2	7,bdr,0,L4,L16
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	RET
pat04:
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16

	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	RET
pat05:
	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16

	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	
	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L16
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hho,50,L16,L16
	note2	7,sdr,0,L4,L16
	RET
pat06:
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16

	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L16
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hho,50,L16,L16
	note2	7,sdr,0,L4,L16
	RET
pat07:
	note2	7,bdr,0,L4
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16

	note2	8,hhc,25,L16,L8
	note2	7,bdr,0,L4
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	8,hhc,25,L16,L8
	note2	8,hhc,50,L16,L16
	note2	8,hhc,50,L16,L16
	
	note2	7,sdr,0,L4
	note2	8,hhc,25,L16,L16
	note2	8,hhc,50,L16,L16
	note2	8,hho,50,L16,L8
	RET
.endproc

.proc chtr_d

	TEMPO	140
	SPEED	1
	
	preset	5,44,10,2,<-10,0,0,0,Cn5
	preset	6,45,45,2,0,14,0,0,Cn5
	
bar01:

	rest	L1
	rest	L1
	rest	L1
	rest	L1
	RR
bar05:
	rest	L8
	note	5,En4,0,L8
	note	5,Fn4,0,L4
	note	5,Fn4,0,L16
	note	5,En4,0,L8
	note	5,Fn4,0,L4+L16
bar06:
	rest	L8
	note	5,Fn4,0,L8
	note	5,Fn4,0,L8
	note	5,En4,0,L8
	note	5,Fn4,0,L16
	note	5,En4,0,L8
	note	5,Fn4,0,L4+L16
bar07:
	rest	L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,An4,0,L8
	note	5,En4,0,L8
	note	5,Dn4,0,L16
	note	5,En4,0,L4+L16
bar08:
	rest	L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,An4,0,L8
	note	5,En4,0,L8
	note	5,Dn4,0,L16
	note	5,En4,0,L8
	note	5,Dn4,0,L8
	note	5,En4,0,L16
bar09:
	rest	L4
	note	5,Fn4,0,L4
	note	5,Fn4,0,L16
	note	5,En4,0,L8
	note	5,Fn4,0,L4+L16
bar10:
	rest	L8
	note	5,Fn4,0,L8
	note	5,Fn4,0,L8
	note	5,En4,0,L8
	note	5,Fn4,0,L16
	note	5,En4,0,L8
	note	5,Fn4,0,L4+L16
bar11:
	rest	L8
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,Gn4,0,L8
	note	5,An4,0,L8D
	note	5,An4,0,L8D
	note	5,Gn4,0,L16
	note	5,An4,0,L16
bar12:
	rest	L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,Fn4,0,L8
	note	5,Gn4,0,L8
	note	5,Fn4,0,L16
	note	5,Gn4,0,L8
	note	5,Gn4,0,L16
	note	5,Fn4,0,L16
	note	5,Gn4,0,L16
bar13:
	note	5,Gn4,0,L4
	note	5,Fn4,0,L4
	note	5,Fn4,0,L8
	note	5,Fn4,0,L16
	note	5,Dn4,0,L8
	note	5,Dn4,0,L8D
bar14:
	rest	L4
	note	5,En4,0,L4
	note	5,En4,0,L8
	note	5,En4,0,L16
	note	5,Cn4,0,L8
	note	5,Cn4,0,L8D
bar15:
	rest	L4
	note	5,Dn4,0,L4
	note	5,En4,0,L8
	note	5,Fn4,0,L8
	note	5,Gn4,0,L4
bar16:
	rest	L8
	note	5,Gn4,0,L8
	note	5,Fn4,0,L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L16
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,Fn4,0,L16
	note	5,Gn4,0,L8
bar17:
	rest	L16
	note	5,Fn4,0,L16
	note	5,Fn4,0,L8
	note	5,Fn4,0,L8
	note	5,Fn4,0,L8
	note	5,Fn4,0,L16
	note	5,Fn4,0,L8
	note	5,Fn4,0,L8
	note	5,Fn4,0,L8
	note	5,Fn4,0,L16
bar18:
	rest	L16
	note	5,Gn4,0,L8
	note	5,Gn4,0,L16
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L16
	note	5,Gn4,0,L8
	note	5,Gn4,0,L8
	note	5,Gn4,0,L16
bar19:
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,Gn4,0,L16
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,An4,0,L16
	note	5,An4,0,L8
	note	5,An4,0,L8
bar20:
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,An4,0,L16
	note	5,An4,0,L8
	note	5,An4,0,L16
	note	5,An4,0,L8
	note	5,An4,0,L8
	note	5,An4,0,L16
	note	5,An4,0,L16
	REPT	1,bar05
bar37:
	rest	L1
	rest	L1
	rest	L1
bar40:
	rest	L8
	note	6,As5,0,L8D
	note	6,Gs5,0,L8D
	note	6,Fs5,0,L8D
	note	6,Fn5,0,L8D
	note	6,Ds5,0,L8
bar41:
	note	6,Cs5,0,L8D
	note	6,Ds5,0,L8D
	note	6,As4,0,L1+L4
	note	6,Gs4,0,L8
	note	6,As4,0,L8
bar43: ; -L8
	note	6,Cs5,0,L4
	note	6,Gs4,0,L8
	note	6,As4,0,L8
	note	6,Cs5,0,L4
	note	6,Gs4,0,L8
	note	6,Cs5,0,L8
	note	6,Ds5,0,L8+L1
bar45:
	rest	L1
	rest	L1
bar47:
	rest	L4D
	note	6,As5,0,L4
	note	6,Gs5,0,L4
	note	6,Cs6,0,L4
	note	6,As5,0,L4
	note	6,Gs5,0,L4
	note	6,As5,0,L4
bar51: ; -L8
	note	6,Ds5,0,L4
	note	6,Cs5,0,L8
	note	6,Ds5,0,L2D+L8
	note	6,Cs5,0,L8
	note	6,Ds5,0,L8
	note	6,Fn5,0,L8
	note	6,Fs5,0,L8
	note	6,Fn5,0,L8
	note	6,Fs5,0,L8
	note	6,Gs5,0,L8
bar53:
	note	6,As5,0,L8D
	note	6,Gs5,0,L8D
	note	6,As5,0,L8
	note	6,Cs6,0,L8D
	note	6,As5,0,L8D
	note	6,Cs6,0,L16
	note	6,Dn6,0,L16
	note	6,Ds6,0,L1

	JUMP	bar01
	
	RET

.endproc