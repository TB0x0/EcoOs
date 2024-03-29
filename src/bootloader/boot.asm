org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A

; FAT12 header
jmp short start
nop

bdb_oem:		db 'MSWIN4.1'
bdb_bytes_per_sector:	dw 512
bdb_sectors_perCluster:	db 1
bdb_reserved_sectors:	dw 1
bdb_fat_count:		db 2
bdb_dir_entries_count:	dw 0E0h
bdb_total_sectors:	dw 2880
bdb_media_descriptor_type: db 0F0h
bdb_sectors_per_fat:	dw 9
bdb_sectors_per_track:	dw 18
bdb_heads:		dw 2
bdb_hidden_sectors:	dd 0
bdb_large_sector_count:	dd 0


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
