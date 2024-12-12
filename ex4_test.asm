.global _start

.section .data
Node1:
	.quad 0
	.int 100
	.quad Node2
Node2:
	.quad Node1
	.int 111
	.quad Node3
Node3:
	.quad Node2
	.int 2697603517
	.quad Node4
Node4:
	.quad Node3
	.int 133
	.quad 0
node: .quad Node3
result: .byte 0