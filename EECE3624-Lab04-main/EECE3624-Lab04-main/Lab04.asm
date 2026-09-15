/**************************************************************************
 *     File: Lab04.asm
 * Lab Name: Lab04 What's Your Calling?
 *   Author: Julia Camille McCamey
 *  Created: Sep 15, 2026
 *
 * This program
 *************************************************************************/ 
 .def n = R16
.def result = R17
.org 0x0000 ; next instruction will be written to address 0x0000
            ; (the location of the reset vector)
rjmp main	; set reset vector to point to the main code entry point

main:       ; jump here on reset

		; initialize the stack (RAMEND = 0x10FF by default for the ATmega128A)
		ldi R16, HIGH(RAMEND)
		out SPH, R16
		ldi R16, low(RAMEND)
		out SPL, R16

		LDI  n, 4	; load a value into n
		PUSH n	; push it on the stack
		CALL factN	; calculate the factorial of n
		POP  result	; pop result off stack
here:
		RJMP here	; loop forever

factN:
	IN YL, SPL
	IN YH, SPH

	LDD  R18, Y+2

	CPI R18, 1
	BREQ BaseCase

recursiveCase:
	MOV R19, R18
	SUBI R19, 1

	PUSH R19
	CALL factN

	POP R20

	MUL R18, R20

	PUSH R0
	ret

BaseCase:
	LDI R21, 1
	PUSH R21
	ret
	; return from the factN subroutine
