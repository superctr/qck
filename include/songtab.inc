;==============================================================================
;
;  Song table macros and defines
;
;==============================================================================

; These macros are available in song tables:
; SONG label, <export>
;   label:  This is exported by the song source file and should point to the
;   song data
; 
;   export: The song ID will be exported. This can be used for "start subsong"
;   commands, for example.
;

	.list -	

.macro SONG addr, export
	.ifndef addr
		.import addr
	.endif
	.addr	addr
	.byt	<.BANK(addr)
	.ifnblank export
		.export export: absolute = SONGID
	.endif
	SONGID .set SONGID + 1
.endmacro

	.list +
	
SONGID	.set 0