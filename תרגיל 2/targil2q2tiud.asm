#shai axelrod 205544307
.data#טעינת מחרוזות שנשתמש בהם לזיכרון
str1:.asciiz "\nENTER VALUE: "
str2:.asciiz "ENTER OP CODE: "
str3:.asciiz "ERROR: "
str4:.asciiz "\nthe result is: "
.text
li $s3 '+'
li $s4 '-'
li $s5 '@'
#קליטת המספר הראשון
li $v0 4
la $a0 str1
syscall 
li $v0 5
syscall
addi $t0 $v0 0
#op codeקליטת 
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
beq $t1 $s3 plus#קפוץ לביצוע חיבור אם הוכנס פלוס
beq $t1 $s4 minus#קפוץ לביצוע חיסור אם הוכנס מינוס

mult:#אם הוכנס כפל
li $v0 5
syscall
mult $t0 $v0
mfhi $s1
mflo $s2
slt $t3 $zero $s2#+
beq $t3 1 loplus
#במידה שהlo שלילי
beq $s1 -1 okmult#אם המכפלה בסדר קפוץ לokmult
li $v0 4#אם לא הדפס שגיאה וסיים
la $a0 str3
syscall 
j end2
#במידה שהlo חיובי
loplus:
beq $s1 $zero okmult#אם המכפלה בסדר קפוץ לokmult
li $v0 4#אם לא הדפס שגיאה וסיים
la $a0 str3
syscall 
j end2
okmult:
addi $t0 $s2 0
j opcod

plus:#אם הוכנס פלוס בצע חיבור
li $v0 5
syscall
add $t0 $t0 $v0 
j opcod

minus:#אם הוכנס מינוס בצע חיסור
li $v0 5
syscall
sub $t0 $t0 $v0 
j opcod

end:#הדפסת התוצאה
li $v0 4
la $a0 str4
syscall 
li $v0 1
addi $a0 $t0 0
syscall
end2:
