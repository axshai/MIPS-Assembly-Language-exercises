#shai axelrod 205544307
.data#����� ������� ������ ��� ��� �� ������
str1:.asciiz "Arithmetic progression\n"
str2:.asciiz "not Arithmetic progression\n"
str3:.asciiz "Geometric progression\n"
str4:.asciiz "not Geometric progression\n"
str5:.asciiz "the first num: "
strd:.asciiz "d: "
strq:.asciiz "q: "
endl:.asciiz "\n"
begin:.byte  2 2 3 
.text
la $a0 begin#����� ����� ����� ����� ������ �������
li $a1 3

move $s2 $a0
move $s3 $a1
li $t6 1
li $t7 1
li $s1 1
beqz $a1 endcheck#�� ��� ������ �� ��� ���� ��� ������ ���� �� ������
beq $a1 $s1 endcheck
lb $t1 ($a0)
lb $t2 1($a0)
sub $t5 $t2 $t1#�d ������
div $t2 $t1
mfhi $t3
 mflo $t4#�q ������
 addi $a0 $a0 1
 subi $a1 $a1 1
 beqz $t4 noq#�� q ���� ����-��� �� ������
 bnez $t3 noq#�� �� �����-��� �� ������
 j loop
 noq:#�� �� �� ������-���� ��� �t6
 li $t6 0
 loop:
 beqz $a1 endcheck#�� ������ �����
 beq $a1 $s1 endcheck
 lb $t1 ($a0)
 lb $t2 1($a0)
 sub $t0 $t2 $t1
 bne $t5 $t0 nod#�� ������� ��� ����� ������ �� �����-��� ��� �� �������
 j checkq
 nod:
 li $t7 0
 checkq:
 div $t2 $t1
 mfhi $t3
 mflo $s4
 bnez $t3 noq1#�� �� �����-��� �� ������
 bne $t4 $s4 noq1#�� ����� �� ����-��� �� ������
 j continue
 noq1:
 li $t6 0
 continue:
 addi $a0 $a0 1
  subi $a1 $a1 1
  j loop
endcheck:
beq $t7 $s1 d#���� ��� ��� �������
li $v0 4
la $a0 str2
syscall 
j conclusionq
d:
li $v0 4
la $a0 str1
syscall 
la $a0 strd#�� ��� �������-���� �� �d
syscall 
li $v0 1
move $a0 $t5
syscall 
li $v0 4
la $a0 endl
syscall 
conclusionq:#���� ��� ��� ������
beq $t6 $s1 q
li $v0 4
la $a0 str4
syscall 
j first
q:#�� ��� ������-���� �� �q
li $v0 4
la $a0 str3
syscall 
la $a0 strq
syscall 
li $v0 1
move $a0 $t4
syscall 
li $v0 4
la $a0 endl
syscall 
first:#����� ����� ������
beqz $s3 end
li $v0 4
la $a0 str5
syscall 
lb $a0 ($s2)
li $v0 1
syscall
end:
