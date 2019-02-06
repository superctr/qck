;==============================================================================
;
;  Add volume envelopes here
;
;==============================================================================

	.export tab_volenv
	.segment "BANK0"

	.include "volenv.inc"
	
tab_volenv:
	.addr	env_1,env_2,env_3,env_4,env_5,env_6,env_7,env_8,env_9
	
	.addr	env_10,env_11,env_12,env_13,env_14
	.addr	env_15,env_16,env_17,env_18,env_19
	.addr	env_20,env_21,env_22,env_23,env_24
	.addr	env_25,env_26,env_27,env_28,env_29
env_1:
	.byte	125,0,SUST,125,255,STOP

env_2:
	.byte	125,0,SUST,75,100,25,255,STOP

env_3:
	.byte	125,0,SUST,50,100,35,255,STOP
	
env_4:
	.byte	125,0,SUST,80,255,STOP

env_5:
	.byte	75,0,SUST,50,100,25,255,STOP
env_6:
	.byte	127,0,  127,1,  127,0,  127,1,  127,0,  127,1,  127,0,  127,1
	.byte	127,255,127,254,127,255,127,254,127,255,127,254,127,255,127,254
	.byte	CHANGE,0,125,255,STOP
env_7:
	.byte	42,0,42,255,STOP
env_8:
env_9:
	.byte	125,0,SUST,50,100,35,255,STOP

; ==================
; for led storm
; ==================
env_10:
	.byte	125,0,SUST,90,125,40,255,STOP
env_11:
	.byte	100,75,60,0,SUST,80,125,25,255,STOP
env_12:
	.byte	125,0,SUST,75,125,60,255,STOP
env_13:
	.byte	125,125,50,0,SUST,125,255,STOP
env_14:
	.byte	125,0,90,25,SUST,90,125,50,255,STOP
env_15:
	.byte	125,60,75,25,SUST,125,255,STOP
env_16:
	.byte	125,25,SUST,90,125,50,255,STOP
env_17:
env_18:
env_19:
	.byte	125,0,125,255,STOP
	
env_20:
	.byte	125,0,127,40,75,0,SUST,255,STOP
env_21:
	.byte	100,0,SUST,30,45,50,255,STOP
env_22:
env_23:
env_24:
env_25:
env_26:
env_27:
env_28:
env_29:
	.byte	125,0,125,255,STOP
	
	
	
	