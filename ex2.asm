.global _start

.section .text
_start:
#your code here
moveq Address(%rip), %rsi
move $0xff, rax
