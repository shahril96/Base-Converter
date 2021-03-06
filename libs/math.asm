%ifndef MATH_ASM
%define MATH_ASM

segment .text

pow:

    ; int __cdecl pow(int base, int n)

    ;---------------------------------------;
    ; README
    ;
    ; This routine take 2 parameter, base and power of N, and return calculation
    ; value by eax.
    ;
    ; - EXAMPLE -
    ;
    ; Input :
    ; base  = 10
    ; n     = 4
    ;
    ; Usage :
    ; push  dword 3
    ; push  dword 10
    ; call  pow
    ; add   esp, 8  ; clear previous pushed parameter
    ;
    ; Output :
    ; eax = 10000
    ;----------------------------------------;

    ; setup stack frame
    push    ebp
    mov     ebp, esp

    ; store 2 registers into stack for future use
    push    ecx             ; ecx gonna hold base
    push    ebx             ; ebx gonna counting

    mov     ebx, [ebp + (8 + 4)]    ; copy N (power of) value into ebx from argument

    ; if (power of) isn't zero, then continue execution
    cmp     ebx, 0
    jne     .pow_continue

    ; if (power of) is zero (which is always 1 in mathematic)
    ; then set return value (eax) into 1, end this routine and return to caller
    mov     eax, 1
    jmp     .pow_end

    .pow_continue:
    xor     eax, eax                ; eax = 0, eax gonna hold value
    mov     ecx, [ebp + (8 + 0)]    ; copy base from argument into ecx
    mov     eax, ecx                ; copy base into eax (temporary)
    dec     ebx

    .pow_loop:

    ; if ebx (counting) already 0, then stop loop
    cmp     ebx, 0
    je      .pow_end

    ; multiply eax with base number ecx
    mul     ecx
    dec     ebx

    jmp     .pow_loop       ; loop for multiple times

    .pow_end:

    ; return back our previous register
    pop     ebx
    pop     ecx

    ; clean stack frame
    leave
    ret

%endif
