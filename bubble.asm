.data
vetor: .space 40
msg1: .asciiz "Digite os 10 numeros:\n"
msg2: .asciiz "Terminada a leitura.\n"
msg3: .asciiz "Os numeros ordenados sao:\n"
msg4: .asciiz " "
.text
main:
	la $s0, msg1
	jal print
	la $s1, vetor
	li $s2, 10
	li $s3, 0 #iterator
	jal Read
	la $s0, msg2
	jal print
	li $s3, 0 #iterator
	li $s4, 1 #troca
	li $s5, 9 #lim
	jal Ordenar
	la $s0, msg3
	jal print
	li $s3, 0
	jal pVetor
	j Exit
salto:	jr $ra
Exit:
	li $v0, 10
	syscall
print: 	
	li $v0, 4
	move $a0, $s0
	syscall
	jr $ra
Read: 
	beq $s2, $s3, salto 
	sll $t0, $s3, 2
	add $t0, $t0, $s1
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	addi $s3, $s3, 1
	j Read
Ordenar:
	beq $s4, $zero, salto
	li $s4, 0
	li $s3, 0
for:	
	beq $s5, $s3, subLim
	sll $t0, $s3, 2
	add $t0, $t0, $s1
	addi $t1, $t0, 4
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	slt $t4, $t3, $t2
	addi $s3, $s3, 1
	beq $t4, $zero, for
	sw $t2, 0($t1)
	sw $t3, 0($t0)
	li $s4, 1
	j for
subLim:	addi $s5, $s5, -1
	j Ordenar
pVetor:
	beq $s2, $s3, salto
	sll $t0, $s3, 2
	add $t0, $t0, $s1
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	la $s0, msg4
	li $v0, 4
	move $a0, $s0
	syscall
	addi $s3, $s3, 1
	j pVetor