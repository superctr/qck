;==============================================================================
;
;  Add pitch envelopes here
;
;==============================================================================

	.export tab_pitenv
	.segment "BANK0"

	.include "pitenv.inc"

tab_pitenv:
	.addr		pitch_1,pitch_2,pitch_3,pitch_4
	.addr		pitch_5,pitch_6,pitch_7,pitch_8,pitch_9
	
	.addr		pitch_10,pitch_11,pitch_12,pitch_13,pitch_14
	.addr		pitch_15,pitch_16,pitch_17,pitch_18,pitch_19
	
	.addr		pitch_20,pitch_21,pitch_22,pitch_23,pitch_24
	.addr		pitch_25,pitch_26,pitch_27,pitch_28,pitch_29
	
pitch_1:
	.byte	50,255,30,80,99,100,100,100,100,STOP

pitch_2:
	.byte	60,40, 50,60,70,80,90,100,STOP
	
pitch_3:
	.byte	20,20, 100,100,CONT
pitch_4:
	.byte	30,20, 100,100,100,90,80,70,60,50,STOP
	
; tracker style arpeggio
; best to keep the speed at 255 and just add more values
; if you want to make it slower
pitch_5:
	.byte	255,ARP,U0,U0,U3,U3,U5,U5,LOOP

pitch_6:
	.byte	20,20, 50,100,STOP
pitch_7:
	.byte	10,20, 50,100,STOP
pitch_8:
	.byte	5,20,  50,100,STOP
pitch_9:
	.byte	3,20,  50,100,STOP
pitch_10:
	.byte	60,10, 50,100,90,80,90,100,STOP
pitch_11:
	.byte	40,40, 100,90,80,70,60,50,40,30,20,10,STOP
pitch_12:
	.byte	25,250, 100,90,80,70,60,50,40,30,20,10,STOP
pitch_13: ; vibrato+delay
	.byte	10,0, 100,100,CONT
pitch_14: ; vibrato
	.byte	35,75, 100,101,100,99,LOOP
pitch_15:
	.byte	255,ARP,U0,U0,U7,U7,U0,LOOP
pitch_16: ;        0   1   2   3   4   5   6   7   8
	.byte	1,123, 150,100,050,0,   STOP
pitch_17:
	.byte	20,10,  50,100,STOP
pitch_18:
	.byte	40,75,	100,101,102,103,104,105,STOP
pitch_19:
	.byte	255,ARP,U0,U0,U3,U3,U5,U5,LOOP
	
pitch_20:
	.byte	140,150, 100,101,102,101,100,99,98,99,LOOP
pitch_21:
	.byte	10,0, 100,100,CONT
	.byte	120,125, 100,101,102,101,100,99,98,99,LOOP
pitch_22:
	.byte	180,75,  230,230,230,230,230,100,100,STOP
pitch_23:
pitch_24:
pitch_25:
pitch_26:
pitch_27:
pitch_28:
pitch_29:
	.byte	20,20, 100,100,CONT