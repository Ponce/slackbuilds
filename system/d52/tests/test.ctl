;
; TEST.CTL - Sample Control File for D52
;
;   Control codes allowed in the CTL file:
;
;  A - Address		Specifies that the word entry is the address of
;			something for which a label should be generated.
;
;  B - Byte binary	Eight bit binary data (db).
;
;  C - Code		Executable code that must be analyzed.
;
;  F - SFR label	Specify name for SFR.
;
;  I - Ignore		Treat as uninitialized space. Will not be dis-
;			assembled as anything unless some other valid
;			code reaches it.
;
;  K - SFR bit		Specify name for SFR bit.
;
;  L - Label		Generate a label for this address.
;
;  M - Memory		Generate a label for bit addressable memory.
;
;  P - Patch		Add inline code (macro, for example)
;
;  R - Register		Specify name for register
;			(instead of rb2r5 for example).
;
;  S - Symbol		Generate a symbol for this value.
;
;  T - Text		ASCII text (db).
;
;  W - Word binary	Sixteen bit binary data (dw).
;
;  X - Operand name	Specify special name for operand.
;
;  # - Comment		Add header comment to output file.
;
;  ! - Inline comment	Add comment to end of line.
;
; example labels:
;
l 0000	start
l 0006	main
l 0016	loop
l 0024	subrtn
l 002a	vectbl
l 002e	message
;
; example symbol:
;
s 12	counter
;
; example ascii text:
;
t 002e-003a
;
; example register names:
;
r 10	reg0
r 12	reg2
;
; example SFR name:
;
f e0	accum
;
; example SFR bit name:
;
k e3	abit3
;
; example memory bit name:
;
m 20	membit
;
; example operand name:
;
x 004a	five
;
; example header comments:
;
# 0024	This is a subroutine.\n
# 002e	't' directive for ascii text\n
# 003b	\nData - 'b' and 'w' directives\n
# 003f
;
; example inline comments:
;
! 0007	note sfr bit def only affects indirect addressing
! 001d	do the loop
! 0024	do nothing routine
! 0025	these nops would not be disassembled
! 0026	without the 'c' directive
! 003b	binary data
! 003f	word data
# 0049	would get junk from 45h to 48h if not for the 'i' directive\n
! 0049	example of operand name 'x' directive
! 004b	'm' bit addressable memory directive
;
; example address table:
;
a 002a-002d
;
; example force disassembly of code (nops):
;
c 0025-0029
;
; example code to ignore:
;
i 0045-0048
;
; example binary data:
;
b 003b-003e
;
; example word data:
;
w 003f-0044
;
; example patch code:
;
p 0003		include "myfile.inc"\n;
;
; end of control file
;
