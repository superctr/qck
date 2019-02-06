;==============================================================================
;
;  Add pan envelopes here
;
;==============================================================================

	.export tab_panenv
	.segment "BANK0"

	.include "panenv.inc"

tab_panenv:
	.addr	pan_1,pan_2,pan_3,pan_4,pan_5,pan_6,pan_7,pan_8,pan_9
	.addr	pan_10,pan_11,pan_12,pan_13,pan_14
	.addr	pan_15,pan_16,pan_17,pan_18,pan_19
	
pan_1:
	.byte	0,<-64,60,64,<-60,<-64,REST

pan_2:
	.byte	0,3, <-45,<-6,45,6, LOOP

pan_3:
	.byte	<-1,4,<-35,<-12,35,12, LOOP
pan_4:
	.byte	<-1,3,  <-35,<-20,  35,20, LOOP
pan_5:
	.byte	<-1,<-3,  35,20,  <-35,<-20, LOOP
pan_6:
	.byte	<-1,<-0,  45,06,  <-45,<-06, LOOP
pan_7:
pan_8:
pan_9:
	.byte	0,3, <-45,<-6,45,6, LOOP
	
; led storm
pan_10:
	.byte	<-1,  15, <-20,<-15,  20,  15, LOOP
pan_11:
	.byte	<-1,<-15,   20,  15,<-20,<-15, LOOP
pan_12:
	.byte	<-1,  10, <-25,<-10,  25,  10, LOOP
pan_13:
	.byte	<-1,<-10,   25,  10,<-25,<-10, LOOP
pan_14:
	.byte	<-1,   0,   30,  10,<-30,<-10, LOOP
pan_15:
pan_16:
pan_17:
pan_18:
pan_19:
	.byte	0,3, <-45,<-6,45,6, LOOP