.global _start

.section .text
_start:
#your code here

movq (Address), %rax
movq (LittleEndianResult), %rdx

movl (Length), %edi
movb (Type), %cl
movzx %cl, %rcx

movq $0, %r8
movq $0, %r9

array_loop_HW1:
	cmp $0, %rdi
	jle end_HW1

	movq %rcx, %r8
	movq $0, %r9
	cells_loop_HW1:
		dec %r8
		cmp $0, %r8
		jl end_cell_HW1

		movb (%rax, %r8), %r11b
		movb %r11b, (%rax, %r9)
		inc %r9


	end_cell_HW1:
	dec %rdi


end_HW1:
