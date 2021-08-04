.data
str1:.asciiz "enter number: "
str2:.asciiz "the sum is: "
.text
li $t1 -100
li $t5 0
loop:
li $v0 4
la $a0 str1
syscall
li $v0 5
syscall
beq $v0 $zero endloop
slti $t3 $v0 100
slt $t4 $t1 $v0
beq $t3 $zero loop
beq $t4 $zero loop
add $t5 $t5 $v0
j loop
endloop:
li $v0 4
la $a0 str2
syscall
li $v0 1
addi $a0 $t5 0
syscall
