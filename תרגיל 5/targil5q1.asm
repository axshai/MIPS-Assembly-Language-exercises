#���� ����:����� �� ���� ������� ����� �� ���� ���� ��� 6 ������ ��� ������ ���
#������ ����.�� ��-����� ����� ������.�� ��-����� ���� ���� ������ ���
#����� �� ����� ����� ����� ����� �� ���� ��� 6 �����
.data 
str1:.asciiz "enter code\n"
str2:.asciiz "found\n"
str3:.asciiz "not found\n"
begindata:.byte 2 2 2 6 5 3 9 7 8 5 4 2 7 1 4 6 7 8 9 0 8 9 5 3 2 2 5 3 2 5 5 5
begincode:.byte
.text
la $s0 begindata#s1 s0 ������ �� ������ ����� ����� �����
la $s1 begincode
li $v0 4
la $a0 str1
syscall 

li $t0 6#����� ���� �������� �������
loop:
beqz $t0 endloop
li $v0 5
syscall
sb $v0 ($s1)
addi $s1 $s1 1
subi $t0 $t0 1
j loop
endloop:

li $t4 1
move $s2 $s0
outloop:#����� ������� ������ ����� ���� ������ �i �����
move $s0 $s2
la $s1 begincode
li $t0 6
inloop1:#����� ������ ������ ����� ������ �j ���� ������ �j+i �����
lb $t1 ($s0)
lb $t2 ($s1)
beq $t1 $t2 equal
bgt $t4 27 notfound#�� ���� ���� �����-5 ���� ����� ����� �� ����
addi $s2 $s2 1
addi $t4 $t4 1
j outloop

equal:#�� ������ ����-��� �� ������ ����
addi $s1 $s1 1
addi $s0 $s0 1
subi $t0 $t0 1
beqz $t0 found#�� ���� �� �� ������-���� ����� ������
j inloop1

found:#����� ������ ����� ����� ����
li $v0 4
la $a0 str2
syscall 
j printcode

notfound:#����� ����� ����� �� ����
li $v0 4
la $a0 str3
syscall 

printcode:#����� ���� ������
li $v0 1
li $t0 6
la $s0 begincode
loop2:#����� ������-���� �� ������ �i �������� ����� ����
lb $a0 ($s0)
syscall
li $a0 ' '
li $v0 11
syscall
li $v0 1
subi $t0 $t0 1
beqz $t0 end#�� ����� 6 �����-���� �� �������
addi $s0 $s0 1
j loop2
end:
