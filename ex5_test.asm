.global _start

.section .text
  movb __ExpectedResult, %al
  cmpb %al, result
  jne bad_exit

  movq $60, %rax
  movq $0, %rdi
  syscall

bad_exit:
  movq $60, %rax
  movq $1, %rdi
  syscall

.section .data
command: .asciz ""
__Garbage_534752285: .byte 82, 96, 85, 2, 195
__ExpectedResult: .byte 1
__Garbage_820062179: .byte 229, 9, 94, 51
result: .byte 0