.text
main:
	li $v0, 4
	la $a0, intro
	syscall

	li $v0, 6
	syscall

	li $v0, 4
	la $a0, outro
	syscall

	li $v0, 2
	mfc1.d $s1, $f0
	mtc1.d $s1, $f12
	syscall

	li $v0, 10
	syscall

.data
intro: .asciiz "Give me a floating-point number: "
outro: .asciiz "\nNumber received: "
