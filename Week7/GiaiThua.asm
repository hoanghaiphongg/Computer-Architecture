# Laboratory Exercise 7, Assignment 4 Version 2 
# Author: Pham Huy Canh

.data
	message1: .asciiz "Nhap so N (N khong am): "
	message2: .asciiz "Ket qua tinh giai thua la: "
.text
main:	li $v0, 51
	la $a0, message1		# Hien message1 & Nhap so N
	syscall
	bltz $a0, main		# Kiem tra N khong am 
	nop
	
	jal fact
	nop
	
	add $a1, $v0, $zero	# $a1 = ket qua
	li $v0, 56
	la $a0, message2		# Hien message2 va ket qua
	syscall
	
	li $v0, 10		# Exit
	syscall

fact:	addi $sp, $sp, -8	# Cap phat Stack 
	sw $ra, ($sp)
	sw $s0, 4($sp)
	
	li $v0, 1		# v0 = 1
	beq $a0, $zero, endfact		# N = 0 branch to the endfact
	nop
	add $s0, $a0, $zero	# s0 = N
	addi $a0, $a0, -1	# N = N - 1
	jal fact	
	nop
	mul $v0, $v0, $s0	# N! = N * (N-1) * (N-2) *...* 1
endfact:		lw $ra, ($sp)
		lw $s0, 4($sp)
		addi $sp, $sp, 8		# Giai phong Stack
		jr $ra
	
	
























