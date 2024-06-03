	PRESERVE8
Stack EQU 0x00000100
	AREA STACK, NOINIT, READWRITE
StackMem SPACE Stack
	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD StackMem
	DCD Reset_Handler
	AREA |.text|, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
Reset_Handler_End
	LDR R1,= 0x20000000
	LDR R2, [R1]
	LDR R3, [R1, #4]
	LDR R4, [R1, #8]
	CMP R2, #1
	BNE CHK_SUB
	ADDS R7, R3, R4
	B LAST
CHK_SUB CMP R2, #2
	BNE CHK_MUL
	SUBS R7, R3, R4
	B LAST
CHK_MUL CMP R2, #3
	BNE CHK_DIV
	UMULL R7, R8, R3, R4
	B LAST
CHK_DIV CMP R2, #4
	BNE LAST
	UDIV R7, R3, R4
LAST STR R7, [R1, #20]
	STR R8, [R1, #24]
STOP B STOP
	END