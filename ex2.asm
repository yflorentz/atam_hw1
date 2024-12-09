.global _start

.section .text
_start:
#your code here
movq Address(%rip), %rsi
mov Length, %rax
