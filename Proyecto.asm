.data


.text
#numero de torres
addi $s0, $s0, 3

#direcciones de torres 1 a 3
addi $a1, $zero, 0x1001
sll $a1, $a1, 16

addi $a2, $zero, 0x1001
sll $a2, $a2, 16
addi $a2, $a2, 0x0020

addi $a3, $zero, 0x1001
sll $a3, $a3, 16
addi $a3, $a3, 0x0040

#fill tower 1
add $t0, $s0, $zero #counter
loop_fill:
sw $t0, 0($a1) #add disc
addi $a1, $a1, 4 #next disc memory value
addi $t0, $t0, -1 #next disc value
bne $t0, $zero, loop_fill

addi $a1, $a1, -4 #make sure the tower pointer points to the last disc

add $t0, $s0, $zero
add $t1, $a1, $zero
add $t2, $a2, $zero
add $t3, $a3, $zero
jal Hanoy
j end

#algorithm to solve hanoy
#params: $t0= tower size, towers= $t1 $t2 $t3
Hanoy:
addi $sp, $sp, -4
sw $ra, 0($sp)
bne $t0, 1, last_disc


move_disc:



lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

end: