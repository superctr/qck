;==============================================================================
;
;  Quattro Creation Kit
;
;  Main header file.
;
;==============================================================================


	.import 	tab_song,tab_wave,tab_pitenv,tab_volenv,tab_panenv,tab_lfo,tab_preset

.segment "DRIVER"

	; sws2000 sound driver
	.incbin	"System12_Ver2.34_Q02N2212_Patch.bin"

.segment "HEADER"

	.addr		tab_song,tab_wave,tab_pitenv,tab_volenv,tab_panenv,tab_lfo,tab_preset

.segment "BANK1"
	.asciiz		"music data copyright 2017 Ian Karlsson / all rights reserved"
