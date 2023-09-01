#--------------------------------------#
# Computer Architecture Lab - Midterm  #
# Author: Pham Huy Canh - 20194490     #
# C. Xau ky tu - Bai 1                 #
#--------------------------------------#

.data
	string: .space 500
	message1: .asciiz "Nhap xau ky tu: "
	error: .asciiz "ERROR: Khong duoc de trong. Vui long nhap lai\n"
	message2: .asciiz "Ky tu ngan nhat trong chuoi vua nhap la: "
	comma: .asciiz ", "
	sqm: .asciiz "'"
.text
	li	$t1, 0			# Khoi tao check = 0
NhapXau:	
	li	$v0, 4			# Thong bao nhap xau
	la	$a0, message1
	syscall
	li	$v0, 8			# Nhap xau
	la	$a0, string
	li	$a1, 500
	syscall
	li	$t0, 0			# Khoi tao i cho Length
Length:	la	$a0, string
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)		# Lay ra string[i] = $t2
	beq	$t2, 10, EndLength	# Kiem tra neu string[i] ='\n' thi ket thuc Length
	addi	$t0, $t0, 1 		# i++
	j	Length	
EndLength:
	add	$s0, $t0, $zero		# Gan $s0 = strlen(string) 
	li	$t0, -1			# Khoi tao i cho For1
For1:	addi	$t0, $t0, 1		# i++
	beq	$t0, $s0, EndFor1	# Kiem tra i = strlen(string) thi ket thuc For1
	la	$a0, string		# 
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)		# Lay ra string[i] = $t2
If1:	beq	$t2, 32, For1		
	beq	$t2, 10, For1
	li	$t1, 1			# Neu string[i] != ' ' && string[i] != '\n' thi gan check = 1
	j	For1
EndFor1:
	bne	$t1, 0, Shortest	# Kiem tra check khac 0 thi khong thong bao loi 
	li	$v0, 4			# In thong bao loi xau rong va quay lai nhap xau
	la	$a0, error		
	syscall
	j	NhapXau
Shortest:
	li	$t3, 0			# Khoi tao count = 0
	li	$t4, 100		# Khoi tao shortest = 100
	li	$t0, -1			# Khoi tao i cho For2
For2:	addi 	$t0, $t0, 1		# i++
	blt	$s0, $t0, EndFor2	# Kiem tra neu strlen(string) < i thì ket thuc vong lap
If3:	la	$a0, string		
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)		# Lay ra string[i]
	beq	$t2, 32, Else3		
	beq	$t2, 10, Else3
	addi	$t3, $t3, 1		# Neu string[i] != ' ' && string[i] != '\n' thi count++, neu dieu kien sai thi thuc hien Else
	j	For2
Else3:	bge	$t3, $t4, ResetCount	# Neu count < shortest && count != 0 thi shortest = count
	beq	$t3, 0, ResetCount
	add	$t4, $t3, $zero		
ResetCount:	
	li	$t3, 0			# count = 0
	j	For2
EndFor2:	li	$t0, -1		# Khoi tao i cho For3
	li	$t1, 0			# $t1 = dem = 0
	li	$t3, 0			# $t3 = z = 0
	li 	$v0, 4			# Thong bao in ket qua
	la	$a0, message2
	syscall
For3:	addi	$t0, $t0, 1		# i++
	beq	$t0, $s0, Exit		# Kiem tra neu i = strlen(string) thi ket thu For3
If4:	la	$a0, string		
	add	$t2, $t0, $a0	
	lb	$t5, 0($t2)		# Lay ra string[i]
	lb	$t6, 1($t2)		# Lay ra string[i+1]
	beq	$t5, 32, Else4		# Kiem tra neu string[i] = ' ' thi thuc hien Else4
	addi	$t1, $t1, 1		# dem++
If5:	bne	$t1, $t4, For3		# Kiem tra neu dem = shortest thi kiem tra tiep lenh ben duoi, neu khong bang thi quay lai For3
	beq	$t6, 32, If6		# Kiem tra string[i+1] = ' ' thi nhay den If6
	beq	$t6, 10, If6		# Kiem tra string[i+1] = '\0' thi nhay den If6
	j	For3			# Neu cac dieu kien tren khong thoa man thi quay lai For3
If6:	beq	$t3, 0, EndIf6		# Kiem tra neu z = 0 thi khong thuc hien lenh trong If6
	li	$v0, 4			# In dau ", "
	la	$a0, comma
	syscall	
EndIf6:	li	$v0, 4			# In dau nhay don
	la	$a0, sqm
	syscall

# In ket qua
	sub	$t7, $t0, $t1		# Khoi tao j = i - dem + 1
For4:	addi	$t7, $t7, 1		# j++
	bgt	$t7, $t0, EndFor4	# Kiem tra neu j > i thi ket thuc For4
	la	$a0, string
	add	$a0, $t7, $a0
	lb	$a0, 0($a0)		# Lay ra string[j]
	li	$v0, 11			# In ra string[j]
	syscall
	j	For4		
EndFor4:	
	li	$v0, 4			# In dau nhay don 
	la	$a0, sqm
	syscall
	add	$t3, $t3, 1		# z++
	j	For3
Else4:	li	$t1, 0			# Dem = 0
	j	For3
Exit:	li	$v0, 10			# Exit
	syscall
