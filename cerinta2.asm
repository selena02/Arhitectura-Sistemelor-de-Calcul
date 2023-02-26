.data
	str: .space 1000
	chDelim: .asciz " "
	rez: .space 1000
	crez: .space 1000
	final: .long 0
	formatPrintf: .asciz "%d\n"
	a: .long 0
	b: .long 0
	
.text


.global main


main:
	pushl $str
	call gets
	popl %ebx
	pushl $chDelim
	pushl $str
	call strtok
	popl %ebx
	popl %ebx
	movl %eax, rez
	pushl rez
	call atoi
	popl %ebx
	movl %eax, rez
	pushl rez
	
et_for:
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	cmp $0, %eax
	je exit
	movl %eax, rez
	movl rez, %ebx 
	movl %ebx, crez
	pushl crez
	call atoi
	popl %ebx
	cmp $0, %eax
	je et_verif
	pushl rez
	call atoi
	popl %ebx
	movl %eax, rez
	pushl rez
	jmp et_for
	
et_verif:

	movl rez, %edi
	xorl %ecx, %ecx
	movb (%edi, %ecx, 1), %al	
	cmp $109, %al
	je et_mul
	cmp $100, %al
	je et_div
	cmp $115, %al
	je et_sub
	cmp $97, %al
	je et_add
		
	
et_mul:
	popl %eax
	popl %ebx
	imull %ebx
	pushl %eax
	jmp et_for
et_div:
	xorl %edx, %edx
	popl %ebx
	popl %eax
	cmp $0, %eax
	jl et2_div
	idivl %ebx
	pushl %eax
	jmp et_for
et2_div:
	movl %ebx, b
	movl %eax, a
	movl $0, %eax
	movl $0, %ebx
	subl a, %eax
	subl b, %ebx 
	idivl %ebx
	pushl %eax
	jmp et_for
		
et_sub:
	popl %ebx
	popl %eax
	subl %ebx, %eax 
	pushl %eax
	jmp et_for
	
et_add:
	popl %ebx
	popl %eax
	addl %ebx, %eax
	pushl %eax
	jmp et_for
		
exit:
	popl final
	pushl final
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx	
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80

// as --32 problema2.asm -o problema2.o 
// gcc -m32 problema2.o -o problema2
// ./problema2	
