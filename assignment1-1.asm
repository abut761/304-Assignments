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

			lw $a0, 4($t0)  #load the 0 index word in the array into the argument for syscall

			addi $v0, $0, 1  #set up syscall to print int
			syscall
			
			
			# print the result on SPIM Console
				# your code ... 
			
			
			
			
			# Exit to SPIM 
			addi	$v0, $0, 10		# system call code for  exit 
			syscall					# exit: end of the program execution?