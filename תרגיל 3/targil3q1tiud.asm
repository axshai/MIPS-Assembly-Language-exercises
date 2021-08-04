#shai axelrod 205544307
.data#הכנסת נתונים לבלוק וכן מחרוזות שנשתמש בהם
str:.asciiz "the sorted numbers are: "
str2:.asciiz " "
array:.word  4 2 5 3 1 -6
.text#שמירת כתובת תחילת הבלוק וגודלו
la $a0 array
li $a1 6
li $s1 -1
#-----------------------------------------------
move $t7 $a1
loop1:#הלולאה החיצונית במיון בועות-שומרת את הקצה הימני שאליו יבועבע האיבר הגדול
subi $t7 $t7 1
beqz $t7 endsort#במידה והמיון הסתיים-צא מהלולאה
beq $t7 $s1 endsort
move $t0 $a0
move $t1 $t7
loop2:#הלולאה הפנימית-ביעבוע האיבר הגדול לקצה הימני
beqz $t1 loop1
la $t2 4($t0)#שומרים את שתי המספרים הנבדקים באוגרים-ואם צריך מחליפים ביניהם
lw $t3 ($t0)
lw $t4 ($t2)
slt $t5 $t4 $t3
beqz $t5 endswap
sw $t4 ($t0)
sw $t3 ($t2)
endswap:
addi $t0  $t0 4
subi $t1  $t1 1
j loop2
endsort:
move $t0 $a0
li $v0 4#הדפסת המספרים הממוינים
la $a0 str
syscall 
printloop:#הלולאה שמדפיסה את המספרים
beqz $a1 endprint
li $v0 1
lw $a0 ($t0)
syscall
li $v0 4
la $a0 str2
syscall 
addi $t0 $t0 4
subi $a1 $a1 1
j printloop
endprint:
