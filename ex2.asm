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
movb Address(%rax, %rsi), %dl
movzx %dl, %rdx

end_HW1: