#shai axelrod 205544307
.data#����� ������� ������ ��� �������
str1:.asciiz "\nENTER VALUE: "
str2:.asciiz "ENTER OP CODE: "
str3:.asciiz "ERROR: "
str4:.asciiz "\nthe result is: "
.text
li $s3 '+'
li $s4 '-'
li $s5 '@'
#����� ����� ������
li $v0 4
la $a0 str1
syscall 
li $v0 5
syscall
addi $t0 $v0 0
#op code����� 
opcod:
li $v0 4
la $a0 str2
syscall 
li $v0 12
syscall
addi $t1 $v0 0
beq $t1 $s5 end
li $v0 4
la $a0 str1
syscall 
beq $t1 $s3 plus#���� ������ ����� �� ����� ����
beq $t1 $s4 minus#���� ������ ����� �� ����� �����

mult:#�� ����� ���
li $v0 5
syscall
mult $t0 $v0
mfhi $s1
mflo $s2
slt $t3 $zero $s2#+
beq $t3 1 loplus
#����� ��lo �����
beq $s1 -1 okmult#�� ������ ���� ���� �okmult
li $v0 4#�� �� ���� ����� �����
la $a0 str3
syscall 
j end2
#����� ��lo �����
loplus:
beq $s1 $zero okmult#�� ������ ���� ���� �okmult
li $v0 4#�� �� ���� ����� �����
la $a0 str3
syscall 
j end2
okmult:
addi $t0 $s2 0
j opcod

plus:#�� ����� ���� ��� �����
li $v0 5
syscall
add $t0 $t0 $v0 
j opcod

minus:#�� ����� ����� ��� �����
li $v0 5
syscall
sub $t0 $t0 $v0 
j opcod

end:#����� ������
li $v0 4
la $a0 str4
syscall 
li $v0 1
addi $a0 $t0 0
syscall
end2:
