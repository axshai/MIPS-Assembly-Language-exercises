#הסבר כללי:נעבור על בלוק הנתונים ועבור כל מקום נמצא האם 6 הספרות החל מהמקום הנל
#תואמות לקוד.אם כן-נוציא הודעה שמצאנו.אם לא-נעבור לחפש הקוד מהמקום הבא
#בבלוק עד שנגיע למקום בבלוק שממנו עד הסוף אין 6 ספרות
.data 
str1:.asciiz "enter code\n"
str2:.asciiz "found\n"
str3:.asciiz "not found\n"
begindata:.byte 2 2 2 6 5 3 9 7 8 5 4 2 7 1 4 6 7 8 9 0 8 9 5 3 2 2 5 3 2 5 5 5
begincode:.byte
.text
la $s0 begindata#s1 s0 מכילים את כתובות תחילת הבלוק והקוד
la $s1 begincode
li $v0 4
la $a0 str1
syscall 

li $t0 6#קליטת הקוד ואיחסונו בזיכרון
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
outloop:#לולאה חיצונית לבדיקת התאמת הקוד מהמקום הi בבלוק
move $s0 $s2
la $s1 begincode
li $t0 6
inloop1:#לולאה פנימית לבדיקת התאמת הסיפרה הj בקוד לסיפרה הj+i בבלוק
lb $t1 ($s0)
lb $t2 ($s1)
beq $t1 $t2 equal
bgt $t4 27 notfound#אם הגעת לקצה הבלוק-5 הוצא הודעה שהקוד לא נמצא
addi $s2 $s2 1
addi $t4 $t4 1
j outloop

equal:#אם הספרות שוות-חפש את הסיפרה הבאה
addi $s1 $s1 1
addi $s0 $s0 1
subi $t0 $t0 1
beqz $t0 found#אם מצאת את כל הספרות-הוצא הודעה מתאימה
j inloop1

found:#הדפסה מתאימה למקרה שהקוד נמצא
li $v0 4
la $a0 str2
syscall 
j printcode

notfound:#הדפסה למקרה שהקוד לא נמצא
li $v0 4
la $a0 str3
syscall 

printcode:#הדפסת הקוד שהוכנס
li $v0 1
li $t0 6
la $s0 begincode
loop2:#לולאה להדפסה-הוצא את הסיפרה הi מהזיכרון והדפס אותה
lb $a0 ($s0)
syscall
li $a0 ' '
li $v0 11
syscall
li $v0 1
subi $t0 $t0 1
beqz $t0 end#אם הדפסת 6 ספרות-גמור את התוכנית
addi $s0 $s0 1
j loop2
end:
