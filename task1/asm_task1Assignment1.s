
section .data
    checkValidityResult: dd 0
    fmtd: db "%d", 10, 0
section .text
    extern c_checkValidity
    extern printf
    global assFunc

assFunc:
    push ebp
    mov ebp, esp	
    pushad
    mov ecx, [ebp + 8]
    push ecx
    call c_checkValidity
    add esp, 4
    mov [checkValidityResult], eax
    cmp dword [checkValidityResult], 0
    je uneven
    jge even

    uneven:
        shl ecx, 3
        push ecx
        jmp continue
    
    even:
        shl ecx, 2
        push ecx
        jmp continue
    
    continue:
        push fmtd
        call printf
        add esp, 8
        popad
        mov esp, ebp
        pop ebp
        ret



    
