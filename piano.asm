TITLE My E-Paino           (paino.asm)

; This program adds and subtracts 32-bit integers.

INCLUDE Irvine16.inc
.data

K_F1 = 3Bh 	;Extended code of F1
K_F2 = 3Ch
K_F3 = 3Dh
K_F4 = 3Eh
;F1 -> Free Playing
;F2 -> Record
;F3 -> Replay, will ask a record file name
;F4 -> Exit

IsRecording byte 0
freq word 262,294,330,347,392,440,494,524 ;14 頻率
.code
main PROC
	mov ax,@data
	mov ds,ax
	mov ax,0

GetKey:
	mov ah,10h
	int 16h

;	mov     ah,7
;       int     21h     ;20 讀取按鍵
	cmp ah,K_F1
	je main_Free_Playing
	cmp ah,K_F2
	je main_Record
;	cmp ah,K_F3
;	je main_Replay
	cmp ah,K_F4
	je main_Exit
	cmp al,0
	je GetKey
        sub     al,'1'
        cbw
        mov     bx,ax
 	shl     bx,1
        mov     ax,34dch
        mov     cx,freq[bx]     
        mov     dx,12h          ;DX:AX=1234DCH=1193180D
        div     cx
        mov     bx,ax           ;BX=(1193180/頻率)之商數

        mov     al,10110110b    
        out     43h,al
        mov     ax,bx
        out     42h,al          ;先傳出 BX 之低位元組
        mov     al,ah
        out     42h,al          ;再傳出 BX 之高位元組
        in      al,61h
        or      al,00000011b
        out     61h,al          ;打開喇叭發出聲音

        mov     cx,0ffffh       
_Delay: 
	push 	cx
	mov     cx,4ffh
dec_dx: 
        loop dec_dx
	pop cx
        loop    _Delay           ;使聲音延續一段時間

        in      al,61h
        and     al,11111100b    ;遮掉位元 0 及位元 1
        out     61h,al          ;關掉喇叭
        jmp     GetKey


main_Free_Playing:
	mov dl,'1'
	mov ah,2
	int 21h
	mov IsRecording,0
	jmp GetKey
main_Record:
	mov dl,'2'
	mov ah,2
	int 21h
	mov IsRecording,1
	jmp GetKey

;	main_Replay:
;	mov dl,'3'
;	mov ah,2
;	int 21h
;	jmp GetKey
main_Exit:
	exit
main ENDP

END main
