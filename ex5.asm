.global _start

.section .text
_start:
#your code here
#0x20= ' ', 0x3d = "=". 0x28 = '(', 0x29 = ')'

#rbx is for the chars
#rdx is for ( index

movq $command, %rax
movq $1, %rcx #how many spaces
movq $0, %r8 #open braces flag

movq $0, %r9 #2cnd word index
movq $0, %r10 #last char 1st word
movq $0, %r11 #3d word index
movq $0, %r12 #last char 2st word



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
	

equal_loop_HW1:
	
	cmp $2, %rcx
	jne not_2_word_HW1
		movq %rax, %r9
	not_2_word_HW1:

	cmp $3, %rcx
	jne not_3_word_HW1
		movq %rax, %r11
	not_3_word_HW1:	
	

	how_many_words_HW1:
		movb (%rax), %bl
		
		cmp $0, %bl
		jz continue_equal_loop1_HW1
	
		cmp $0x20, %bl
		je next_word_euqal_loop_HW1

	jmp how_many_words_HW1

	continue_equal_loop1_HW1:
		movq $command, %rax
		cmp $2, %rcx
		je equal_2_words_HW1

		cmp $3, %rcx
		je equal_3_words_HW1

		cmp $4, %rcx
		je equal_4_words_HW1
	jmp open_b_HW1


	#----- the word have 2 parts ----
	equal_2_words_HW1:
		2_word_equal_loop:
			movb (%r9), %bl

			cmp $0x3d, bl
			je success_HW1

			cmp $0, bl
			je 2_words_continue_HW1

			inc %r9
		jmp 2_word_equal_loop

		2_words_continue_HW1:
			cmp $0x3d, %r10
			je success_HW1
		jmp open_b_HW1

	#----- the word have 3 parts ----
	equal_3_words_HW1:
		cmp $0x3d, %r11
		je success_HW1

		cmp $0x3d, %r12
		je success_HW1
	jmp open_b_HW1

	#----- the word have 4 parts ----
	equal_4_words_HW1:
		cmp $0x3d, %r11
		je success_HW1
	jmp open_b_HW1


next_word_euqal_loop_HW1:
	inc %rcx
	
	cmp $2, rcx
	jne not_e_1_HW1
		movq %rax, %r10
		dec %r10
	not_e_1_HW1:

	cmp $3, rcx
	jne not_e_1_HW1
		movq %rax, %r12
		dec %r12
	not_e_2_HW1:

	space_next_char_loop_HW1:	
		inc %rax
		movb (%rax), %bl

		cmp $0x20, %bl
		jne equal_loop_HW1

	jmp space_next_char_loop_HW1




open_b_HW1:
	cmp $0, %r9
	je first_space_is_last_char_HW1
		movb (%r9), %bl
		cmp $0x28, %bl
		je open_b_loop_HW1 
	first_space_is_last_char_HW1:
		movq $command, %r9
	cmp $1, %r8
	je open_b_loop_HW1
	jmp end_HW1 #failed all tests

	open_b_loop_HW1:
		inc %r9
		movb (%r9), %bl

		cmp $0, %bl
		jne open_b_loop_HW1

	dec %r9
	movb (%r9), %bl
	cmp $0x29, %bl
	je success_HW1 #end with )
	jne end_HW1 #failed () test

success_HW1:
	movb $1, (result)
	jmp end_HW1

end_HW1:
