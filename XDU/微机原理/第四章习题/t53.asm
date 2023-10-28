DATA SEGMENT
    NUMS DW 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 0
    STR DB 'THE ORDER OF QUEUE IS:',13,10,'$'
    CNT DW 0
DATA ENDS

STACK SEGMENT STACK 'STACK'
    DW 100H DUP(?)    
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX
    MOV AX, STACK
    MOV SS, AX
    
    XOR BX, BX ; 当前报的数
    XOR SI, SI
    XOR DI, DI
    
    MOV DX, OFFSET STR
    MOV AH, 9
    INT 21H
    
L0:    
    CMP DI, 34
    JNZ L1
    XOR DI, DI
L1:
    CMP NUMS[DI], 0
    JNZ L2
    ADD DI, 2
    JMP L0
L2:
    INC BX
    CMP BX, 11
    JZ OK
    ADD DI, 2
    JMP L0
OK: 
    PUSH SI ; 打印出列顺序                
    LEA SI, NUMS[DI]
    CALL PRINT
    MOV DL, 32
    MOV AH, 2
    INT 21H
    POP SI
    
    INC CNT
    CMP CNT, 17
    JZ OVER
    XOR BX, BX ; 报数清0
    MOV NUMS[DI], 0
    ADD DI, 2
    JMP L0    
OVER:

    MOV AH, 4CH
    INT 21H 

PRINT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AX, [SI]
    MOV BX, 10
    MOV CX, 0
INIT:
    XOR DX, DX
    DIV BX ; 商 AX 余 DX
    INC CX
    PUSH DX
    CMP AX, 0
    JNZ INIT
OUTPUT:
    POP DX
    OR DX, 30H
    MOV AH, 2
    INT 21H
    LOOP OUTPUT
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT ENDP
    
CODE ENDS
END START