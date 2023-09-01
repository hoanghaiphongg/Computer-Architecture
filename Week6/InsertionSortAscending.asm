.data
	A: .word 4, -6, 3, 12, 44, 32, 6, -23, 435
	Aend: .word
.text
	la $a0, A
	la $a1, Aend
	li $s0, 0	# count = 0 (count la bien dem phan tu)	
	li $s1, 0	# key = 0
	li $s2, 0	# j = 0	
	li $s3, 1	# i = 1
DemPhanTu:	beq  $a1, $a0, Loop	# So sanh ??a ch? hi?n t?i trong a1 v?i
					# ??a ch? c? s? c?a m?ng A
		addi $a1, $a1, -4	# ??a ch? a1 gi?m ?? ??n t?ng ??a ch? c?a t?ng 
					# ph?n t? trong m?ng
		addi $s0, $s0, 1		# S? l??ng ph?n t? t?ng thêm 1
		j DemPhanTu
Loop:	beq $s3, $s0, Exit	# N?u i = S? l??ng ph?n t? có trong m?ng thì thoát
	sll $t0, $s3, 2		# Tính Offset c?a ??a ch? A[i]
	add $s4, $a0, $t0	# Tính ??a ch? c?a A[i]
	lw $s1, 0($s4)		# Load giá tr? A[i] = key
	addi $s2, $s3, -1	# j = i - 1
While: 	slt $t1, $s2, $zero	# N?u j >= 0 thì t1 = 0 
	sll $t0, $s2, 2		# Tính offset c?a ??a ch? A[j]
	add $s5, $a0, $t0	# Tính ??a ch? c?a A[j]
	lw $t3, 0($s5)		# Load giá tr? A[j] = t3
	sle $t4, $t3, $s1	# N?u key >= t3 thì t4 = 0
	add $t1, $t1, $t4	
	bne $t1, $zero,  loop_continue # N?u t1 = 0 thì d?ng while
	addi $s5, $s5, 4		# Tính ??a ch? c?a A[j+1]
	sw $t3, 0($s5)		# Ghi giá tr? A[j] vào A[j+1]
	addi $s2, $s2, -1	# j = j - 1
	j While			
loop_continue:
	addi $s5, $s5, 4		# Tính ??a ch? c?a A[j+1]
	sw $s1, 0($s5)		# Ghi giá tr? key vào A[j+1]
	addi $s3, $s3, 1		# i++
	j Loop
Exit: 	li $v0, 10
	syscall





















