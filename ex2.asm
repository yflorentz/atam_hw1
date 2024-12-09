.global _start

.section .text
_start:
#your code here
movq $0, %rsi
movq (Address), %rax

movl (Length), %edi

movb (Type), %cl
movzx %cl, %rcx
dec %rcx


array_loop_HW1:
cmp $0, %edi
jle end_HW1
cells_loop_HW1:
add %rcx, %rsi
lea (%rax, %rsi), %r8
movb (%rax, %rsi), %r9b


end_HW1:
