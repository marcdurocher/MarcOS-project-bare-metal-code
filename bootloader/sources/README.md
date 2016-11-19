# Retrieving the source

The bootloader fits in the first sector of the floppy disk.

All we have to do is to extract the 512 first bytes of the disk image.

Using the dd command:

    dd if=MarcOS.img of=bootsector.img count=1
	512 bytes copied, 0,000132323 s, 3,9 MB/s




Then we can disassemble the first sector using the following command:

    ndisasm bootsector.img > bootsector.s
    
    less bootsector.s
    00000000  B400              mov ah,0x0
	00000002  B003              mov al,0x3
	00000004  CD10              int 0x10
	00000006  0E                push cs
	00000007  1F                pop ds
	00000008  B800B8            mov ax,0xb800
	0000000B  8EC0              mov es,ax
	0000000D  B40B              mov ah,0xb
	0000000F  BE9C7D            mov si,0x7d9c
	00000012  BF0000            mov di,0x0
	00000015  E84300            call word 0x5b
	00000018  BEB17D            mov si,0x7db1
	0000001B  BFA000            mov di,0xa0
	0000001E  E83A00            call word 0x5b
	00000021  BED57D            mov si,0x7dd5
	00000024  BF2003            mov di,0x320
	00000027  E83100            call word 0x5b
	0000002A  E82500            call word 0x52
	0000002D  E83D00            call word 0x6d
	00000030  9A00000020        call word 0x2000:0x0
	00000035  B800B8            mov ax,0xb800
	00000038  8EC0              mov es,ax
	0000003A  B40B              mov ah,0xb
	0000003C  BEFB7D            mov si,0x7dfb
	0000003F  BF8002            mov di,0x280
	00000042  E81600            call word 0x5b
	[..]
	
	cat bootsector.disasm |cut -b 25- > bootsector.s

To print the resulting file, with line number (-n option):	
	
	cat -n bootsector.s|less
	
	 1      mov ah,0x0
     2      mov al,0x3
     3      int 0x10
     4      push cs
     5      pop ds
     6      mov ax,0xb800
     7      mov es,ax
     8      mov ah,0xb
     9      mov si,0x7d9c
    10      mov di,0x0
    11      call word 0x5b
    12      mov si,0x7db1
    13      mov di,0xa0
    14      call word 0x5b
    15      mov si,0x7dd5
    16      mov di,0x320
    17      call word 0x5b
    18      call word 0x52
    19      call word 0x6d
    20      call word 0x2000:0x0
    21      mov ax,0xb800
    22      mov es,ax
    23      mov ah,0xb
    24      mov si,0x7dfb
    25      mov di,0x280
    26      call word 0x5b
	
	
	
	
    