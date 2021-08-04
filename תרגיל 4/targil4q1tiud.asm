#הנחתי לצורך התרגיל ש0 בחזקת 0 שווה 0
.data
str4:.asciiz "\n"
str1:.asciiz "ENTER VALUE: "
str2:.asciiz "ENTER OP CODE: "
str3:.asciiz "the result is: "
.text
li $s1 '+'
li $s2 '*'
li $s3 '^'

li $v0 4#הכנסת מספר
la $a0 str1
syscall
li $v0 5
syscall
move $t5 $v0#מספר 1

li $v0 4#הכנסת פעולה
la $a0 str2
syscall
li $v0 12
syscall
move $t4 $v0#פעולה
li $v0 4
la $a0 str4
syscall
li $v0 4
la $a0 str1
syscall 
li $v0 5#הכנסת מספר
syscall
move $a1 $v0#מספר 2
move $a0 $t5#מספר 1

beq $t4 $s1 sum#בדוק איזה פעולה הוא רוצה
beq $t4 $s2 mult1
beq $t4 $s3 power
j end

sum:#אם פלוס-קפוץ לפונקצית הפלוס
jal sumfun
j end

mult1:#אם מכפלה-קפוץ לפונקצית המכפלה
jal mult1fun
j end

power:#אם חזקה-קפוץ לפונקצית החזקה
jal powerfun
j end

powerfun:#פונקצית החזקה
subi $sp $sp 12#שמירת ערכי הרגיסטרים במחסנית
sw $ra 8($sp)
sw $a1 4($sp)
sw $a0 0($sp)
bnez $a0 continue#אם הבסיס 0
li $v0 0 
j endpowerfun
continue:
bgtz $a1 plus
li $v0 1#אם המעריך 0
j endpowerfun

plus:#כשזה לא "מקרי קצה"
move $t1 $a1
move $a1 $a0
li $a0 1
beqz $t1 endpowerfun
loop:#קריאה לפונקצית הכפל בלולאה
jal mult1fun
move $a0 $v0
subi $t1 $t1 1
beqz $t1 endpowerfun
j loop

endpowerfun:#שחזור הערכים מהמחסנית ויציאה מהפונקציה
lw $a0 0($sp)
lw $a1 4($sp)
lw $ra 8($sp)
addi $sp $sp 12
jr $ra

mult1fun:#פונקצית הכפל
subi $sp $sp 12#שמירת ערכי הרגיסטרים במחסנית
sw $ra 8($sp)
sw $a1 4($sp)
sw $a0 0($sp)

move $t0 $a1
move $a1 $a0
li $a0 0
beqz $t0 endmultfun
loop1:#קריאה לפונקצית החיבור בלולאה
jal sumfun
move $a0 $v0
subi $t0 $t0 1
beqz $t0 endmultfun
j loop1

endmultfun:#שחזור הערכים מהמחסנית ויציאה מהפונקציה
lw $a0 0($sp)
lw $a1 4($sp)
lw $ra 8($sp)
addi $sp $sp 12
jr $ra

sumfun:#פונקצית החיבור
add $v0 $a1 $a0
jr $ra

end:#הדפסת התוצאה
addi $t5 $v0 0
li $v0 4
la $a0 str3
syscall
addi $a0 $t5 0
li $v0 1
syscall
