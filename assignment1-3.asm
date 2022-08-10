# Template code for Question 3 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str0:	.asciiz	"Enter the value for n: "		
	str1:	.asciiz	"Fibonacci sequence is: "
	str2:	.asciiz	", "
 

			.text 
			.globl	    main
	main: 

		
		

		# print the initial message and read the value of n 

				# your code ...

		la $t0, str0  #load first string to temp register
		addi $v0, $0, 4  #prepares system call to print string
		add $a0, $0, $t0  #load first string into syscall
		syscall

		addi $v0, $0, 5  #read integer from keyboard
		syscall

		add $t6, $0, $v0  #store count in a better register
		addi $t7, $0, 0  #count from 1 to input number

		la $t1, str1  #load first string to temp register
		addi $v0, $0, 4  #prepares system call to print string
		add $a0, $0, $t1  #load first string into syscall
		syscall


		#go to loop
		jal loop


				
		
  exit:		
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?
		
  loop:

		addi $t7, $t7, 1  #increment count

		addi $sp, $sp, -16  #moves stack pointer down 16 places
		#we will store the argument in 0($sp)
		sw $t7, 0($sp)
		#call fibonacci and get result
		jal fibonacci
		lw $t0, 4($sp)  
		addu $sp, $sp, 16  #restore stack frame

		#print result of current count's fibonacci value
		add $a0, $0, $t0
		addi $v0, $0, 1
		syscall

		la $t1, str2  #load first string to temp register
		addi $v0, $0, 4  #prepares system call to print string
		add $a0, $0, $t1  #load first string into syscall
		syscall



		bne $t6, $t7, loop #as long as all iterations aren't complete, do another one
		lw $ra, 12($sp) #load ra from stack frame

		j exit  #ok i tried to do the stack frame method to go from main to here and return to main
				#but for some reason the store $ra didn't return the correct address, even when
				#saved relative to $sp. So i'm gonna have to just jump to the exit.

  
  fibonacci:
		# input argument ... ???
		lw $t0, 0($sp)  #get argument from stack frame
		sw $ra, 12($sp) #save ra on stack frame



		# set up the stack frame if needed 
	
			# your code ... 
			beq $t0, $0, return_zero  #if input n is 0, return 0

			addi $t2, $0, 0  #initialise a count of assertions to see if n is 1 or 2

			slt $t3, $0, $t0 #put in $t3 whether n is greater than 0, then increment assertion count
			add $t2, $t2, $t3
			addi $t4, $0, 3  #load 3 into temporary register to check that n is <3
			slt $t3, $t0, $t4 #put in $t3 n is less than 3, then increment assertion count
			add $t2, $t2, $t3

			addi $t3, $0, 2  #two assertions are needed for case that n is 1 or 2
			beq $t3, $t2, return_one  #if there were two sucessfull assertions, return 1 on the stackframe because n is 1 or 2

			#if input wasn't <3, continue fibonacci sequence
			addi $t1, $0, 1  #put 1 in $t1 for convenience

			addi $sp, $sp, -16  #moves stack pointer down 16 places
			sub $t3, $t0, $t1  #subtracts 1 from n
			sw $t3, 0($sp)  #saves argument in 0($sp)
			jal fibonacci  #call fibonacci
			lw $t4, 4($sp) #load result of function call into $t4
			addu $sp, $sp, 16  #restore stack frame
			sw $t4, 8($sp) #save result of fib(n-1) on stackframe

			lw $t0, 0($sp)  #get argument from stack frame
			addi $t1, $0, 2  #put 2 in $t1 for convenience
			addi $sp, $sp, -16  #moves stack pointer down 16 places
			sub $t3, $t0, $t1  #subtracts 2 from n
			sw $t3, 0($sp)  #saves argument in 0($sp)
			jal fibonacci  #call fibonacci
			lw $t5, 4($sp) #load result of function call into $t5
			addu $sp, $sp, 16  #restore stack frame

			lw $t4, 8($sp) #gets the fib(n-1) from stackframe
			add $t1, $t4, $t5  #adds the results of fib(n-1) and fib(n-2)
			sw $t1, 4($sp)  #saves result in stack frame at 4($sp)
			lw $ra, 12($sp)  #load ra from stack frame
			jr $ra #return to $ra
  
		# return the result 
		
			# your code ... 

return_zero:
		addi $t3, $0, 0 #put 0 in $t3
		sw $t3, 4($sp) #save the result in the stack frame at 4($sp)
		lw $ra, 12($sp)  #load ra from stack frame
		jr $ra #return to $ra

return_one:
		addi $t3, $0, 1 #put 1 in $t3
		sw $t3, 4($sp) #save the result in the stack frame at 4($sp)
		lw $ra, 12($sp)  #load ra from stack frame
		jr $ra #return to $ra
