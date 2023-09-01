.data
	A: .word 4, 5, -2, 5, 3, 45
	Aend: .word
.text
	la $a0, A
	la $a1, Aend
	li $s0, 0	# count = 0 (count la bien dem phan tu)
	li $s1, -1	# i = -1 (i trong loopi)
	
DemPhanTu:	beq  $a1, $a0, Size	# So sanh ??a ch? hi?n t?i trong a1 v?i
					# ??a ch? c? s? c?a m?ng A
		addi $a1, $a1, -4	# ??a ch? a1 gi?m ?? ??n t?ng ??a ch? c?a t?ng 
					# ph?n t? trong m?ng
		addi $s0, $s0, 1		# S? l??ng ph?n t? t?ng thêm 1
		j DemPhanTu
Size: 	addi $t0, $s0, -1	# t0 = S? l??ng ph?n t? c?a m?ng A - 1
loop1:	addi $s1, $s1, 1		# i++
	li $s2, 0		# j = 0 (j trong loop2)
	beq $s1, $t0, Exit	# N?u i = size - 1 thì thoát
loop2:	sub $t2, $t0, $s1	# t2 = (size - 1) - i
	beq $s2, $t2, loop1	# N?u j = (size - 1) - i thì nh?y ??n loop1
if_swap:		sll $t3, $s2, 2	# Tính offset c?a ??a ch? A[j] 
		add $s3, $a0, $t3	# Tính ??a ch? A[j]
		lw $v0, 0($s3)		# Load giá tr? A[j]
		addi $s3, $s3, 4		# Tính ??a ch? c?a A[j+1]
		lw $v1, 0($s3)		# Load giá tr? A[j+1]
		sle $t4, $v1, $v0	# N?u A[j+1] <= A[j] thì t4 = 1; 
					# A[j+1] > A[j] thì t4 = 0 
		beq $t4, $zero, swap	# t4 = 0 thì nh?y ??n swap
		addi $s2, $s2, 1		# j++
		j loop2
swap: 	sw $v0, 0($s3)		# Ghi A[j] vào A[j+1]
	addi $s3, $s3, -4	# Tính ??a ch? c?a A[j] = ??a ch? c?a A[j+1] - 4
	sw $v1, 0($s3)		# Ghi A[j+1] vào A[j]
	addi $s2, $s2, 1		# j++
	j loop2
Exit:	li $v0, 10
	syscall
	








