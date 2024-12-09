
.section .text

  mov $Address, %rax
  cmpl $1, (%rax)
  jne bad_exit

  movq $60, %rax
  movq $0, %rdi
  syscall

bad_exit:
  movq $60, %rax
  movq $1, %rdi
  syscall

.section .data

Address:
    .quad Array

Type:
	.byte 2

Length:
	.int 8

Array:
    .word 0x0001, 0x0002, 0x0003, 0x0004
    .word 0x0005, 0x0006, 0x0007, 0x0008

LittleEndianResult:
  .quad ResArray

ResArray:
    .word 0, 0, 0, 0
    .word 0, 0, 0, 0