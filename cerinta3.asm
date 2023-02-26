.data

	str: .space 1000
	chDelim: .asciz " "
	rez: .space 1000
	a: .long 0
	b: .long 0
	variabile: .space 1000
	indice: .long 0
	numere: .space 1000
	formatPrintf: .asciz "%d\n"
	final: .long 0 
	crez: .space 1000


.text



.global main
	
	
main:
	
	movl $numere, %esi
	pushl $str
	call gets
	popl %ebx
	pushl $chDelim
	pushl $str
	call strtok
	popl %ebx
	popl %ebx
	movl %eax, rez
	movl rez, %ebx 
	movl %ebx, crez
	pushl crez
	call atoi
	popl %ebx
	cmp $0, %eax
	je et_variabila
	pushl %eax

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
	pushl %eax
	jmp et_for
	

et_verif:
	movl rez, %ebx 
	movl %ebx, crez
	pushl crez
	call strlen
	popl %ebx
	cmp $1, %eax
	je et_variabila

et_operiatie:
	
	movl rez, %edi
	movl $2, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $100, %al
	je et_add
	cmp $98, %al
	je et_sub
	cmp $108, %al
	je et_mul
	cmp $118, %al
	je et_div
	cmp $116, %al
	je et_let


et_variabila:
	movl rez, %edi
	xorl %ecx, %ecx
        movb (%edi, %ecx, 1), %al
 	movl $variabile, %edi
	
et_variabila1:
	cmp $0, indice
	je et_adaug
	movb (%edi, %ecx, 1), %ah
	cmp %al, %ah
	je et_mu
	incl %ecx
	cmp indice, %ecx
	je et_adaug
	jmp et_variabila1
	
et_mu:
	movl (%esi, %ecx, 4), %ebx
	pushl %ebx
	jmp et_for

et_adaug:
	movl indice, %ecx
	movb %al, (%edi, %ecx, 1)
	pushl rez
	jmp et_for
et_mul:

	//popl %edi
	popl %eax
	popl %ebx
	imull %ebx
	pushl %eax
	jmp et_for
et_div:

	//popl %edi
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

	//popl %edi
	popl %ebx
	popl %eax
	subl %ebx, %eax 
	pushl %eax
	jmp et_for
	
et_add:

	//popl %edi
	popl %ebx
	popl %eax
	addl %ebx, %eax
	pushl %eax
	jmp et_for	
	
et_let:

	//popl %edi
	popl %ebx
	popl %eax
	movl indice, %ecx
	//movl %eax, (%edi, %ecx, 4)
	movl %ebx, (%esi, %ecx, 4)
	incl indice
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
	
	
	
// as --32 problema3.asm -o problema3.o 
// gcc -m32 problema3.o -o problema3
// ./problema3	
//2 x 1 let x sub f 4 let 3 mul u 4 let u x i 2 let f 3 div w 3 let 4 x w u div add 3 add mul mul mul mul add
