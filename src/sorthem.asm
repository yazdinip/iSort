%include "asm_io.inc"
global asm_main

section .data
argerror db "Too few or too more arguments provided. Only 1 argument is needed.", 0
invaliderror db "Invalid argument provided. The argument value must be between 2 and 9.", 0
pegarray dd  0,0,0,0,0,0,0,0,0,0
numofdisks dd 0
initialconfig db " Initial Configuration", 0
finalconfig db " Final Configuration", 0
section .bss

section .text

asm_main:
	enter 0,0
	mov eax, [esp+8]		; argc
	cmp eax, 2
	jne argumenterror
	mov ebx, [esp+12]		; **argv
	mov esi, [ebx+4]		; argv[4]
	cmp byte [esi+1], 0		; if string length is greater than 1
	jne invalidargerror
	mov eax, 0
	mov al, [esi]
	sub al, '0'
	cmp al, 2
	jb invalidargerror
	cmp al, 9
	ja invalidargerror
	mov [numofdisks], eax
	push eax
	push pegarray
	call rconf
	call print_nl
	mov eax, initialconfig
	call print_string
	call print_nl
	call print_nl
	push dword [numofdisks]
	push pegarray
	call showp
	push dword [numofdisks]
	push pegarray
	call sorthem
	mov eax, finalconfig
	call print_string
	call print_nl
	call print_nl
	push dword [numofdisks]
	push pegarray
	call showp
	jmp END
	invalidargerror:
		mov eax,invaliderror
		call print_string
		call print_nl
		jmp END
	argumenterror:
		mov eax, argerror
		call print_string
		call print_nl
		mov eax, 0
	END:
	leave
	ret

sorthem:
	mov ebx, [esp+4]
	mov ecx, [esp+8]
	cmp ecx, 1
	je sorthem_end
	dec ecx
	add ebx, 4
	push ecx
	push ebx
	call sorthem
	mov ebx, [esp+4]
	mov ecx, [esp+8]
	dec ecx
	mov eax, 0
	mov edx, 0
	loop_:
		cmp eax, ecx
		je loop_end
		mov esi, [ebx+eax*4]
		cmp esi, [ebx+eax*4+4]
		ja loop_end
		jnb jmpagain
		xchg esi, [ebx+eax*4+4]
		mov [ebx+eax*4], esi
		mov edx, 1
		inc eax
		jmpagain:
		jmp loop_
	loop_end:
		cmp edx, 1
		je callshowp
		jmp sorthem_end
	callshowp:
		push dword [numofdisks]
		push pegarray
		call showp
	sorthem_end:
	ret 8

showp:
	mov esi, [esp+4]
	mov ecx, [esp+8]
	startdisplay:
		mov ebx, [esi+ecx*4-4]
		cmp ebx, 0
		je skipit
		push ecx
		mov ecx, 11
		displayit:
			cmp ecx, ebx
			ja putspace
			mov al, 'o'
			call print_char
			jmp nextiteration
			putspace:
			mov al, ' '
			call print_char
			nextiteration:
		loop displayit
		mov al, '|'
		call print_char
		mov ecx, ebx
		displayit_:
			mov al, 'o'
			call print_char
		loop displayit_
		pop ecx
		skipit:
		call print_nl
	loop startdisplay
	mov ecx, 23
	displayX:
		mov al, 'X'
		call print_char
	loop displayX
	call print_nl
	call read_char
ret 8