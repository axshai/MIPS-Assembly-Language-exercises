#shai axelrod 205544307
.data  #����� ������� ������� ������� ������ ��
begin:.byte  1 13 14 147 -20 17 28
str:.asciiz "the biggest number is: "
.text#������ �� ����� ����� ����� ������� �� ������ �������
la $a0 begin
li $a1 7
#-----------------------------------------
li $t9 1
beq $a1 $zero endloop#����� ���� ������ ����� ��� �� ������
sub $a1 $a1 $t9
lb $v0 0($a0)
loop:#����� ������ �����-����� ���� �v0 ����� ��� ����
beq $a1 $zero endloop
addi $a0 $a0 1
sub $a1 $a1 $t9
lb $t1 0($a0)
slt $t2 $v0 $t1
beq $t2 0 loop
addi $v0 $t1 0
j loop
endloop:
move $t0 $v0#����� ����� ��� ����
li $v0 4
la $a0 str
syscall
li $v0 1
addi $a0 $t0 0
syscall
