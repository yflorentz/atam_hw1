.global _start

.section .text
_start:
#your code here
movq $0, %rsi
movq $0, %rax

movl (Length), %edi

movb (Type), %cl
movzx %cl, %rcx


array_loop_HW1:
cmp $0, %edi
jle end_HW1
cells_loop_HW1:
add %rcx, %rsi
lea Address(%rax, %rsi), %r8
movb Address(%rax, %rsi), %r9b


end_HW1:
