Title Pascal Triangle                     (pas.asm)

INCLUDE Irvine32.inc

text1 EQU <"Please input the layer of Pascal Triangle,which is 2-15",0>
text2 EQU <"Usage:2-15 = =",0>
.data
prompt1 byte text1
prompt2 byte text2
layer DWORD 1
currlayer DWORD 2
arr dword 15 dup(0)
blank6 BYTE "      ",0
blank5 BYTE "     ",0
blank4 BYTE "    ",0
blank3 BYTE "   ",0
blank2 BYTE "  ",0
blank1 BYTE " ",0

.code

main PROC
	mov edx,OFFSET prompt1  	;Get the layer infomation
	call WriteString
	call ReadInt
	mov layer,eax
	mov arr,1			;Set the beginning two cell as 1
	mov [arr+4],1			;4 ~= TYPE arr
	mov ecx,eax
L0:	
	mov edx,OFFSET blank6		;這段在輸出第一個1
	call WriteString		;Because a start the arr as "1 1" 
	loop L0
	inc layer
	mov edx,OFFSET blank5
	call WriteString
	mov eax,1
	call WriteDec
	call Crlf
	

	
	mov edx,OFFSET arr		;Fill the paramster which is needed by incPas
	add edx,TYPE arr		;Point to last element
	mov ebx,1

	mov ecx,layer			
	sub ecx,2
L2:
	pushad
	mov eax,layer			;Calc of lefty blank
	mov ebx,currlayer
	sub eax,ebx
	mov ecx,eax
L4:
	mov edx,OFFSET blank6		;Output lefty blank
	call WriteString
	loop L4

	mov esi,OFFSET arr


	mov ecx,currlayer
L3:					;Output the array.
	mov eax,[esi]
	call ADJ
	mov edx,OFFSET blank6
	call WriteString		
	add esi,TYPE arr
	loop L3

	popad
	call Crlf
	call incPas
	inc ebx
	add edx,TYPE arr
	inc currlayer
	loop L2

	exit
main ENDP

ADJ PROC
;Test how many digit of the value.

	cmp eax,10000
	jae Output5
	cmp eax,1000
	jae Output4
	cmp eax,100
	jae Output3
	cmp eax,10
	jae Output2
Output1:
	mov edx,OFFSET Blank5
	call WriteString	
	call WriteDec
	jmp EX

Output2: 
	mov edx,OFFSET Blank4
	call WriteString	
	call WriteDec
	jmp EX

Output3: 
	mov edx,OFFSET Blank3
	call WriteString	
	call WriteDec
	jmp EX

Output4:
	mov edx,OFFSET blank2
	call WriteString
	call WriteDec
	jmp Ex
Output5:
	mov edx,OFFSET blank1
	call WriteString
	call WriteDec
	jmp EX

EX:	
	ret
ADJ ENDP

COMMENT ! ;=======for debug purpose.======
testmem PROC
	pushad
	mov esi,OFFSET arr
	mov ecx,LENGTHOF arr
	mov ebx,TYPE arr
	call DumpMem
	popad
	ret
testmem ENDP
!

incPas PROC
;	Reg:
;		ebx-Need to do ? times
;		edx-Point to the last element
	pushad
	mov esi,edx			;Put into a new 1
	add esi,TYPE arr
	mov eax,1
	mov [esi],eax
	sub esi,TYPE arr		;Put 1 at the last of the list
	mov ecx,ebx
L1:	
	mov eax,[esi-4]                 ;TYPE arr
	mov ebx,[esi]			;"Increase" the array.
	add ebx,eax
	mov [esi],ebx
	sub esi,TYPE arr
	loop L1	
	
	popad
	ret
incPas ENDP
END main


