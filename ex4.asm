

.section .text
_start:

ex4_HW1:
    # Initialize result to 0 (neither)
    movq $0, %rax
    lea node(%rip), %rbx    # Load node address into %rbx

    # Load prev and next pointers
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rdx = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

     # Check if it is the first node by comparing prev pointer to 0
    cmpq $0, %rcx
    movq $1, %r8
    cmove %r8, %r14
    movq $0, %r8
    je traverse_to_top_HW1

    # Check if it is the last node by comparing next pointer to 0
    cmpq $0, %rax
    cmove %r8, %r15
    movq $0, %r8
    je traverse_to_bottom_HW1

traverse_to_bottom_HW1:
    movq (%rcx), %rsi      # rsi = current pointer (prev direction)
    cmpq $0, %rsi
    movq $2, %r8
    cmove %r8, %r14
    movq $0, %r8
    je traverse_to_top_HW1

    load_difference_and_ratio_bottom_HW1:
    movl 8(%rsi), %r13d    # r13d = data of prev node
    movl 8(%rcx), %r12d    # r12d = data of current node
    subl %r13d, %r12d      # r12d = current - prev
    movl %r12d, %r8d       # r8d = bottom common difference or 0 (if sequences is not arithmetic)

    movl 8(%rcx), %r12d    # r12d = data of current node
    mov %r12d, %eax        # Move dividend into eax
    xor %edx, %edx         # Clear edx to ensure it is 0 for unsigned division
    div %r13d              # Divide edx:eax by r13d
    movl %eax, %r9d        # r9d = bottom common ratio or 0 (if sequences is not geo)


traverse_bottom_loop_HW1:
    #move pointers forward
    movq (%rcx), %rcx
    movq (%rsi), %rsi

    cmpq $0, %rsi      # Check if prev pointer is NULL
    je traverse_to_top_HW1

    bottom_arithmetic_check_HW1: # Check arithmetic progression
        cmpl $0, %r8d
        je bottom_geometric_check_HW1

        movl 8(%rsi), %r13d   # r13d = data of prev node
        movl 8(%rcx), %r12d   # r12d = data of current node
        subl %r13d, %r12d     # r12d = current - prev
        cmpl %r8d, %r12d      # Compare with previous difference
        jne bottom_not_arithmetic_HW1

    bottom_geometric_check_HW1: # Check geometric progression
        cmpl $0, %r9d
        je traverse_bottom_loop_HW1

	movl 8(%rcx), %r12d    # r12d = data of current node
        mov %r12d, %eax    # Move dividend into eax
        xor %edx, %edx     # Clear edx to ensure it is 0 for unsigned division
        div %r13d          # Divide edx:eax by r13d
        cmpl %r9d, %eax
        jne bottom_not_geometric_HW1
    jmp traverse_bottom_loop_HW1

bottom_not_arithmetic_HW1:
    movl $0, %r8d
    jmp traverse_bottom_loop_HW1

bottom_not_geometric_HW1:
    movl $0, %r9d
    jmp traverse_bottom_loop_HW1

traverse_to_top_HW1:
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rdx = next pointer

    movq %rax, %rcx
    movq 12(%rcx), %rsi      # rsi = current pointer (prev direction)

    cmpq $0, %rsi

    movq $2, %r10
    cmove %r10, %r15
    movq $0, %r10
    je check_full_list_HW1

    load_difference_and_ratio_top_HW1:
    movl 8(%rsi), %r13d    # r13d = data of next node
    movl 8(%rcx), %r12d    # r12d = data of current node
    subl %r12d, %r13d      # r13d = next - current
    movl %r13d, %r10d       # r10d = top common difference or 0 (if sequences is not arithmetic)

    movl 8(%rsi), %r13d    # r13d = data of current node
    mov %r13d, %eax        # Move dividend into eax
    xor %edx, %edx         # Clear edx to ensure it is 0 for unsigned division
    div %r12d              # Divide edx:eax by r12d
    movl %eax, %r11d       # r11d = top common ratio or 0 (if sequences is not geo)

traverse_top_loop_HW1:
    #move pointers forward
    movq 12(%rcx), %rcx
    movq 12(%rsi), %rsi

    cmpq $0, %rsi      # Check if next pointer is NULL
    je check_full_list_HW1

    top_arithmetic_check_HW1: # Check arithmetic progression
        cmpl $0, %r10d
        je check_full_list_HW1

        movl 8(%rsi), %r13d   # r13d = data of next node
        movl 8(%rcx), %r12d   # r12d = data of current node
        subl %r12d, %r13d     # r12d = current - prev
        cmpl %r10d, %r13d      # Compare with previous difference
        jne top_not_arithmetic_HW1

    top_geometric_check_HW1: # Check geometric progression
        cmpl $0, %r11d
        je check_full_list_HW1

	    movl 8(%rsi), %r13d    # r12d = data of current node
        mov %r13d, %eax    # Move dividend into eax
        xor %edx, %edx     # Clear edx to ensure it is 0 for unsigned division
        div %r12d          # Divide edx:eax by r13d
        cmpl %r11d, %eax
        jne top_not_geometric_HW1

    jmp traverse_top_loop_HW1

top_not_arithmetic_HW1:
    movl $0, %r10d
    jmp traverse_top_loop_HW1

top_not_geometric_HW1:
    movl $0, %r11d
    jmp traverse_top_loop_HW1

check_full_list_HW1:
    cmpq $1, %r14
    je check_r15
    cmpq $2, %r14
    je check_r15
    jmp is_at_edge_HW1
    
    check_r15:
        cmpq $1, %r14
        je geometric_and_arithmetic_HW1
        cmpq $2, %r14
        je geometric_and_arithmetic_HW1
    
    is_at_edge_HW1:
        cmpq $1, %r14
        je check_at_edge_HW1
        cmpq $1, %r15
        je check_at_edge_HW1
    jmp check_arithmetic_classic_HW1

check_at_edge_HW1:
    cmpl $0, %r8d  # Ensure bottom common difference is not zero
    jne geometric_and_arithmetic_HW1
    cmpl $0, %r10d  # Ensure top common difference is not zero
    jne geometric_and_arithmetic_HW1
    jmp neither_geometric_and_arithmetic_HW1

check_arithmetic_classic_HW1:
    cmpq $2, %r14
    je check_arithmetic_one_from_edge_bottom_HW1
    cmpq $2, %r15
    je check_arithmetic_one_from_edge_top_HW1

    # Verify arithmetic conditions for both sides
    # Check if common differences are the same and not zero
    cmpl $0, %r8d  # Ensure bottom common difference is not zero
    je not_arithmetic_HW1
    cmpl $0, %r10d  # Ensure top common difference is not zero
    je not_arithmetic_HW1
    cmpl %r8d, %r10d  # Compare bottom and top common differences
    jne not_arithmetic_HW1

    # Calculate potential node
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rdx = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

    movl 8(%rcx), %r12d
    movl 8(%rax), %r13d

    addl %r8d, %r12d
    subl %r8d, %r13d

    cmpl %r12d, %r13d  # Compare possible new node
    jne not_arithmetic_HW1

    jmp is_arithmetic_HW1
    # Mark as arithmetic

check_arithmetic_one_from_edge_bottom_HW1:
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rdx = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

    movl 8(%rcx), %r12d
    movl 8(%rax), %r13d

    addl %r10d, %r12d
    subl %r10d, %r13d

    cmpl %r12d, %r13d  # Compare possible new node
    je is_arithmetic_HW1
    jmp not_arithmetic_HW1


check_arithmetic_one_from_edge_top_HW1:
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rdx = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

    movl 8(%rcx), %r12d
    movl 8(%rax), %r13d

    addl %r8d, %r12d
    subl %r8d, %r13d

    cmpl %r12d, %r13d  # Compare possible new node
    je is_arithmetic_HW1
    jmp not_arithmetic_HW1

is_arithmetic_HW1:
    orb $1, result(%rip)  # Set result flag to arithmetic
    jmp check_geometric_HW1

not_arithmetic_HW1:
    # Mark result as not arithmetic
    jmp check_geometric_HW1

check_geometric_HW1:
    cmpq $2, %r14
    je check_geometric_one_from_edge_bottom_HW1
    cmpq $2, %r15
    je check_geometric_one_from_edge_top_HW1

    # Verify arithmetic conditions for both sides
    # Check if common differences are the same and not zero
    cmpl $0, %r8d  # Ensure bottom common difference is not zero
    je not_geometric_HW1
    cmpl $0, %r10d  # Ensure top common difference is not zero
    je not_geometric_HW1
    cmpl %r9d, %r11d  # Compare bottom and top common differences
    jne not_geometric_HW1

    # Calculate potential node
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rdx = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

    movl 8(%rcx), %r12d
    movl 8(%rax), %r13d

    imull %r9d, %r12d       # %r12d *= %r8d

    xorl %eax, %eax         # Clear upper bits of %rax for unsigned division
    movl %r13d, %eax        # Load %r13d into %eax for division
    divl %r9d               # %eax = %r13d / %r8d, quotient in %eax

    cmpl %r12d, %eax        # Compare results of multiplication and division
    jne not_geometric_HW1
    jmp is_geometric_HW1

check_geometric_one_from_edge_bottom_HW1:
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rax = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

    movl 8(%rcx), %r12d
    movl 8(%rax), %r13d

    imull %r11d, %r12d       # %r12d *= %r8d

    xorl %eax, %eax         # Clear upper bits of %rax for unsigned division
    movl %r13d, %eax        # Load %r13d into %eax for division
    divl %r11d               # %eax = %r13d / %r8d, quotient in %eax

    cmpl %r12d, %eax        # Compare results of multiplication and division
    jne not_geometric_HW1
    jmp is_geometric_HW1

check_geometric_one_from_edge_top_HW1:
    lea node, %rbx    # Load node address into %rbx
    movq (%rbx), %rcx  # rcx = prev pointer
    movq 12(%rcx), %rax # rax = next pointer
    movq (%rcx), %rcx  # rcx = previous node pointer

    movl 8(%rcx), %r12d
    movl 8(%rax), %r13d

    imull %r9d, %r12d       # %r12d *= %r8d

    xorl %eax, %eax         # Clear upper bits of %rax for unsigned division
    movl %r13d, %eax        # Load %r13d into %eax for division
    divl %r9d               # %eax = %r13d / %r8d, quotient in %eax

    cmpl %r12d, %eax        # Compare results of multiplication and division
    jne not_geometric_HW1
    jmp is_geometric_HW1

is_geometric_HW1:
    # Mark as geometric
    orb $2, result(%rip)  # Set result flag to geometric
    jmp end_HW1

not_geometric_HW1:
    jmp end_HW1

geometric_and_arithmetic_HW1:
    movb $3, result(%rip)
    jmp end_HW1

neither_geometric_and_arithmetic_HW1:
    movb $0, result(%rip)
    jmp end_HW1

end_HW1:
    movq $60, %rax
    xor %rdi, %rdi
    syscall
