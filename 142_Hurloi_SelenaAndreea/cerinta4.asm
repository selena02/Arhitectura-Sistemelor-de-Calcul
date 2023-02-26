.data
	matrix: .space 1600
	n: .space 4
	m: .space 4
	val: .space 4
	h: .space 4
	elemente: .space 4
	sir: .space 2000
	rez: .space 100
	chDelim: .asciz " "
	formatPrintf: .asciz "%d "
	endl: .asciz "\n"
	
.text


.global main
	



main:

	pushl $sir
	call gets
	popl %ebx
	pushl $chDelim
	pushl $sir
	call strtok
	popl %ebx
	popl %ebx
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	pushl %eax
	call atoi
	popl %ebx
	movl %eax, n
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	pushl %eax
	call atoi
	popl %ebx
	movl %eax, m
	movl m, %eax
	mull n
	movl %eax, elemente
	xorl %ecx, %ecx
	subl $1, elemente

et_citire: 
	lea matrix, %edi
	pushl %ecx
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	pushl %eax
	call atoi
	popl %ebx
	movl %eax, rez
	popl %ecx
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp elemente, %ecx
	jg et_operatie
	jmp et_citire
		
et_operatie:

	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	//movl %eax, rez
	pushl %eax
	call atoi 
	popl %ebx
	cmp $0, %eax
	je et_rod90d
	movl %eax, val
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	movl %eax, rez
	movl rez, %esi
	xorl %ecx, %ecx
	movb (%esi, %ecx, 1), %al
	cmp $109, %al
	je et_mul
	cmp $100, %al
	je et_div
	cmp $115, %al
	je et_sub
	cmp $97, %al
	je et_add

et_add:
	lea matrix, %edi
	xorl %ecx, %ecx
	
et_add1:	
	movl val, %ebx
	addl %ebx, (%edi, %ecx, 4)
	incl %ecx
	cmp elemente, %ecx
	jg et_afisare
	jmp et_add1
et_sub:	 	
	xorl %ecx, %ecx
et_sub1:	
	movl val, %ebx
	subl %ebx, (%edi, %ecx, 4)
	incl %ecx
	cmp elemente, %ecx
	jg et_afisare
	jmp et_sub1
et_div:
	xorl %ecx, %ecx
et_div1:	
	movl (%edi, %ecx, 4), %eax
	xorl %edx, %edx
	cdq
	idivl val
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp elemente, %ecx
	jg et_afisare
	jmp et_div1
et_mul:
	xorl %ecx, %ecx
et_mul1:	
	movl (%edi, %ecx, 4), %eax
	mull val
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp elemente, %ecx
	jg et_afisare
	jmp et_mul1
	
et_rod90d:
	pushl m
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	pushl n
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	movl elemente, %ecx
	subl m, %ecx
	addl $1, %ecx
	movl %ecx, h
	
et_rod90d1:

	movl (%edi, %ecx, 4), %ebx
	pushl %ecx
	pushl %ebx
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	pushl %ecx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	subl m, %ecx
	cmp $0, %ecx
	jl et_rod90d2
	jmp et_rod90d1

et_rod90d2:
		
	addl $1, h
	movl h, %ebx
	cmp elemente, %ebx
	jg exit
	movl h, %ecx
	jmp et_rod90d1	
	
et_afisare:
	pushl n
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	pushl m
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	xorl %ecx, %ecx	
et_afis1:
	pushl %ecx
	movl (%edi, %ecx, 4), %ebx
	pushl %ebx
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	cmp elemente, %ecx 
	jg exit
	jmp et_afis1 

exit:
	movl $4, %eax
	movl $1, %ebx
	movl $endl, %ecx
	movl $2, %edx
	int $0x80
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
// as --32 problema4.asm -o problema4.o 
// gcc -m32 problema4.o -o problema4
// ./problema4	
// t 3 5 -4 95 24 57 -85 51 30 -72 -12 31 34 -29 -23 36 84 let -32 add
// w 5 5 -91 -20 82 48 -15 79 -39 -1 60 -84 -95 94 -25 3 79 79 27 64 96 26 60 91 92 -25 -41 let -95 div
//  m 4 2 -60 54 -12 85 -93 38 -49 70 let -19 mul
//  d 4 4 -30 -64 35 75 29 -58 -7 90 -37 -26 70 -16 -32 30 87 -40 let -3 sub	
// l 2 6 56 -72 -99 0 -77 31 51 47 -56 -57 84 -90 let rot90d
// x 3 5 -54 95 98 -9 -21 -48 27 39 -94 76 -38 53 -45 -96 33 let -53 add

// b 2 7 94 -78 79 24 24 17 0 -62 13 -79 -94 3 24 32 let b -81 sub

// x 8 6 -55 -21 -47 -44 -40 -10 78 -91 -55 -97 -5 -100 -31 -42 30 44 -44 -3 45 32 -1 4 92 -77 -19 75 16 -90 19 -91 -52 29 -51 -17 75 79 -46 -31 47 2 -20 51 38 -50 87 -38 -92 -22 let -77 mul

// u 3 6 -24 -95 1 95 40 -59 -99 -86 -88 25 -92 71 -98 -94 -49 93 -21 96 let 61 div
