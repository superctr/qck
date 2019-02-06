
	.export sharrier

	.export sharrier_a, sharrier_b
	.import sharrier_a_id,sharrier_b_id
	
	.include "song.inc"
	.include "dynalloc.inc"
	
	.segment "BANK2"
	
.proc sharrier

	TEMPO	120
	SPEED	1
	
	CALL	dynalloc_init
	SET		r07,120
	
	preset	1,2,25,4,0,0,0,0,Cn5
	preset	2,5,10,2,0,0,12,0,Cn5
	preset	3,12,0,0,0,0,0,0,Cn5
	
	TRACK	1,sharrier_a_id
	TRACK	2,sharrier_b_id
	
pos00:
	note2	1,En4,0,L2D
	note2	1,Gn4,0,L2D
	note	1,Cn5,0,L2D
	
	note2	1,En4,0,L8
	note2	1,Gn4,0,L8
	note	1,Cn5,0,L8
	
	note2	1,Fn4,0,L8+L1
	note2	1,An4,0,L8+L1
	note	1,Cn5,0,L8+L1
	
	note2	1,Fn4,0,L2+L8
	note2	1,Gs4,0,L2+L8
	note	1,Cn5,0,L2+L8
	
	note2	1,Fn4,0,L8
	note2	1,Gs4,0,L8
	note	1,Cn5,0,L8
	
	rest	L8
	
	note2	1,En4,0,L8+L1
	note2	1,Gn4,0,L8+L1
	note	1,Cn5,0,L8+L1
	
	REPT	1, pos00
	
pos02:
	note2	1,Gn4,0,L2D
	note2	1,En5,0,L2D
	note2	1,Gn5,0,L2D
	note	1,Cn6,0,L2D
	
	note2	1,Gn4,0,L8
	note2	1,En5,0,L8
	note2	1,Gn5,0,L8
	note	1,Cn6,0,L8
	
	note2	1,An4,0,L8+L1
	note2	1,Fn5,0,L8+L1
	note2	1,An5,0,L8+L1
	note	1,Cn6,0,L8+L1
	
	note2	1,Gs4,0,L2+L8
	note2	1,Fn5,0,L2+L8
	note2	1,Gs5,0,L2+L8
	note	1,Cn6,0,L2+L8
	
	note2	1,Gs4,0,L8
	note2	1,Fn5,0,L8
	note2	1,Gs5,0,L8
	note	1,Cn6,0,L8
	
	rest	L8
	
	note2	1,Gn4,0,L8+L1
	note2	1,En5,0,L8+L1
	note2	1,Gn5,0,L8+L1
	note	1,Cn6,0,L8+L1
	
pos03:
	note2	1,Gn4,0,L2D
	note2	1,En5,0,L2D
	note2	1,Gn5,0,L2D
	note	1,Cn6,0,L2D
	
	note2	1,Gn4,0,L8
	note2	1,En5,0,L8
	note2	1,Gn5,0,L8
	note	1,Cn6,0,L8
	
	note2	1,An4,0,L8+L1
	note2	1,Fn5,0,L8+L1
	note2	1,An5,0,L8+L1
	note	1,Cn6,0,L8+L1
	
	note2	1,An4,0,L8
	note2	1,Fn5,0,L8
	note2	1,An5,0,L8
	note	1,Dn6,0,L8
	
	note2	1,An4,0,L8
	note2	1,Fn5,0,L8
	note2	1,An5,0,L8
	note	1,Dn6,0,L8
	
	note2	1,An4,0,L8
	note2	1,Fn5,0,L8
	note2	1,An5,0,L8
	note	1,Dn6,0,L8
	
	rest	L4
	
	note2	1,An4,0,L8
	note2	1,Fn5,0,L8
	note2	1,An5,0,L8
	note	1,Dn6,0,L8
	
	rest	L8
	
	note2	1,Gn4,0,L8
	note2	1,En5,0,L8
	note2	1,Gn5,0,L8
	note	1,Cn6,0,L8
	
	rest	L1
	
	RET
	
.endproc

.proc sharrier_a

	TEMPO	120
	SPEED	1
	
pos00:
	note	2,Cn4,0,L8
	note	2,Cn5,0,L8,L16
	note	2,Cn4,0,L8
	note	2,Cn5,0,L8,L16
	note	2,Cn4,0,L8
	note	2,Cn5,0,L8,L16
	note	2,Cn4,0,L8
	note	2,Cn5,0,L8,L16
	REPT	13, pos00
pos03b:
	note	2,Cn4,0,L8
	note	2,Cn4,0,L8
	note	2,Cn4,0,L8
	rest	L4
	note	2,Cn4,0,L4,L8
	note	2,Cn4,0,L4,L8
	rest	L1
	RET


.endproc


.define	bdr 128+10
.define	sdr 128+11
.define hhc 128+13
.define hho 128+14

.proc sharrier_b

	TEMPO	120
	SPEED	1
	
pos00:
	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	REPT	6, pos00

	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,sdr,10,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,bdr,0,L8
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note2	3,bdr,0,L16
	note	3,hhc,75,L16
	note2	3,bdr,0,L16
	note	3,hhc,75,L16
	
	note2	3,sdr,10,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
pos02:
	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,sdr,10,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,bdr,0,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	
	note2	3,sdr,10,L4
	note	3,hhc,25,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	note	3,hhc,75,L16
	REPT	5,pos02
	
	note	3,sdr,10,L8
	note	3,sdr,10,L8	
	note	3,sdr,10,L8
	note2	3,Cn5,25,L8,L16
	note2	3,An4,25,L8,L16
	note	3,Fn4,25,L8
	note	3,sdr,10,L4
	note	3,sdr,10,L4D
	
	RET
	
	note2	3,bdr,0,L16
	note	3,Bn4,25,L16
	note2	3,bdr,0,L8D
	note	3,Bn4,35,L16
	note	3,Bn4,35,L16
	note	3,Bn4,35,L16
	
	note2	3,bdr,0,L16
	note	3,An4,25,L16
	note2	3,bdr,0,L8D
	note	3,An4,35,L16
	note	3,An4,35,L16
	note	3,An4,35,L16
	
	note2	3,bdr,0,L16
	note	3,Gn4,25,L16
	note2	3,bdr,0,L8
	note	3,Gn4,35,L16
	note	3,Gn4,35,L16
	note2	3,bdr,0,L16
	note	3,Gn4,35,L16
	
	RET
	
	
.endproc