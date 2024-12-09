.global _start

.section .text
_start:
#your code here
movq (Address), %rsi
movl (Length), %edi
movb (Type), %rcx
cells_loop_HW1:

