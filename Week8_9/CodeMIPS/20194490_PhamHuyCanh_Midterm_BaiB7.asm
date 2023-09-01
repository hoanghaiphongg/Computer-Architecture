#--------------------------------------#
# Computer Architecture Lab - Midterm  #
# Author: Pham Huy Canh - 20194490     #
# B. Mang - Bai 7                      #
#--------------------------------------#

.data
	A: .space 400
	B: .space 400
	C: .space 400
	D: .space 400
	arrMes1: .asciiz "A["
	arrMes2: .asciiz "] = "
	message1: .asciiz "Nhap so phan tu cua mang: "
	message2: .asciiz "Phan tu co so lan xuat hien it nhat trong mang A la:"
	message3: .asciiz "\nPhan tu: "
	message4: .asciiz " - Xuat hien o vi tri: "
	space: .asciiz " "
	error: .asciiz "ERROR: So phan tu mang phai la mot so duong. Vui long nhap lai!\n"
.text
NhapN:	li 	$v0, 4			# Thong bao nhap so phan tu mang A
	la 	$a0, message1
	syscall
	li	$v0, 5			# Nhap N
	syscall
	blez	$v0, Error		# Neu N <= 0 thi thong bao loi va nhap lai N
	add	$s0, $zero, $v0		# s0 = N
	j	NhapMang
Error:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error
	syscall
	j	NhapN			# Quay lai nhap lai N
NhapMang:
	li	$t0, -1			# Khoi tao i cho vong For1
	
For1:	addi	$t0, $t0, 1		# i = i + 1
	bge	$t0, $s0, EndFor1	# Neu i = N thi ket thuc vong For1
	# Thong bao nhap tung phan tu cua mang
	#		A[i] = 
	li 	$v0, 4
	la 	$a0, arrMes1
	syscall
	li	$v0, 1			
	add	$a0, $zero, $t0
	syscall
	li 	$v0, 4
	la 	$a0, arrMes2
	syscall
	
	li	$v0, 5			# Nhap gia tri phan tu
	syscall
	la	$a0, A			# Ghi gia tri vua nhap vao phan tu A[i]
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	sw	$v0, 0($t1)
	j	For1			# Tiep tuc vong lap
EndFor1:	li	$t0, -1			# Khoi tao i cho vong For2
For2:	addi	$t0, $t0, 1		# i = i + 1
	beq	$t0, $s0, EndFor2	# Neu i = N thi ket thuc vong For2
	la	$a0, B			# Gan B[i] bang 1
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	li	$v0, 1
	sw	$v0, 0($t1)
	j	For2			# Tiep tuc vong lap
EndFor2:	li	$t0, -1			# Khoi tao i cho vong For3
	li	$t5, 0			# Khoi tao k = 0
For3:	addi	$t0, $t0, 1		# i = i + 1
	beq	$t0, $s0, EndFor3	# Neu i = N thi ket thuc vong For3
	li	$v1, 1			# Khoi tao Count = 1
If1:	la	$a0, B			# Lay gia tri B[i] = $v0
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	lw	$v0, 0($t1)
	beq	$v0, $zero, For3		# Neu B[i] = 0 bo qua cau lenh trong If1 tiep tuc vong lap
	li	$v0, 0			# Gan B[i] = 0
	sw	$v0, 0($t1)
	addi	$t2, $t0, 0		# Khoi tao j cho vong lap For 4 nam trong For3
For4:	addi	$t2, $t2, 1		# j = i + 1
	beq	$t2, $s0, EndFor4	# Neu j = N thi ket thuc For4
If2:	la	$a0, A
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	lw	$t1, 0($t1)		# Lay gia tri A[i]
	sll	$t3, $t2, 2
	add	$t3, $t3, $a0
	lw	$t3, 0($t3)		# Lay gia tri A[j]
	bne	$t1, $t3, EndIf2		# Kiem tra, neu A[j] != A[i] thi khong chay lenh trong If2 va tiep tuc vong lap
	addi 	$v1, $v1, 1		# Count++
	la	$a0, B			# Gan B[j] = 0
	sll	$t3, $t2, 2		
	add	$t3, $t3, $a0
	li	$t4, 0
	sw	$t4, 0($t3)		
EndIf2: j	For4			
EndFor4:la	$a0, A			# Lay gia tri A[i]
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	lw	$t1, 0($t1)
	
	la	$a0, C			# Ghi C[k] = A[i]
	sll	$t2, $t5, 2
	add	$t2, $t2, $a0
	sw	$t1, 0($t2)
	
	la	$a0, D			# Ghi D[k] = Count
	sll	$t2, $t5, 2
	add	$t2, $t2, $a0
	sw	$v1, 0($t2)	
	addi	$t5, $t5, 1		# k = k + 1
	j	For3			# Quay lai For3 tiep tuc vong lap
EndFor3:	li	$t0, 0			# Khoi tao i cho For5
	la	$a0, D			
	lw	$t6, 0($a0)		# Gan min = D[0]
For5:	addi 	$t0, $t0, 1		# i = i + 1
	beq	$t0, $t5, EndFor5	# Neu i = N thi ket thuc For5
If3:	la	$a0, D			# Lay gia tri D[i]
	sll	$t2, $t0, 2		
	add	$t2, $t2, $a0
	lw	$t2, 0($t2)
	bge	$t2, $t6, For5		# Neu D[i] >= min thi bo qua If tiep tuc vong lap
	add	$t6, $t2, $zero		# Neu D[i] < min thi gan min = D[i]
	j	For5
	# Hien thi ket qua 
EndFor5:li 	$v0, 4
	la 	$a0, message2
	syscall	
	li	$t0, -1			# Khoi tao i cho vong For6
For6:	addi	$t0, $t0, 1		# i = i + 1
	beq	$t0, $t5, Exit		# Neu i = k thi thoat
If4:	la	$a0, D			# Lay gia tri D[i]
	sll	$t2, $t0, 2
	add	$t2, $t2, $a0
	lw	$t2, 0($t2)
	bne	$t2, $t6, For6		# Neu D[i] != min thi bo qua If4 va quay lai vong lap
	
	# In gia tri phan tu
	li 	$v0, 4			
	la 	$a0, message3
	syscall
	
	la 	$a0, C			# Lay va in ra gia tri cua phan tu C[i]
	sll	$t2, $t0, 2
	add	$t2, $a0, $t2
	lw	$a0, 0($t2)
	li	$v0, 1
	syscall
	# In vi tri cua phan tu trong mang A
	li 	$v0, 4
	la 	$a0, message4
	syscall
	li 	$t2, -1			# Khoi tao j cho For7
For7:	addi	$t2, $t2, 1		# j = j + 1
	beq	$t2, $s0, EndFor7	# Neu j = N thi ket thuc For7
If5:	la 	$a0, A			# Lay gia tri A[j]
	sll	$t3, $t2, 2
	add	$t3, $a0, $t3
	lw	$t3, 0($t3)
	
	la 	$a0, C			# Lay gia tri C[i]
	sll	$t4, $t0, 2		
	add	$t4, $a0, $t4
	lw	$t4, 0($t4)
	
	bne	$t3, $t4, For7		# Neu A[j] != C[i] thi bo qua If5 va tiep tuc vong lap
		
	li	$v0, 1			# In ra j (chi so cua phan tu thoa man)
	add	$a0, $t2, $zero
	syscall
	li 	$v0, 4
	la 	$a0, space
	syscall
	j 	For7
EndFor7:j	For6	
Exit:	li	$v0, 10			# Thoat
	syscall
		
	
	
