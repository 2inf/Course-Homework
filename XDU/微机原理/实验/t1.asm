DATA SEGMENT
    STR1 DB 'PLEASE INPUT NUMBERS WITH SPACE:(0-65535)',13,10,'$'   
    STR2 DB 13,10,'INPUT ERROR! PLEASE INPUT AGAIN:','$'
    STR3 DB 13,10,'INPUT NUMBERS ARE:','$'
    STR4 DB 13,10,'SORTED NUMBERS ARE:','$'
    NUMS DW 100 DUP(?)
DATA ENDS

STACK SEGMENT STACK 'STACK'
    DW 256 DUP(?)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX
    MOV AX, STACK
    MOV SS, AX
    
    XOR SI, SI
    XOR DI, DI
    
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H
    CALL INPUT
    
    MOV CX, DI
    PUSH CX
    
    MOV DX, OFFSET STR3
    MOV AH, 9
    INT 21H
    XOR DI, DI
FOR1:
    CALL PRINT
    ADD DI, 2
    LOOP FOR1
    
    POP CX
    CALL BUBBLESORT
    
    MOV DX, OFFSET STR4
    MOV AH, 9
    INT 21H
    XOR DI, DI
FOR2:
    CALL PRINT
    ADD DI, 2
    LOOP FOR2
    
    MOV AH, 4CH
    INT 21H
    
; �����ӳ���
INPUT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR BX, BX
    
CHECK: ; ������
    MOV AH, 1
    INT 21H
    CMP AL, 0DH ; �س�
    JZ IN_OVER
    CMP AL, 20H ; �ո�
    JZ NUMBER
    SUB AL, 30H
    JL IN_ERROR
    CMP AL, 09H
    JG IN_ERROR
    MOV AH, 0
    XCHG AX, BX
    MOV CX, 10
    MUL CX
    JC IN_ERROR
    ADD AX, BX
    JC IN_ERROR ; ���� 65535 �������
    XCHG AX, BX
    JMP CHECK
    
NUMBER: ; ����Ϊ����
    MOV NUMS[SI], BX
    ADD SI, 2
    INC DI
    XOR BX, BX
    JMP CHECK
IN_ERROR: ; ������ʾ
    XOR BX, BX
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H
    JMP CHECK    
IN_OVER: ; �������
    MOV NUMS[SI], BX
    INC DI
    XOR BX, BX
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
INPUT ENDP

; �����ӳ���
BUBBLESORT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX

    DEC CX
L1:
    XOR SI, SI
    XOR DI, DI
L2:
    MOV AX, NUMS[SI]
    MOV BX, NUMS[SI+2]
    CMP AX, BX
    JB L3
    MOV NUMS[SI], BX
    MOV NUMS[SI+2], AX
L3:
    ADD SI, 2
    INC DI
    CMP DI, CX
    JB L2
    LOOP L1
    
    POP CX
    POP BX
    POP AX
    RET       
BUBBLESORT ENDP

; ���һ�����ӳ���
PRINT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AX, NUMS[DI]
    MOV BX, 10
    MOV CX, 0
INIT:
    XOR DX, DX
    DIV BX ; �� AX �� DX
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
    
    MOV DL, 20H
    MOV AH, 2
    INT 21H
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET        
PRINT ENDP

CODE ENDS
END START