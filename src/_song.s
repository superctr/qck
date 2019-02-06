;==============================================================================
;
;  This is the main song table. Add song entries here.
;
;==============================================================================

	.export tab_song
;	.import song000,speakertest,testsong
	
	.include "songtab.inc"

	.segment "BANK0"
	
; Song ID 00 is played automatically when booting
tab_song:
	SONG	song000						; 000
	SONG	speakertest					; 001
	SONG	testsong, exp_testsong		; 002
	SONG	test_temposeq				; 003
	SONG	test_presets				; 004
	SONG	emptysong					; 005
	SONG	emptysong					; 006
	SONG	emptysong					; 007
	SONG	emptysong					; 008
	SONG	emptysong					; 009
	SONG	emptysong					; 00a
	SONG	emptysong					; 00b
	SONG	emptysong					; 00c
	SONG	emptysong					; 00d
	SONG	emptysong					; 00e
	SONG	emptysong					; 00f
	
	SONG	sunkig2						; 010
	SONG	motost						; 011
	SONG	abc_st1a					; 012
	SONG	tze_a						; 013
	SONG	tf4_a						; 014
	SONG	emptysong					; 015
	SONG	emptysong					; 016
	SONG	dynalloc_test				; 017
	SONG	sharrier					; 018
	SONG	chtr						; 019
	SONG	challenge					; 01a
	SONG	quartet						; 01b
	SONG	emptysong					; 01c
	SONG	trademark					; 01d
	SONG	emptysong					; 01e
	SONG	emptysong					; 01f

	SONG	sunkig2,sunkig2_id			; 020
	SONG	sunkig2a,sunkig2a_id		; 021
	SONG	sunkig2b,sunkig2b_id		; 022
	SONG	abc_st1a, abc_st1a_id		; 023
	SONG	abc_st1b, abc_st1b_id		; 024
	SONG	abc_st1c, abc_st1c_id		; 025
	SONG	abc_st1d, abc_st1d_id		; 026
	SONG	abc_st1e, abc_st1e_id		; 027
	SONG	tze_a, tze_a_id				; 028
	SONG	tze_b, tze_b_id				; 029
	SONG	tze_c, tze_c_id				; 02a
	SONG	tze_d, tze_d_id				; 02b
	SONG	tf4_a, tf4_a_id				; 02c
	SONG	tf4_b, tf4_b_id				; 02d
	SONG	tf4_c, tf4_c_id				; 02e
	SONG	tf4_d, tf4_d_id				; 02f
	SONG	motost,motost_id			; 030
	SONG	motost_b,motost_b_id		; 031
	SONG	motost_c,motost_c_id		; 032
	SONG	motost_d,motost_d_id		; 033
	SONG	motost_e,motost_e_id		; 034
	SONG	dynalloc_set0,dynalloc0		; 035
	SONG	dynalloc_set1,dynalloc1		; 036
	SONG	dynalloc_set2,dynalloc2		; 037
	SONG	dynalloc_set3,dynalloc3		; 038
	SONG	emptysong					; 039
	SONG	sharrier_a,sharrier_a_id	; 03a
	SONG	sharrier_b,sharrier_b_id	; 03b
	SONG	chtr_a,chtr_a_id			; 03c
	SONG	chtr_b,chtr_b_id			; 03d
	SONG	chtr_c,chtr_c_id			; 03e
	SONG	chtr_d,chtr_d_id			; 03f
	SONG	challenge_a,challenge_a_id	; 040
	SONG	quartet_a,quartet_a_id		; 041
	SONG	trademark_a,trademark_a_id	; 042
	SONG	trademark_b,trademark_b_id	; 043
	SONG	trademark_c,trademark_c_id	; 044
