DATA SEGMENT
    STRING DB '***','18020100245','YANG','YANG WEN TAO','***','$'    
    SID DB '18020100245','$'
    SNAME DB 'YANG WEN TAO','$'
    STR1 DB 13,10,'STUDENT ID FOUND AT:','$'
    STR2 DB 13,10,'NAME FOUND AT:','$'
    STR DB 13,10,'THE PATTERN STRING IS:','$'
    LEN DW 33 ; ԭ������
    LEN1 DW 11 ; ѧ�ų���
    LEN2 DW 12 ; ��������
    ADDR DW 1
DATA ENDS

STACK SEGMENT STACK 'STACK'
    DW 64 DUP(?)    
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,ES:DATA,SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX
    MOV AX, STACK
    MOV SS, AX
    
    
    MOV DX, OFFSET STR1 ; SID
    MOV AH, 9
    INT 21H
    ; �󴮳���
    ; LEA SI, STRING
    ; CALL STRLEN
    ; MOV LEN, DI
    
    LEA SI, SID
    MOV DX, LEN1 ; DX �洢ģʽ������
    
    CALL SEARCH
    LEA SI, ADDR
    CALL PRINT
    
    MOV DX, OFFSET STR ; ��ӡģʽ��
    MOV AH, 9
    INT 21H
    
    LEA SI, STRING
    ADD SI, ADDR
    MOV CX, LEN1
    CALL STRPRT
                          
    MOV DX, OFFSET STR2 ; SNAME
    MOV AH, 9
    INT 21H
    
    LEA SI, SNAME
    MOV DX, LEN2
    
    CALL SEARCH
    LEA SI, ADDR
    CALL PRINT
    
    MOV DX, OFFSET STR ; ��ӡģʽ��
    MOV AH, 9
    INT 21H
    
    LEA SI, STRING
    ADD SI, ADDR
    MOV CX, LEN2
    CALL STRPRT
    
    MOV AH, 4CH
    INT 21H
    
SEARCH PROC NEAR: 
    PUSH AX
    PUSH CX
    PUSH DX
    
    LEA DI, STRING
    MOV CX, LEN
    DEC DX
    MOV AL, [SI]
    
    CLD
COMPARE:    
    REPNZ SCASB ; �ҵ���һ����ͬ�ַ�
    JNZ NOTFOUND
    PUSH SI
    INC SI
    PUSH CX
    PUSH DI ; �����һ����ͬ��λ��+1
    MOV CX, DX
    REPZ CMPSB
    POP DI
    POP CX
    POP SI
    JNZ COMPARE
FOUND:
    SUB DI, 1
    MOV ADDR, DI    
NOTFOUND:

    POP DX
    POP CX
    POP AX
    RET
SEARCH ENDP

STRLEN PROC NEAR
    PUSH AX
    PUSH CX
    
    XOR CX, CX
COUNT:
    MOV AL, [SI]
    CMP AL, '$'
    JZ CNTEND
    INC CX
    INC SI
    JMP COUNT
CNTEND:
    MOV DI, CX
    
    POP CX
    POP AX
    RET    
STRLEN ENDP

STRPRT PROC NEAR ; ��ԭ������ʾģʽ��
    PUSH AX
    PUSH CX
    
PRT:
    MOV DL, [SI]
    MOV AH, 2    
    INT 21H
    INC SI
    LOOP PRT
    
    POP CX
    POP AX
    RET    
STRPRT ENDP

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
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT ENDP

CODE ENDS
END START