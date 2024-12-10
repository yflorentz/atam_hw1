.global _start

.section .text
_start:
#your code here
#0x20= ' ', 0x3d = "=". 0x28 = '(', 0x29 = ')'

movq $command, %rax
no_space_loop_HW1:
movb (%rax), %bl
cmp $0, %bl
jz success_HW1

inc %rax
jmp no_space_loop_HW1

success_HW1:
movb $1, (result)

end_HW1:
