%include "./libs/string.inc"
%include "./libs/io.inc"

%define constSize   50 	; enough, binary limit also don't exceeds 32 bits


segment .rodata

title       db  10, " Base Converter (coded in asm) @ Mohd Shahril", 10, 10, 0
asksrcbase  db  " Enter your source base            : ", 0
asknum      db  " Enter your number in desired base : ", 0
asktgtbase  db  " Enter your targeted base          : ", 0
outputmsg   db  10, " Result : ", 0
ptrtwoline  db  10, 10

segment .bss

input       resb    constSize
output 		resb 	constSize

segment .text

    global  main

main:

	; setup stack frame
    push    ebp
    mov     ebp, esp

    push 	edx 	; use to store source base
    push 	ecx		; use to store target base

    ; print title at the header of the program
    push 	title
    call 	str_stdout
    add 	esp, 4

    ; ask user to put their source base
    push 	asksrcbase
    call 	str_stdout
    add 	esp, 4
    
    call	long_stdin 		; get source base from user
    mov 	edx, eax 		; copy eax (source base) into edx

    ; ask & get user to put their number
    push 	asknum
    call 	str_stdout
    add 	esp, 4

    push 	input
    push 	dword constSize
    call 	str_stdin
    add 	esp, 8

    ; ask & get input from user to put their targeted base int
    push 	asktgtbase
    call 	str_stdout
    add 	esp, 4

    call  	long_stdin		; get targeted base from user
    mov 	ecx, eax		; copy eax (targeted base) into ecx

    ; done taking input, now the real thing

    ; convert string containing number into integer (base 10)
    push 	input
    push 	edx
    call 	strtol   		; return value at eax
    add 	esp, 8

    ; from integer (base 10), we convert back into string with user's targeted base
    push 	eax
    push 	output
    push 	ecx
    call 	ltostr
    add 	esp, 12

    ; calculation done, now output the value

    ; output some nice msg :P
    push 	outputmsg
    call 	str_stdout
    add 	esp, 4

    ; output the converted value \o/
    push 	output
    call 	str_stdout
    add		esp, 4

    ; puts some new line
    push 	ptrtwoline
    call 	str_stdout
    add 	esp, 4

    pop 	ecx
    pop 	edx

    ; clear stack frame
    mov     esp, ebp
    pop     ebp
    xor     eax, eax
    ret