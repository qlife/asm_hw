TITLE PrimeNumber           (PrimeNumber.asm)
INCLUDE Irvine32.inc

text1 EQU <"Please input a number that need to determine...",0>
.data
dividend DWORD ?
divisor DWORD 2
curr DWORD 2
limit DWORD ?
isPrime_v DWORD 0
prompt1 byte text1
.code
main PROC
	mov edx,OFFSET prompt1	
	call WriteString
	call ReadInt
	sub eax,2		;數字自己本身，與1是不必判斷的，所以減去二，也就是少做兩次
	mov edx,2
	mov ecx,eax
LX:	
	mov eax,edx
	call IsPrime
	mov ebx,1
	inc edx
	cmp ebx,isPrime_v
	jne LY			;if ebx is equal to isPrime_v jump to LY. That mean it's prime.
	call Crlf	
	call WriteDec		;eax is current testing number
LY:
	loop LX
	exit
main ENDP
;==================================================
IsPrime PROC
;eax - the number need to determine
;Result - isPrime_v = 1 is prime,isPrime_v = 0 isn't prime
	pushad

	mov ebx,2		;由於用除的，所以2會判斷不到，做成特例解決
	cmp eax,ebx
	je L2
	mov dividend,eax	;Should be rewrite to the PTR format.....
	mov edx,0
	mov ebx,2
	div ebx
	mov limit,eax
	inc limit
	

	
	mov ecx,limit
L1:

	mov eax,dividend       ;Should be rewrite to the PTR format....
	mov edx,0
	div curr
	inc curr
	cmp edx,0
	loopnz L1	
	
	jecxz L2 	        ;Prime
	mov isPrime_v,0		;迴圈做到最後一個還除不盡、因ecx歸零而跳出的數必是質數，那如果最後一個剛好是一半咧？
				;不會，因為那個數將會是2的倍數，早就除完了
	jmp EXIT_LABEL
	
L2:	
	mov isPrime_v,1

EXIT_LABEL:
	mov curr,2		;設回2，下次測試還是從2開始
	popad
	ret
IsPrime ENDP



END main
