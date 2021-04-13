
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
    mov ecx, [ebp + 8]
    push ecx
    call c_checkValidity
    mov [checkValidityResult], eax
    cmp dword [checkValidityResult], 0
    je uneven
    jge even

    uneven:
        shl ecx, 3
        jmp continue
    
    even:
        shl ecx, 2
        jmp continue
    
    continue:
        push fmtd
        ;pushad ??
        call printf
        add esp, 8
        mov esp, ebp
        pop ebp
        ret



    
