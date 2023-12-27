.MODEL SMALL
.STACK 100h

.DATA
    msg db 'Enter a string: $'
    str db 100 DUP('$')
    len dw ?
    isPalindrome db 'Yes, it is a palindrome.$'
    notPalindrome db 'No, it is not a palindrome.$'

.CODE
MAIN PROC
   .startup

    ; Display message
    MOV AH, 09h
    MOV DX, OFFSET msg
    INT 21h

    ; Read string
    MOV AH, 0Ah
    MOV DX, OFFSET str
    INT 21h

    ; Calculate string length
    LEA SI, str + 2
    MOV CX, 0
    @@loop1:
        MOV AL, [SI]
        CMP AL, '$'
        JE @@end1
        INC SI
        INC CX
        JMP @@loop1
    @@end1:
    DEC CX
    MOV len, CX

    ; Check for palindrome
    LEA SI, str + 2
    LEA DI, str + 2 
    
    
    @@loop2:
        CMP SI, DI
        JAE @@isPalindrome
        MOV AL, [SI]
        MOV BL, [DI]
        CMP AL, BL
        JNE @@notPalindrome
        INC SI
        DEC DI
        JMP @@loop2

    @@isPalindrome:
        MOV AH, 09h
        MOV DX, OFFSET isPalindrome
        INT 21h
        JMP @@exit

    @@notPalindrome:
        MOV AH, 09h
        MOV DX, OFFSET notPalindrome
        INT 21h

    @@exit:
    MOV AH, 4Ch
    INT 21h

MAIN ENDP

END MAIN