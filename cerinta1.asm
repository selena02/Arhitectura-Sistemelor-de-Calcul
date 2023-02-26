.data
	sirb16: .space 10000
	sir: .space 10000
	formatScanf: .asciz "%s"
	formatPrintfn: .asciz "%d"
	formatPrintfmn: .asciz "-%d"
	formatPrintfv: .asciz "%c"
	formatPrintf: .asciz "%s"
	formatSscanf: .asciz "%2x"
	spatiu: .long 32
	endl: .long 10
	add: .asciz "add"
	sub: .asciz "sub"
	mul: .asciz "mul"
	div: .asciz "div"
	let: .asciz "let"
	unu: .long 1
	doi: .long 2
	trei: .long 3
	patru: .long 4
	zero: .long 0
	x: .long 0
	s: .long 0
	

.text


.global main


main:
	pushl $sirb16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	movl $sirb16, %edi
	xorl %ecx, %ecx
	movl $sir, %esi
et_for:
	movb (%edi, %ecx, 1), %al
	//movb %al, %ah
	cmp $0, %al
	je exit
	cmp $1, s
	je et_spatiu
	jmp et_comparare
	
et_spatiu:
	pushl %eax
	pushl %ecx
	pushl spatiu
	pushl $formatPrintfv
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	pushl %ecx	
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	popl %eax
	
et_comparare:		
	
	cmp $56, %al
	je et_8
	cmp $57, %al
	je et_9
	cmp $65, %al
	je et_A
	cmp $67, %al
	je et_C
	
et_8:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $0, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $1, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	pushl %ecx
	pushl $x
	pushl $formatSscanf
	pushl %esi
	call sscanf
	popl %ebx
	popl %ebx
	popl %ebx
	pushl x
	pushl $formatPrintfn
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for
et_9:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $0, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $1, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	pushl %ecx
	pushl $x
	pushl $formatSscanf
	pushl %esi
	call sscanf
	popl %ebx
	popl %ebx
	popl %ebx
	pushl x
	pushl $formatPrintfmn
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for
	
et_A:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $0, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $1, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	pushl %ecx
	pushl $x
	pushl $formatSscanf
	pushl %esi
	call sscanf
	popl %ebx
	popl %ebx
	popl %ebx
	pushl x
	pushl $formatPrintfv
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for
et_C:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $0, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	incl %ecx
	movb (%edi, %ecx, 1), %al
	pushl %ecx
	movl $1, %ecx
	movb %al, (%esi, %ecx, 1)
	popl %ecx
	pushl %ecx
	pushl $x
	pushl $formatSscanf
	pushl %esi
	call sscanf
	popl %ebx
	popl %ebx
	popl %ebx
	movl x, %ebx
	cmp %ebx, zero
	je et_let
	cmp %ebx, unu
	je et_add
	cmp %ebx, doi
	je et_sub
	cmp %ebx, trei
	je et_mul
	cmp %ebx, patru
	je et_div
et_let:
	pushl $let
	pushl $formatPrintf	
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for	
et_div:
	pushl $div
	pushl $formatPrintf	
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for
et_add:
	pushl $add
	pushl $formatPrintf	
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for
et_sub:
	pushl $sub
	pushl $formatPrintf	
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for	
et_mul:
	pushl $mul
	pushl $formatPrintf	
	call printf
	popl %ebx
	popl %ebx
	pushl $0
	call fflush
	popl %ebx
	popl %ecx
	incl %ecx
	movl $1, s
	jmp et_for	
exit:
	pushl endl
	pushl $formatPrintfv
	call printf
	popl %ebx
	popl %ebx
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
// as --32 problema1.asm -o problema1.o
// gcc -m32 problema1.o -o problema1
// ./problema1
// A78801C00A7890EC04
//A678E68E1A71C0084EC04A65822822A758EFC04C03876C02824A6F8F5A79A78C00C03C028CFA6B8BF
