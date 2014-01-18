;
; Test file for D52.
; This, with the associated test.ctl file, demonstrates the
; use of control file directives.
;
accum	equ	0e0h
;
	org	0
;
start:	nop
	ajmp	main
	ljmp	subrt
;
main:	rr	a
	inc	accum
	inc	12h
	inc	@r0
	inc	@r1
	inc	r0
	jbc	acc.3,label
	acall	subrt
	lcall	subrt
label:	rrc	a
	dec	a
	dec	10h
	dec	@r0
	dec	@r1
	dec	r0
	cjne	a,#12h,label
	mov	dptr,#vectbl
	jmp	@a+dptr
;
subrt:	nop
	nop
	nop
	nop
	nop
	ret
;
vectbl:	dw	subrt
	dw	0
;
mesg:	db	'This is text',0
;
bindat:	db	0,1,2,3
wordat:	dw	10h,20h,30h
;
; random junk to fake out the disassembler
;
	db	80h,29h,44h,33h
;
; valid code:
;
delay:	mov	r0,#5
delay1:	clr	20h
	djnz	r0,delay1
	ret
;
	end
;
