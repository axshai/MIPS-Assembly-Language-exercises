#����� ����� ������ �0 ����� 0 ���� 0
.data
str4:.asciiz "\n"
str1:.asciiz "ENTER VALUE: "
str2:.asciiz "ENTER OP CODE: "
str3:.asciiz "the result is: "
.text
li $s1 '+'
li $s2 '*'
li $s3 '^'

li $v0 4#����� ����
la $a0 str1
syscall
li $v0 5
syscall
move $t5 $v0#���� 1

li $v0 4#����� �����
la $a0 str2
syscall
li $v0 12
syscall
move $t4 $v0#�����
li $v0 4
la $a0 str4
syscall
li $v0 4
la $a0 str1
syscall 
li $v0 5#����� ����
syscall
move $a1 $v0#���� 2
move $a0 $t5#���� 1

beq $t4 $s1 sum#���� ���� ����� ��� ����
beq $t4 $s2 mult1
beq $t4 $s3 power
j end

sum:#�� ����-���� �������� �����
jal sumfun
j end

mult1:#�� �����-���� �������� ������
jal mult1fun
j end

power:#�� ����-���� �������� �����
jal powerfun
j end

powerfun:#������� �����
subi $sp $sp 12#����� ���� ��������� �������
sw $ra 8($sp)
sw $a1 4($sp)
sw $a0 0($sp)
bnez $a0 continue#�� ����� 0
li $v0 0 
j endpowerfun
continue:
bgtz $a1 plus
li $v0 1#�� ������ 0
j endpowerfun

plus:#���� �� "���� ���"
move $t1 $a1
move $a1 $a0
li $a0 1
beqz $t1 endpowerfun
loop:#����� �������� ���� ������
jal mult1fun
move $a0 $v0
subi $t1 $t1 1
beqz $t1 endpowerfun
j loop

endpowerfun:#����� ������ �������� ������ ���������
lw $a0 0($sp)
lw $a1 4($sp)
lw $ra 8($sp)
addi $sp $sp 12
jr $ra

mult1fun:#������� ����
subi $sp $sp 12#����� ���� ��������� �������
sw $ra 8($sp)
sw $a1 4($sp)
sw $a0 0($sp)

move $t0 $a1
move $a1 $a0
li $a0 0
beqz $t0 endmultfun
loop1:#����� �������� ������ ������
jal sumfun
move $a0 $v0
subi $t0 $t0 1
beqz $t0 endmultfun
j loop1

endmultfun:#����� ������ �������� ������ ���������
lw $a0 0($sp)
lw $a1 4($sp)
lw $ra 8($sp)
addi $sp $sp 12
jr $ra

sumfun:#������� ������
add $v0 $a1 $a0
jr $ra

end:#����� ������
addi $t5 $v0 0
li $v0 4
la $a0 str3
syscall
addi $a0 $t5 0
li $v0 1
syscall
