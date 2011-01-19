TITLE Bad 21h


INCLUDE Irvine16.inc
.code
main PROC
	mov	ax,@data
	mov	ds,ax
	xor	bx,bx
	mov	ax,bx
	mov	ah,0E7h
	int	21h
	call	dumpRegs
	int	20h

main ENDP
END main

