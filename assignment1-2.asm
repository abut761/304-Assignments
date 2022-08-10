# Template code for Question 2 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

				.data 
	prompt1:	.asciiz		"Enter a string of characters: "
	prompt2:	.asciiz		"\n ... number of word 'the' in the string is: "
	# reserve a buffer to store up to 200 characters for the input string 
				# (plus one for 0 at the end of the string)
	str_buf: 	.space		201  
  
 
	# other things here if needed ...


			.text 
			.globl	    main
	main: 
		# no need for stack frame 

		# Print the prompt message and enter the string from keyboard 
			# your code ...
		la $t0, prompt1  #load first prompt to temp register
		addi $v0, $0, 4  #prepares system call to print string
		add $a0, $0, $t0  #load first prompt into syscall
		syscall

		addi $v0, $0, 5  #prepares system call to read string
		syscall

		#use temp 0-2 to store the most recent 3 characters. then compare to see if it matches "the"
		addi $t0, $0, 0
		addi $t1, $0, 0
		addi $t2, $0, 0

		addi $t7, $0, 0  #use t7 to store the total "the" count so far

		add $t3, $0, $a0  #store in t3 the start of the input string

		j loop  #start iterating through string 

	loop:  #iterate through string

		lbu $t4, 0($t3)  #load byte of current string index
		beq $t4, $0, Exit  #go to finishing step if string is complete

		#shift the three most recent characters along in memory to analyse
		add $t0, $0, $t1
		add $t1, $0, $t2
		add $t2, $0, $t4

		addi $t5, $0, 0 #prepare t5 to record all successfull comparisons when analysing past 3 characters
		addi $t6, $0, 0 #prepare t6 to store hard coded letters

		#test first letter against the letter "t"
		slti $v0, $t0, 117  #117 = u
		add $t5, $t5, $v0  #increment count of successful comparisons if first letter is less than u
		addi $t6, $0, 115  #115 = s
		slt $v0, $t6, $t0  #returns 1 if s is less than letter
		add $t5, $t5, $v0  #increment count of successful comparisons if s is less than first letter

		#repeat above process for the second letter and "h"
		slti $v0, $t1, 105  #105 = i
		add $t5, $t5, $v0  
		addi $t6, $0, 103  #103 = g  
		slt $v0, $t6, $t1  
		add $t5, $t5, $v0  

		#repeat above process for the second letter and "e"
		slti $v0, $t2, 102  #102 = f
		add $t5, $t5, $v0  
		addi $t6, $0, 100  #100 = d  
		slt $v0, $t6, $t2  
		add $t5, $t5, $v0 

		addi, $t6, $0, 5  #load 5 into t6, as 6 successes in above comparisons are needed to ensure "the"
		slt $v0, $t6, $t5  #check if 5 is less than t5, the number of successfull comparisons
		add $t7, $t7, $v0  #increment total "the" count of all checks passed

		addi $t3, $t3, 1  #go to next character

		j loop


	Exit:
		# Print the result
			# your code ...

		la $t8, prompt2  #load second prompt to temp register
		addi $v0, $0, 4  #prepares system call to print string
		add $a0, $0, $t8  #load second prompt into syscall
		syscall
		
		addi $v0, $0, 1  #prepares system call to print integer
		add $a0, $0, $t7  #load count into syscall
		syscall
		
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?

