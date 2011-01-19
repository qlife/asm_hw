TITLE Add and Subtract              (AddSubAlt.asm)

; This program adds and subtracts 32-bit integers.
.386		; minimum CPU required
.MODEL flat,stdcall		; generate Protected mode 				; program and enable the 				; calling of MS-Winows 				; functions
.STACK 4096

ExitProcess PROTO, dwExitCode:DWORD  ; MS-Winows function
DumpRegs PROTO 		; function from Irvine32

.code
main PROC
	mov eax,10000h		; EAX = 10000h
	add eax,40000h		; EAX = 50000h
	sub eax,20000h		; EAX = 30000h
	call DumpRegs
	INVOKE ExitProcess,0 		; call a procedure/function
main ENDP
END main

