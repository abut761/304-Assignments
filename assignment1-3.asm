# Template code for Question 3 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str0:	.asciiz	"Enter the value for n: "		
	str1:	.asciiz	"Fibonacci sequence is: "
	str2:	.asciiz	", "
 

			.text 
			.globl	    main
	main: 

		# set up the stack frame if needed 
		

		# print the initial message and read the value of n 
		
				# your code ...
				
		# print the message and result numbers
		
		
				# your code ...
		
		
		
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?
		

  
  fibonacci:
		# input argument ... ???

		# set up the stack frame if needed 
		
	
			# your code ... 
			
  
		# return the result 
		
			# your code ... 
