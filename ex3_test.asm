.global _start

.section .text

  movq $60, %rax
  movq $0, %rdi
  syscall

bad_exit:
  movq $60, %rax
  movq $1, %rdi
  syscall

.section .data
root:
	.quad root_val
root_val: 
	.quad Node2
	.int 100
	.quad Node3
Node2: 
	.quad 0
	.int 40
	.quad 0
Node3: 
	.quad 0
	.int 200
	.quad 0
node:
	.quad 23
	.int 150
	.quad 5647

