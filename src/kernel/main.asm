org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A


start:
	jmp main


puts:
	push si
	push ax

.loop:
	lodsb		; load next character
	or al, al  	; check if next character is null
	jz .done	; conditional jmp if character is null

	mov ah, 0x0e	; call bios
	mov bh, 0
	int 0x10
	jmp .loop

.done:
	pop ax
	pop si
	ret


main:
	; setup Registers
	mov ax, 0
	mov ds, ax
	mov es, ax

	; initialize stack
	mov ss, ax
	mov sp, 0x7C00

	; print message
	mov si, msg_hello
	call puts
	hlt

.halt:
	jmp .halt

msg_hello: db 'Welcome to Eco OS!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
