# Template code for Question 1 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str1:	.asciiz	" Number of negative numbers = "
			.align	4
	array1:	.word	100, 119, -30, 10, 0, -123, -2, 2233 
			.word	800, 0, -245, 18170, 0, 55, -1, -450
			.word	9800, 20000, -101, -66, -26, 0, 24590, 123
			.word	12345, 20, 304, 9, 450, -110, -321, 1020
			.word	-1102, 11111, -203, 0, 250, 2, -23, 8888
	
	
	
			.text
			.globl	 	main
			
	main:	
			# your code from here ...
			
			la $t0, array1  #load memory address of array 1 to temp register
			addi $t1, $0, 0  #initialise starting index of array to 0
			addi $t4, $0, 0  #initialise count to 0
			addi $t5, $0, 39  #hard code in number of iterations

			jal loop  #start loop procedure
			
			
			
			# print the result on SPIM Console
				# your code ... 
			
			addi $v0, $0, 1  #prepares system call to print integer
			add $a0, $0, $t4  #load count into syscall
			syscall
			
			
			
			# Exit to SPIM 
			addi	$v0, $0, 10		# system call code for  exit 
			syscall					# exit: end of the program execution?

	loop:
		sll $t2, $t1, 2  #multiply index by 4 and store in t2, for proper accessing of array
		add $t2, $t0, $t2  #add the multiplied index to the base index of the array to get the exact memory location we want to access for this iteration
		lw $t3, 0($t2)  #load the value of the index into a temp register

		slt $t6, $t3, $0  #store in t6 whether the current array value is less than 0
		add $t4, $t4, $t6

		beq $t1, $t5, exit  #leave the loop if the index has reached our desired number of iterations

		addi $t1, $t1, 1  #increments index
		j loop  #repeat loop

	exit:  #exit loop
		jr $31
