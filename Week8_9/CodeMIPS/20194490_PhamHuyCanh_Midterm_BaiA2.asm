#--------------------------------------#
# Computer Architecture Lab - Midterm  #
# Author: Pham Huy Canh - 20194490     #
# A. So nguyen - Bai 2                 #
#--------------------------------------#

.data
	message1: .asciiz "Nhap so nguyen duong M: "
	error1: .asciiz "ERROR: Yeu cau nhap M la mot so nguyen duong. Vui long nhap lai!\n"
	message2: .asciiz "Nhap so nguyen duong N: "
	error2: .asciiz "ERROR: Yeu cau nhap N la mot so nguyen duong. Vui long nhap lai!\n"
	message3: .asciiz "\nBCNN("
	message4: .asciiz ","
	message5: .asciiz ") = "
.text
NhapM:  li 	$v0, 4			# Thong bao nhap M
	la 	$a0, message1		
	syscall
	li	$v0, 5			# Nhap M
	syscall
	blez	$v0, Error1		# Neu M <= 0 thi bao loi
	add	$s1, $zero, $v0		# Gan gia tri M vao $s1
	j	NhapN
Error1:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error1
	syscall
	j	NhapM			# Quay lai nhap lai M
NhapN:  li 	$v0, 4			# Thong bao nhap N
	la 	$a0, message2
	syscall
	li	$v0, 5			# Nhap N
	syscall
	blez	$v0, Error2		# Neu N <= 0 thi thong bao loi
	add	$s2, $zero, $v0		# Gan gia tri N vao $s2
	j 	Tsugi
Error2:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error2
	syscall
	j	NhapN			# Quay lai nhap lai N
Tsugi:	add	$t0, $zero, $s1		# Gan $t0 = $s1 = M
	add	$t1, $zero, $s2		# Gan $t1 = $s2 = N
While: 	beq	$s1, $s2, BCNN		# Neu M = N thi ket thuc vong lap va nhay den BCNN
	blt	$s1, $s2, Else		# Neu M > N thi thuc hien if; Neu M < N thi nhay den thuc hien else
	sub 	$s1, $s1, $s2		# M = M - N
	j	While
Else:	sub	$s2, $s2, $s1		# N = N - M
	j	While
BCNN: 	mul	$t2, $t0, $t1		# $t2 = M*N (M va N ban dau), day la ket qua cua tich giua UCLN va BCNN
	div	$t2, $t2, $s1		# BCNN = $t2 chia $s1 (UCLN)
# -------------Hien thi thong bao ket qua---------------
# 		    BCNN(M,N) = $t2
	li 	$v0, 4			
	la 	$a0, message3
	syscall
	li	$v0, 1			# Hien thi gia tri M khi nhap vao
	add	$a0, $zero, $t0	
	syscall
	li 	$v0, 4
	la 	$a0, message4
	syscall
	li	$v0, 1			# Hien thi gia tri N khi nhap vao
	add	$a0, $zero, $t1
	syscall
	li 	$v0, 4
	la 	$a0, message5
	syscall
	li	$v0, 1			# Hien thi ket qua BCNN
	add	$a0, $zero, $t2
	syscall
Exit:	li	$v0, 10
	syscall 
