.data

	sir: .space 1000
	chDelim: .asciz " "
	n: .space 1000
	m: .space 1000
	v: .space 1000
	b: .space 1000
	formatPrintf: .asciz "%d "
	c: .long 0
 	trei: .long 3
	unu: .long 1
	s: .space 10000
	zero: .long 0
	cnt: .long 0
	returni: .long 0
	d: .long -1
	ok: .long 0
	endl: .long 10
	formatPrintfv: .asciz "%c"
	nuexista: .long -1
.text

verif_poz:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %eax
	movl 8(%ebp), %eax
	
	pushl %ecx
	pushl %edx
	
	movl %eax, %ecx
	movl (%esi, %ecx, 4), %edx
	
	movl $0, cnt
	movl $0, returni
	xorl %ecx, %ecx
	movl $-1, d
	pushl %ebx
	
et_for_verif:
	cmp %ecx, %eax
	je et_verif_restul
	
	movl (%esi, %ecx, 4), %ebx
	
	cmp %ebx, %edx
	je et_cont_verif
	
	incl %ecx
	jmp et_for_verif

et_cont_verif:
	movl %ecx, d
	incl cnt
	incl %ecx
	jmp et_for_verif
	
et_verif_restul:
	cmp $-1, d
	je et_return
	
	cmp $2, cnt
	jg et_verif_exit
	
	subl d, %eax
	subl $1, %eax
	
	cmp %eax, m
	jg et_verif_exit
	
	movl $1, returni
	jmp et_verif_exit
	
et_return:
	movl $1, returni
	jmp et_verif_exit
	
et_verif_exit:
	popl %ebx
	popl %edx
	popl %ecx
	popl %eax
	popl %ebp
	ret
		
et2_bkt:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	
	cmp $1, ok
	je bkt_exit
	
	movl 8(%ebp), %eax
	cmp c, %eax
	je et_bkt_afis
	
	movl %eax, %ecx
	
	movl (%edi, %ecx, 4), %ebx
	movl $1, %ecx
	
et_bkt_for:
	cmp n, %ecx
	jg bkt_exit
	
	cmp $0, %ebx
	je et_btk_adaug
	
	pushl %ecx
	
	movl %eax, %ecx
	movl %ebx, (%esi, %ecx, 4)
	
	popl %ecx
	
	pushl %eax
	call verif_poz
	popl %eax
	
	cmp $1, returni
	je et_bkt_apelnou
	
	incl %ecx
	jmp et_bkt_for

et_bkt_afis:
	movl $1, ok
	xorl %ecx, %ecx
	
et_bkt_afis2:
	cmp %ecx, c
	je bkt_exit
	
	movl (%esi, %ecx, 4), %eax
	
	pushl %ecx
	
	pushl %eax
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
	
	incl %ecx
	jmp et_bkt_afis2 
		 
et_bkt_apelnou:	
	incl %eax
	
	pushl %ebx
	pushl %ecx
	pushl %eax
	call et2_bkt
	popl %eax
	popl %ecx
	popl %ebx
	
	decl %eax
	incl %ecx
	jmp et_bkt_for
	
et_btk_adaug:
	movl %ecx, %edx
	pushl %ecx
	
	movl %eax, %ecx
	movl %edx, (%esi, %ecx, 4)
	
	popl %ecx
	
	pushl %eax
	call verif_poz
	popl %eax
	
	cmp $1, returni
	je et_bkt_apelnou
	
	incl %ecx
	jmp et_bkt_for
	
bkt_exit:
	popl %ebx
	popl %ebp
	ret

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
	
	movl %eax, n
	
	pushl n
	call atoi
	popl %ebx
	
	movl %eax, n
	
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, m
	
	pushl m
	call atoi
	popl %ebx
	
	movl %eax, m
	
	lea v, %edi
	movl n, %eax
	xorl %edx, %edx
	mull trei
	movl %eax, c
	subl $1, c
	xorl %ecx, %ecx
	
et_for:
	cmp c, %ecx
	jg et_bkt
	
	pushl %ecx
	
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	movl %eax, b
	pushl %ecx
	
	pushl b
	call atoi
	popl %ebx
	
	popl %ecx
	
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	
	jmp et_for
	
et_bkt:
	lea s, %esi
	addl $1, c
	
	pushl zero
	call et2_bkt
	popl %ebx
	
	cmp $0, ok
	je et_nu_exista
	cmp $1, ok
	je exit

et_nu_exista:
	pushl nuexista
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx	
exit:	
	pushl endl
	pushl $formatPrintfv
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

// as --32 cerinta1.asm -o cerinta1.o
// gcc -m32 cerinta1.o -o cerinta1
// ./cerinta1
// 5 1 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5
// 4 1 1 2 0 2 1 3 4 3 4 1 3 4
