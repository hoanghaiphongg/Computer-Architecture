#--------------------------------------#
# Computer Architecture Lab - Midterm  #
# Author: Pham Huy Canh - 20194490     #
# C. Xau ky tu - Bai 1                 #
#--------------------------------------#

.data
	string: .space 500
	message1: .asciiz "Nhap xau ky tu: "
	error: .asciiz "ERROR: Khong duoc de trong. Vui long nhap lai"
	message2: .asciiz "Ky tu ngan nhat trong chuoi vua nhap la: "
.text
	li	$t1, 0			# check = 0
NhapXau:	
	li	$v0, 4
	la	$a0, message1
	syscall
	
	li	$v0, 8
	la	$a0, string
	li	$a1, 500
	syscall
	li	$t0, 0			# Khoi tao i cho Length
Length:	la	$a0, string
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)
	beq	$t2, 10, EndLength
	addi	$t0, $t0, 1 
	j	Length	
EndLength:
	add	$s0, $t0, $zero		# $s0 = Length of string
#	li	$t0, -1			# Khoi tao i cho For1
#For1:	addi	$t0, $t0, 1		# i++
#	
#EndFor:
	
	
