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

add $t1, $a1, $zero

#fill tower 1
add $t0, $s0, $zero #counter
loop_fill:
sw $t0, 0($t1) #add disc
addi $t1, $t1, 4 #next disc memory value
addi $t0, $t0, -1 #next disc value
bne $t0, $zero, loop_fill

add $t0, $s0, $zero 
add $t1, $a1, $zero
add $t2, $a2, $zero
add $t3, $a3, $zero
jal Hanoi
j end

#algorithm to solve hanoi
#Hanoi(N, A, B, C)
#params: $t0= tower size, $t1 = origin, $t2 = auxiliary, $t3 = destiny
Hanoi:
#STACK
addi $sp, $sp, -8	#push return address
sw $ra, 0($sp)		#push return N value
sw $t0, 4($sp)


beq $t0, 1, move_disc

#Hanoi(N-1, A, C, B)
add $t4, $zero, $t2
add $t2, $zero, $t3
add $t3, $zero, $t4

sub $t0, $t0, 1 #N-1
jal Hanoi

#Hanoi(1, A, B, C)
add $t4, $zero, $t2
add $t2, $zero, $t3
add $t3, $zero, $t4
jal Hanoi

#Hanoi(N-1, B, A, C)
add $t4, $zero, $t2
add $t2, $zero, $t1
add $t1, $zero, $t4

jal Hanoi
j finish
move_disc:

lw $t9, 0($t1) #save value of origin tower in a placeholder
sw $zero, 0($t1) #clean tower value
addi $t1, $t1, -4 #reduce tower pointer
sw $t9, 0($t3) #store value in destiny tower
addi $t3, $t3, 4

finish:
lw $ra, 0($sp)	#pop return address
lw $t0, 4($sp)	#pop return N value
addi $sp, $sp, 8
jr $ra

end:
