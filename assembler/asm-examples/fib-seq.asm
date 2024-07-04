MAIN:
    LUI R1, 0
    LLI R1, 0

    LUI R2, 0
    LLI R2, 1

    LUI R7, 0
    LLI R7, 3

    LUI R20, 0
    LLI R20, 8

    ADD R1, R2, R3
    CALL FIB

LOOP:
    JMP LOOP

FIB:
    MOV R2, R1
    MOV R3, R2

    ADD R1, R2, R3

    INC R7

    CMP R7, R20
    JNE FIB

    RET
