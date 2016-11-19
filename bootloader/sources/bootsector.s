;
; Author: Marc Durocher
;
.origin 0x7c00

		mov ah,0x0
		mov al,0x3
		int 0x10		;BIOS call to set screen video mode
		
		push cs
		pop ds
		mov ax,0xb800	;0xb800: segment address toward the memory mapped with the screen
		mov es,ax		;
		mov ah,0xb		;
		mov si,0x7d9c	; The register si contains the address of the string to print to screen 
		mov di,0x0
		call word 0x5b	; call to the homebrewed "print function"
		
		mov si,0x7db1
		mov di,0xa0
		call word 0x5b	; another call to the homebrewed "print function"
		
		mov si,0x7dd5
		mov di,0x320
		call word 0x5b	; again, call to the homebrewed "print function"
		
		call word 0x52
		
		call word 0x6d
		
		call word 0x2000:0x0	; finally, a call to the program loaded from floppy disk to 
								; into memory at this arbitrary address: 0x2000:0x0
		
		mov ax,0xb800
		mov es,ax
		mov ah,0xb
		mov si,0x7dfb
		mov di,0x280
		call word 0x5b
		
		call word 0x52
		
		mov ah,0x0
		mov al,0x3
		int 0x10
		mov ah,0x4c
		int 0x21
		mov ah,0x10
		int 0x16
		or al,al
		jz 0x52
		ret
		
		mov al,[cs:si]
		or al,al
		jz 0x6c
		nop
		nop
		mov [es:di],ax
		inc si
		inc di
		inc di
		jmp short 0x5b
		ret
		
		mov bx,0x2000
		mov es,bx
		xor bx,bx
		mov ah,0x2
		mov al,0x4
		mov ch,0x0
		mov cl,0x2
		xor dx,dx
		int 0x13
		jnc 0xf6
		nop
		nop
		mov cx,ax
		mov ax,0xb800
		mov es,ax
		mov ah,0x1b
		mov di,0x640
		cmp ah,0x1
		jnz 0xa0
		nop
		nop
		mov si,0x7cfc
		call word 0x5b
		jmp short 0xf6
		nop
		cmp ah,0x2
		jnz 0xb0
		nop
		nop
		mov si,0x7d10
		call word 0x5b
		jmp short 0xf6
		nop
		cmp ah,0x3
		jnz 0xc0
		nop
		nop
		mov si,0x7d2c
		call word 0x5b
		jmp short 0xf6
		nop
		cmp ah,0x4
		jnz 0xd0
		nop
		nop
		mov si,0x7d4a
		call word 0x5b
		jmp short 0xf6
		nop
		cmp ah,0x6
		jnz 0xe0
		nop
		nop
		mov si,0x7d5e
		call word 0x5b
		jmp short 0xf6
		nop
		mov si,0x7d7e
		add cl,0x30
		mov [cs:0x7d99],cl
		add ch,0x30
		mov [cs:0x7d86],ch
		call word 0x5b
		ret
		nop
		dec di
		dec bx
		add [bx+si+0x7245],dl
		jc 0x165
		jnz 0x174
		and [si+0x65],ah
		and [bx+si+0x61],dh
		jc 0x16b
		insw
		gs jz 0x180
		add [gs:di+0x61],cl
		jc 0x185
		jnz 0x17b
		and [si+0x20],ah
		popaw
		fs jc 0x182
		jnc 0x192
		and [gs:di+0x61],ch
		outsb
		jno 0x19b
		popaw
		outsb
		jz 0x18f
		add [bx+si+0x6944],dl
		jnc 0x1a1
		jnz 0x197
		jz 0x1a8
		and [gs:bx+si+0x72],dh
		outsw
		jz 0x1a0
		and [gs:ebp+0x6e],ah
		and [di+0x63],ah
		jc 0x1ae
		jz 0x1bc
		jc 0x1ae
		add [bp+di+0x65],dl
		arpl [si+0x65],si
		jnz 0x1c3
		and [bx+di+0x6e],ch
		jz 0x1c8
		outsw
		jnz 0x1cf
		popaw
		bound bp,[si+0x65]
		add [bp+di+0x68],al
		popaw
		outsb
		gs a32 insw
		gs outsb
		jz 0x189
		and [gs:si+0x69],ah
		jnc 0x1e1
		jnz 0x1d7
		jz 0x1e8
		and [gs:si+0x65],ah
		jz 0x1df
		arpl [si+0x65],si
		add [di+0x72],al
		jc 0x1e7
		jnz 0x1f6
		and [bp+si],bh
		pop dx
		and [bp+di],bh
		and [bp+di+0x65],dh
		arpl [si+0x65],si
		jnz 0x203
		jnc 0x1b3
		insb
		jnz 0x209
		and [bp+si],bh
		and [bp+si+0x0],bl
		nop
		inc bx
		dec ax
		inc cx
		push dx
		inc di
		inc bp
		push bp
		push dx
		and [si+0x45],al
		and [bp+si+0x4f],al
		dec di
		push sp
		and [bx+di],dh
		xor [cs:bx+si],al
		sub [bp+di+0x29],ah
		and [bp+si],dh
		xor [bx+si],dh
		xor [bx+si],sp
		sub ax,0x4d20
		inc cx
		push dx
		inc bx
		and [si+0x55],al
		push dx
		dec di
		inc bx
		dec ax
		inc bp
		push dx
		and [bp+di+0x4f],al
		dec si
		push bx
		push bp
		dec sp
		push sp
		dec cx
		dec si
		inc di
		add [bx+di+0x70],al
		jo 0x24e
		jns 0x240
		jpe 0x1fd
		jnc 0x254
		jc 0x201
		jnz 0x251
		and [gs:si+0x6f],dh
		jnz 0x24c
		push word 0x2065
		jo 0x25d
		jnz 0x262
		and [bp+di+0x6f],ah
		outsb
		jz 0x25f
		outsb
		jnz 0x25e
		jc 0x1fb
		inc bx
		push sp
		push dx
		dec sp
		db 0x20
		
section	.data

message:	db "CHARGEUR DE BOOT 1.0",0xa,0xd,
			db "(c) 2001 - MARC DUROCHER CONSULTING",0xa,0xd,
			db "Appuyez sur une touche pour continuer",0x0
