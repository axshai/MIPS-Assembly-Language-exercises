.data 
beginaddres:12 13 14 0
.text
la $a0 beginaddres
la $a1 0x10010100
addi $v0 $zero 0
loop:
lw $t1 0($a0)
sw $t1 0($a1)
beq $t1 $zero end
addi $v0 $v0 1
addi $a0 $a0 4
addi $a1 $a1 4
j loop
end:
