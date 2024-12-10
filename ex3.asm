.global _start

.section .text
_start:
#your code here

movq (root), %rax
movq $node, %rbx
movl 64(%rax), %r8l
