.include "m328Pdef.inc"

; Stack setup
ldi r20, high(RAMEND)
out SPH, r20
ldi r20, low(RAMEND)
out SPL, r20

; Constants
.EQU PL = 0xe1
.EQU PH = 0xb7
.EQU QL = 0x37
.EQU QH = 0x9e
.EQU R = 8
.EQU T = 18
.EQU W = 16
.EQU U = 2
.EQU B = 12
.EQU C = 6
.EQU N = 54

; Secret key bytes
	.EQU BY0 = 0x0200
	.EQU BY1 = 0x0201
	.EQU BY2 = 0x0202
	.EQU BY3 = 0x0203
	.EQU BY4 = 0x0204
	.EQU BY5 = 0x0205
	.EQU BY6 = 0x0206
	.EQU BY7 = 0x0207
	.EQU BY8 = 0x0208
	.EQU BY9 = 0x0209
	.EQU BY10 = 0x020A
	.EQU BY11 = 0x020B

; Macros
.MACRO INPUT
    .DEF AH = R16
    ldi AH, high(@0) ; Load high byte of first word
    .DEF AL = R17
    ldi AL, low(@0)  ; Load low byte of first word
    .DEF BH = R18
    ldi BH, high(@1) ; Load high byte of second word
    .DEF BL = R19
    ldi BL, low(@1)  ; Load low byte of second word
.ENDMACRO

.MACRO SECRET_KEY
	LDI R20, @11
	STS BY0, R20
	LDI R20, @10
	STS BY1, R20
	LDI R20, @9
	STS BY2, R20
	LDI R20, @8
	STS BY3, R20
	LDI R20, @7
	STS BY4, R20
	LDI R20, @6
	STS BY5, R20
	LDI R20, @5
	STS BY6, R20
	LDI R20, @4
	STS BY7, R20
	LDI R20, @3
	STS BY8, R20
	LDI R20, @2
	STS BY9, R20
	LDI R20, @1
	STS BY10, R20
	LDI R20, @0
	STS BY11, R20
.ENDMACRO

J_RESET:
    INC YL
    INC YL
    LDI R21, 0x0C ; Ensure YL does not exceed the memory range
    CPSE YL, R21
    RET
    LDI YL, low(0x0220) ; Reset YL to the start of the key table
    RET
