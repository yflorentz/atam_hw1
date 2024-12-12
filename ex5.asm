.global _start

.section .text
_start:
#your code here
#0x20= ' ', 0x3d = "=". 0x28 = '(', 0x29 = ')'
#rbx is for the chars
#rdx is for ( index
#rdi is for = index

movq $command, %rax
movq $0, %rcx #how many spaces
movq $0, %r8 #open braces flag
movq $0, %rdi #index of second =
movq $0, %r9 #how many spaces before second equal

no_space_loop_HW1:
	movb (%rax), %bl
	cmp $0, %bl
	jz success_HW1 #no_spaces
	
	cmp $0x20, %bl
	je space_exist_HW1

	cmp $0x28, %bl
	jne not_braces_HW1
	movq $1, %r8
	not_braces_HW1:

	inc %rax
jmp no_space_loop_HW1


space_exist_HW1:
	movq $command, %rax
	jmp equal_loop_HW1

space_next_char_HW1:
	inc %rcx
	space_next_char_loop_HW1:	
		inc %rax
		movb (%rax), %bl

		cmp $0x20, %bl
		jne check_part_HW1

		cmp $0, %bl
		jz open_b_HW1 #spaces and no '='

	jmp space_next_char_loop_HW1
	
check_part_HW1:
	cmp $2, %rcx
	
	jge keep_going_HW1
	movq %rax, %rdx #for later use, first char after first space
	keep_going_HW1:
		je equal_third_part_HW1	

	jmp equal_loop_HW1

equal_loop_HW1:

	movb (%rax), %bl

	cmp $0x3d, %bl
	je first_equal_sign_exist_HW1

	cmp $0x20, %bl
	je space_next_char_HW1

	cmp $0, %bl
	jz open_b_HW1 #spaces and no '='

	inc %rax
jmp equal_loop_HW1


equal_third_part_HW1:
	cmp $0x3d, %bl
	je first_equal_sign_exist_HW1
	jmp open_b_HW1 #3rd part and it's not =

first_equal_sign_exist_HW1:

	after_equal_loop_HW1:
		inc %rax
		movb (%rax), %bl

		cmp $0x3d, %bl
		je after_equal_loop_HW1

	after_all_equlas_HW1:

		cmp $0x20, %bl
		jne after_equal_after_space_loop_HW1

		inc %rax
		movb (%rax), %bl
		jmp after_all_equlas_HW1
	
	after_equal_after_space_loop_HW1:
		cmp $0, %bl
		jz success_HW1 #no_spaces after '='
		
		cmp $0x20, %bl
		je check_more_equal_HW1 #more then 1 part after '='

		cmp $0x3d, %bl
		jne not_extra_equal_HW1
			movq %rax, %rdi #index of last '='
			movq %rcx, %r9 #number of spaces before

		not_extra_equal_HW1:
		inc %rax
		movb (%rax), %bl
	jmp after_equal_after_space_loop_HW1


check_more_equal_HW1:
	cmp $0, %rdi
	je open_b_HW1
	cmp $2, %r9
	jg open_b_HW1
	jne check_more_equal_loop_HW1
	cmp $0x20, -1(%rdi)
	jne open_b_HW1

	check_more_equal_loop_HW1:
		inc %rdi
		movb (%rdi), %bl

		cmp $0x20, %bl
		je check_more_equal_loop_HW1

	more_spaces_loop_HW1:
		
		cmp $0, %bl
		jz success_HW1 #no_spaces after '='

		cmp $0x20, %bl
		je open_b_HW1

		inc %rdi
		movb (%rdi), %bl
	jmp more_spaces_loop_HW1


open_b_HW1:
	cmp $0, %rdx
	je first_space_is_last_char_HW1
		movb (%rdx), %bl
		cmp $0x28, %bl
		je open_b_loop_HW1 
	first_space_is_last_char_HW1:
		movq $command, %rdx
	cmp $1, %r8
	je open_b_loop_HW1
	jmp end_HW1 #failed all tests

	open_b_loop_HW1:
		inc %rdx
		movb (%rdx), %bl

		cmp $0, %bl
		jne open_b_loop_HW1

	dec %rdx
	movb (%rdx), %bl
	cmp $0x29, %bl
	je success_HW1 #end with )
	jne end_HW1 #failed () test

success_HW1:
	movb $1, (result)
	jmp end_HW1

end_HW1:
