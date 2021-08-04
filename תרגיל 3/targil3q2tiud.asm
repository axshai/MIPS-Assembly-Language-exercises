#shai axelrod 205544307
.data#טעינת מחרוזות שנשתמש בהם וכן את הערכים
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
la $a0 begin#שמירת כתובת תחילת הבלוק וגודלו באוגרים
li $a1 3

move $s2 $a0
move $s3 $a1
li $t6 1
li $t7 1
li $s1 1
beqz $a1 endcheck#אם אין איברים או שיש איבר אחד בסידרה סיים את הבדיקה
beq $a1 $s1 endcheck
lb $t1 ($a0)
lb $t2 1($a0)
sub $t5 $t2 $t1#הd המשוער
div $t2 $t1
mfhi $t3
 mflo $t4#הq המשוער
 addi $a0 $a0 1
 subi $a1 $a1 1
 beqz $t4 noq#אם q פחות מאחד-אין זו הנדסית
 bnez $t3 noq#אם יש שארית-אין זו הנדסית
 j loop
 noq:#אם זו לא הנדסית-שמור זאת הt6
 li $t6 0
 loop:
 beqz $a1 endcheck#אם סיימנו לבדוק
 beq $a1 $s1 endcheck
 lb $t1 ($a0)
 lb $t2 1($a0)
 sub $t0 $t2 $t1
 bne $t5 $t0 nod#אם ההפרשים בין זוגות איברים לא שווים-סמן שזו לא חשבונית
 j checkq
 nod:
 li $t7 0
 checkq:
 div $t2 $t1
 mfhi $t3
 mflo $s4
 bnez $t3 noq1#אם יש שארית-אין זו הנדסית
 bne $t4 $s4 noq1#אם המנות לא שוות-אין זו הנדסית
 j continue
 noq1:
 li $t6 0
 continue:
 addi $a0 $a0 1
  subi $a1 $a1 1
  j loop
endcheck:
beq $t7 $s1 d#הדפס האם היא חשבונית
li $v0 4
la $a0 str2
syscall 
j conclusionq
d:
li $v0 4
la $a0 str1
syscall 
la $a0 strd#אם היא חשבונית-הדפס את הd
syscall 
li $v0 1
move $a0 $t5
syscall 
li $v0 4
la $a0 endl
syscall 
conclusionq:#הדפס האם היא הנדסית
beq $t6 $s1 q
li $v0 4
la $a0 str4
syscall 
j first
q:#אם היא הנדסית-הדפס את הq
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
first:#הדפסת האיבר הראשון
beqz $s3 end
li $v0 4
la $a0 str5
syscall 
lb $a0 ($s2)
li $v0 1
syscall
end:
