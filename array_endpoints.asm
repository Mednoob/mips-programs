# Pertama kita definisi-in dulu aja di awal tiap-tiap register yang dibutuhin
# Supaya lebih gampang

# s0 => Index yang lagi di cek
# s1 => Index dengan value endpoint
# s2 => Nilai endpoint sekarang
# t0 => Penyimpanan value pada index yang sedang di cek pada tiap loop

.text
main:
	li $v0, 4
	la $a0, intro
	syscall

	li $v0, 5
	syscall

	li $s0, 4
	li $s1, 0
	lh $s2, arr($s1)

	beq $v0, 1, get_max
	beq $v0, 2, get_min

	li $v0, 4
	la $a0, invalid
	syscall

	j main

# AMBIL MAX VALUE
get_max:
	lh $t0, arr($s0)
	blt $t0, 0, ends

	bgt $t0, $s2, set_value_max
	add $s0, $s0, 4
	j get_max

set_value_max:
	move $s1, $s0
	lh $s2, arr($s1)

	add $s0, $s0, 4
	j get_max


# AMBIL MIN VALUE
get_min:
	lh $t0, arr($s0)
	blt $t0, 0, ends

	blt $t0, $s2, set_value_min
	add $s0, $s0, 4
	j get_min

set_value_min:
	move $s1, $s0
	lh $s2, arr($s1)

	add $s0, $s0, 4
	j get_min


# Program End
ends:
	li $v0, 4
	la $a0, out
	syscall

	li $v0, 1
	move $a0, $s2
	syscall

	li $v0, 10
	syscall

.data
arr: .word 30,25,32,30,50,75,70,-1
intro: .asciiz "Pilih Instruksi\n1. Ambil max value\n2. Ambil min value\nPilihan = "
invalid: .asciiz "Instruksi invalid. Silahkan coba lagi\n"
out: .asciiz "\nDengan instruksi yang diberikan, saya mendapatkan nilai = "
