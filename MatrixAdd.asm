TITLE Matrix Addition           (MatrixAdd.asm)

; This program adds and subtracts 32-bit integers.

INCLUDE Irvine32.inc

text1 EQU <"Please input the colnums of matrix...",0>
text2 EQU <"Please input the rows of matrix...",0>
text3 EQU <"Please input the first matrix...",0>
text4 EQU <"Please input the second matrix...",0>

.data
promptcol byte text1
promptrow byte text2
prompt1 byte text3
prompt2 byte text4
col dword ?
row dword ?
intarr1 dword 100 dup(0)
intarr2 dword 100 dup(0)
counter dword 0
i dword 0
.code
main PROC
	mov edx, OFFSET promptcol                 ;Show the prompt.
	call WriteString	
	call ReadInt			          ;Read the value of colnums
	mov col,eax
	mov edx, OFFSET promptrow
	call WriteString			
	call ReadInt			          ;Read the value of rows.
	mov row,eax

;=========================================================================	
;Read the matrix1
	mov edx,OFFSET prompt1
	call WriteString
	call Crlf
	mov ecx,row
L1:
	mov counter,ecx
	mov ecx,col
	L2:
		mov esi, OFFSET intarr1
		add esi,i		
		call ReadInt
		mov [esi],eax
		add i,4	  	;4 is the size of the dword		
	loop L2
	mov ecx,counter
loop L1

	
;==========================================================================
;Read the matrix2

	mov edx,OFFSET prompt2
	call WriteString
	call Crlf
	mov i,0					;Reset the index variable to 0
	mov ecx,row
L3:
	mov counter,ecx
	mov ecx,col
	L4:
		mov esi, OFFSET intarr2
		add esi,i		
		call ReadInt
		mov [esi],eax
		add i,4			;4 is the size of the dword		
	loop L4
	mov ecx,counter
loop L3

	mov i,0					;Reset the index variable to zero
	mov ecx,row
L5:
	mov counter,ecx
	mov ecx,col
	L6:
				
		mov al,9			;The ASCII code of '\t' is 9
		call WriteChar
	
		mov esi, OFFSET intarr1		;Write the matrix elements.
		add esi,i		
		mov eax,[esi]
		mov esi,OFFSET intarr2
		add esi,i
		add eax,[esi]		
		call WriteDec			
		add i,4				;4 is the size of the dword
	loop L6
	call Crlf                               ;Cr-Lf, i.e. new line.
	mov ecx,counter
loop L5
	exit
main ENDP
END main

