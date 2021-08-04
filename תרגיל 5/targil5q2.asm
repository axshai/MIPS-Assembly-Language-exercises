.data#איחסון מחרוזות נצרכות
str:.asciiz "enter input\n"
str1:.asciiz "INPUT="
str2:.asciiz " RESULT="
str3:.asciiz "ERROR CODE\n"
str4:.asciiz "\n"
.text
inputloop:#לולאת קלט כל עוד שלא הוכנס 0
li $v0 4
la $a0 str
syscall  
li $v0 5
syscall  
move $t0 $v0
beqz $t0 end
srl $t1 $t0 24
beq $t1 0x31 case31#אם הוכנס קוד מסוים-קפוץ למקרה המתאים
beq $t1 0x30 case30
beq $t1 0x48 case48
beq $t1 0x74 case74
error:#אם הוכנס קוד שגוי הדפס error וקלוט שוב
li $v0 4
la $a0 str3
syscall
j inputloop

case31:#אם הוכנס קוד 31 הפוך ל1 סיביות מסוימות לפי ההוראות
ori $t2 $t0 195
j print

case30:#בקוד 30-הפוך ל0 סיביות מסוימות לפי ההוראות
andi $t2 $t0 4294967100
j print

case48: #עבור 48...
xori $t2 $t0 65280
j print

case74:#עבור 74
move $t2 $t0#בודד את הסיביות שאומרים בכמה להזיז
andi $t3 $t0 0x01ffffff
srl $t3 $t3 20
sllloop:#הזז שמאלה בכמה שצריך
beqz $t3 print
sll $t2 $t2 1
subi $t3 $t3 1
j sllloop


print:#הדפסת הקלט והפלט
li $v0 4
la $a0 str1
syscall  
li $v0 1
move $a0 $t0
syscall
li $v0 4
la $a0 str2
syscall  
li $v0 1
move $a0 $t2
syscall
li $v0 4
la $a0 str4
syscall
j inputloop

end:

