TITLE Keyscan

;scan key

INCLUDE Irvine16.inc
.code
main PROC
NOEXIT:
	mov ah,00h
	int 16h
	mov dl,al
	mov ah,2
	int 21h

	cmp al,'0'
	je _EXIT
	jmp NOEXIT
_EXIT:
	exit
main ENDP
END main

