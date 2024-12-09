
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
	.byte 3

Length:
	.int 3

Array:
    .byte 0x01, 0x02, 0x03, 0x04
    .byte 0x05, 0x06, 0x07, 0x08, 0x09

LittleEndianResult:
  .quad ResArray

ResArray:
    .byte 0x01, 0x02, 0x03, 0x04
    .byte 0x05, 0x06, 0x07, 0x08, 0x09
