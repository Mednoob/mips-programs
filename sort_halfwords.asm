# Register yang digunakan
# s0 => instruksi sorting yang digunakan. 1 = asc dan 2 = desc
# s1 => angka looping sekarang
# s2 => angka looping bagian dalam
# s3 => index yang menyimpan nilai endpoint

# s4 => tempat sementara untuk menaruh konten sales_1($s3)
# s5 => tempat sementara untuk menaruh konten sales_1($s2)

# s6 => penyimpanan hasil comparison $s4 dengan $s6 sesuai dengan instruksi di $s0
# s7 => penyimpanan return address untuk kembali ke instruksi utama

.text
main:
	li $v0, 4
	la $a0, intro
	syscall

	li $v0, 5
	syscall

	move $s0, $v0
	j main_loop

main_loop:
	lh $t0, sales_1($s1)
	blt $t0, 0, show_datas

	move $s2, $s1
	move $s3, $s1
	lh $s4, sales_1($s3)

	j inner_loop

inner_loop:
	lh $s5, sales_1($s2)
	blt $s5, 0, back_to_main_loop

	jal compare

	bgt $s6, 0, set_end
	j back_to_inner_loop

compare:
	move $s7, $ra
	beq $s0, 1, inst_1
	beq $s0, 2, inst_2

inst_1:
	sub $s6, $s4, $s5
	jr $s7

inst_2:
	sub $s6, $s5, $s4
	jr $s7

set_end:
	lh $s4, sales_1($s2)
	move $s3, $s2

	j back_to_inner_loop

back_to_inner_loop:
	add $s2, $s2, 4
	j inner_loop

back_to_main_loop:
	# Swapping process
	lh $t0, sales_1($s1)
	sh $s4, sales_1($s1)
	sh $t0, sales_1($s3)

	add $s1, $s1, 4
	j main_loop

show_datas:
	li $v0, 4
	la $a0, outro
	syscall

	li $s1, 0
	j show_loop

show_loop:
	lh $t0, sales_1($s1)
	blt $t0, 0, ends

	li $v0, 4
	la $a0, spasi
	syscall

	li $v0, 1
	lh $a0, sales_1($s1)
	syscall

	add $s1, $s1, 4
	j show_loop

ends:
	li $v0, 10
	syscall

.data
sales_1: .word 30,25,32,30,50,75,70,-1
intro: .asciiz "Pilih instruksi (1 = ASC, 2 = DESC) = "
outro: .asciiz "\nHasil sorting ="
spasi: .asciiz " "
