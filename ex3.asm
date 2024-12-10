.global _start

.section .text
_start:
#your code here

cmp $0, $root
jz empty_HW1

movq (root), %rax
movq $node, %rbx
movl 8(%rbx), %edx

search_HW1:
	movl 8(%rax), %r8d
	
	cmp %r8d, %edx
	je end_HW1
	jg right_HW1

	left_HW1:
		movq (%rax), %r9
		cmp $0, %r9
		jz find_left_HW1
		movq %r9, %rax
		jmp search_HW1
		find_left_HW1:
			mov %rbx, (%rax)
			movq $0, (%rbx)
			movq $0, 12(%rbx)
			jmp end_HW1

	right_HW1:
		movq 12(%rax), %r9
		cmp $0, %r9
		jz find_right_HW1
		movq %r9, %rax
		jmp search_HW1
		find_right_HW1:
			mov %rbx, 12(%rax)
			movq $0, (%rbx)
			movq $0, 12(%rbx)
			jmp end_HW1

empty_HW1:
	movq $node, %rax
	movq $0, (%rax)
	movq $0, 12(%rax)
	movq %rax, (root)
	jmp end_HW1:


end_HW1:
