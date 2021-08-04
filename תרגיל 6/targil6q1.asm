#התרגיל בגירסתו הנוכחית מתאים למטריצות של עד 25 ערכים-ניתן לשנות זאת בקלות עם שינוי שורות 3 4 5
.data#שמירת מקום למטריצות ואיחסון מחרוזות נצרכות
A:.space 100
B:.space 100
C:.space 100
str:.asciiz"\n"
str1:.asciiz "Enter matrix A dimensions(NxM)\n"
str2:.asciiz "Enter matrix B dimensions(NxM)\n"
str3:.asciiz"The dimensions are wrong\n"
str4:.asciiz"Enter data for the first row\n"
str5:.asciiz"Enter data for the next row\n"
str6:.asciiz"Enter data for matrix A\n"
str7:.asciiz"Enter data for matrix B\n"
str8:.asciiz"\t"
str9:.asciiz"A:\n"
str10:.asciiz"B:\n"
str11:.asciiz"C:\n"
.text
#קליטת המימדים:
loop:
li $v0 4#קליטת מימדי A
la $a0 str1
syscall 
li $v0 5
syscall 
move $s0 $v0
li $v0 12
syscall 
li $v0 4
la $a0 str
syscall 
li $v0 5
syscall 
move $s1 $v0

li $v0 4#קליטת מימדי B
la $a0 str2
syscall 
li $v0 5
syscall 
move $s2 $v0
li $v0 12
syscall 
li $v0 4
la $a0 str
syscall 
li $v0 5
syscall 
move $s3 $v0

beq $s1 $s2 endloop#בדיקת תקינות מימדים
li $v0 4
la $a0 str3
syscall 
j loop
endloop:

li $v0 4
la $a0 str6
syscall 
move $t0 $s0#קלט נתוני A
la $t2 A
li $v0 4
la $a0 str4
syscall 
loop2:
move $t1 $s1
loop1:
li $v0 5
syscall 
sw $v0 ($t2)
subi $t1 $t1 1
addi $t2 $t2 4
beqz $t1 endloop1
j loop1
endloop1:
subi $t0 $t0 1
beqz $t0 endloop2
li $v0 4
la $a0 str5
syscall 
j loop2
endloop2:


li $v0 4
la $a0 str7
syscall 
move $t0 $s2 #קלט נתוני B
la $t2 B
li $v0 4
la $a0 str4
syscall 
loop4:
move $t1 $s3
loop3:
li $v0 5
syscall 
sw $v0 ($t2)
subi $t1 $t1 1
addi $t2 $t2 4
beqz $t1 endloop3
j loop3
endloop3:
subi $t0 $t0 1
beqz $t0 endloop4
li $v0 4
la $a0 str5
syscall 
j loop4
endloop4:

la $v0 C#חישוב המטריצה c:
li $t4 4
la $a0 A
move $t0 $s0
rowsloop:#לולאה שעוברת על כל שורות A
beqz $t0 endrowsloop
la $a1 B
move $t1 $s3
Columnsloop:#לולאה שעוברת על עמודות B
beqz $t1 endColumnsloop
move $a2 $a0
move $a3 $a1
move $t3 $s1
li $v1 0
multloop:#לולאה שכופלת את השורה הנוכחית עם העמודה הנוכחית
beqz $t3 endmultloop
lw $t6 ($a2)
lw $t7 ($a3)
mult $t6 $t7
mflo $t5
add $v1 $v1 $t5
addi $a2 $a2 4
mult $t4 $s3
mflo $t5
add $a3 $a3 $t5
subi $t3 $t3 1
j multloop
endmultloop:
sw $v1 ($v0)
addi $v0 $v0 4
subi $t1 $t1 1
addi $a1 $a1 4
j Columnsloop
endColumnsloop:
mult $t4 $s1
mflo $t5
add $a0 $a0 $t5
subi $t0 $t0 1
j rowsloop
endrowsloop:

li $v0 4#הדפסת המטריצה A 
la $a0 str9
syscall 
move $t0 $s0 
la $t1 A
printArows:
beqz  $t0 endPrintArows
move $t6 $t1
move $t7 $s1
inArow:
beqz  $t7 endinArow
lw $a0 ($t6)
li $v0 1
syscall 
la $a0 str8
li $v0 4
syscall 
addi $t6 $t6 4
subi $t7 $t7 1
j inArow
endinArow:
la $a0 str
li $v0 4
syscall 
mult $t4 $s1
mflo $t5
add $t1 $t1 $t5
subi $t0 $t0 1
j printArows
endPrintArows:

li $v0 4#הדפסת המטריצה B 
la $a0 str10
syscall 
move $t0 $s2 
la $t1 B
printBrows:
beqz  $t0 endPrintBrows
move $t6 $t1
move $t7 $s3
inBrow:
beqz  $t7 endinBrow
lw $a0 ($t6)
li $v0 1
syscall 
la $a0 str8
li $v0 4
syscall 
addi $t6 $t6 4
subi $t7 $t7 1
j inBrow
endinBrow:
la $a0 str
li $v0 4
syscall 
mult $t4 $s3
mflo $t5
add $t1 $t1 $t5
subi $t0 $t0 1
j printBrows
endPrintBrows:

li $v0 4#הדפסת המטריצה c 
la $a0 str11
syscall 
move $t0 $s0 
la $t1 C
printCrows:
beqz  $t0 endPrintCrows
move $t6 $t1
move $t7 $s3
inCrow:
beqz  $t7 endinCrow
lw $a0 ($t6)
li $v0 1
syscall 
la $a0 str8
li $v0 4
syscall 
addi $t6 $t6 4
subi $t7 $t7 1
j inCrow
endinCrow:
la $a0 str
li $v0 4
syscall 
mult $t4 $s3
mflo $t5
add $t1 $t1 $t5
subi $t0 $t0 1
j printCrows
endPrintCrows:




