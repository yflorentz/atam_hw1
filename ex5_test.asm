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
command: .asciz "  AA == (( ))"
__Garbage_310385443: .byte 0xFF, 0xFF
__ExpectedResult: .byte 1
__Garbage_16686264: .byte 147, 159, 29, 204, 213, 203, 210, 118, 212
result: .byte 0
__Garbage_643585055: .byte 36
