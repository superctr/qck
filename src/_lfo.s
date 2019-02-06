;==============================================================================
;
;  Add LFO presets here
;
;==============================================================================

	.export tab_lfo
	.segment "BANK0"
	.include "lfo.inc"

tab_lfo:
lfo_1:
	.byte	SINE, 30, 27, 0, 27, 3, 127, 30
lfo_2:
	.byte	SINE,100, 10, 0,  0, 3,  10, 50
lfo_3:
	.byte	SINE, 15, 0,  0, 40, 3, 30, 5
lfo_4:
	.byte	SINE,  0, 10, 3, 10, 3, 100, 100
lfo_5:
	.byte	SINE,  0, 15, 2, 15, 2, 100, 100
lfo_6:
	.byte	RANDOM, 0, 6, 2, 6, 2, 127, 30
lfo_7:
	.byte	RANDOM, 0, 5, 2, 5, 2, 127, 30
lfo_8:
	.byte	SINE, 30, 27, 0, 27, 3, 127, 30
lfo_9:
	.byte	SINE, 30, 27, 0, 27, 3, 127, 30
	
lfo_10:
