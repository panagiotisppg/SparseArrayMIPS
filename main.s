#####################################
    # Name:     Konstantina
    # Lastname: Karapetsa
    # AM:       p3220071

    # Name:     Despoina
    # Lastname: Kalama
    # AM:       p3220060

    # Name:     Panagiotis
    # Lastname: Papageorgiou
    # AM:       p3220281
####################################

    .text
    .globl main

main:

#--------------------------------main-----------------------------------

    loop:
        li   $a0, '\n'
        li   $v0, 11
        syscall

        addi $sp, $sp, -4                   # Save space on the stack for $ra
        sw   $ra, 0($sp)                    # Save return address
    
        jal readOption          
    
        lw   $ra, 0($sp)                    # Restore the original value of $ra
        addi $sp, $sp, 4                    # Adjust the stack pointer
                
        blt  $v1, 1, exit                   # if (op < 1): goto exit
        bgt  $v1, 8, exit                   # if (op > 8): goto exit

        # op=1
        beq  $v1, 1, ReadingArrayA
        bne  $v1, 1, not_1

    ReadingArrayA:        
        la   $a0, Reading_Array_A           #System.out.println("Reading Array A");
        li   $v0, 4
        syscall

        # code for ReadPin  pinA
        la   $a0, pinA
        li   $a1, 10

        addi $sp, $sp, -4                   # saves off the $ra
        sw   $ra, 0($sp)                    # save return address

        jal readPin

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4      
        
        j loop

    not_1:
        # op=2
        beq  $v1, 2, ReadingArrayB
        bne  $v1, 2, not_2

    ReadingArrayB:
        la   $a0, Reading_Array_B           # System.out.println("Reading Array B");
        li   $v0, 4
        syscall

        # code for ReadPin pinB
        la   $a0, pinB
        li   $a1, 10

        addi $sp, $sp, -4                   # saves off the $ra
        sw   $ra, 0($sp)                    # save return address

        jal readPin

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4      
    
        j loop

    not_2:
        # op=3
        beq  $v1, 3, CreatingSpareArrayA
        bne  $v1, 2, not_3

    CreatingSpareArrayA:
        la   $a0, Creating_Spare_Array_A    # System.out.println("Creating Sparse Array A" );
        li   $v0, 4
        syscall

        la   $a0, pinA
        la   $a1, SparseA

        addi $sp, $sp, -4                   # saves off the $ra
        sw   $ra, 0($sp)                    # save return address

        jal createSparse

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4

        sw $t1,mikosA 
        
        li   $a0, '\n'
        li   $v0, 11
        syscall

        li $t2,2
        div $t1,$t1,$t2

        j loop

    not_3:
        # op=4
        beq  $v1, 4, CreatingSpareArrayB
        bne  $v1, 4, not_4

    CreatingSpareArrayB:
        la   $a0, Creating_Spare_Array_B    # System.out.println("Creating Sparse Array B" );
        li   $v0, 4
        syscall

        la   $a0, pinB
        la   $a1, SparseB

        addi $sp, $sp, -4                   # saves off the $ra
        sw   $ra, 0($sp)                    # save return address

        jal createSparse

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4

        sw $t1,mikosB

        li   $a0, '\n'
        li   $v0, 11
        syscall

        li $t2,2
        div $t1,$t1,$t2

        j loop

    not_4:
        # op=5
        beq  $v1, 5, CreatingSpareArrayC
        bne  $v1, 5, not_5

    CreatingSpareArrayC:       
        la   $a0, Creating_Spare_Array_C    # System.out.println("Creating Sparse Array C = A + B");
        li   $v0, 4
        syscall

        la   $a0, SparseA                   # $a0=SparseA
        lw   $a1, mikosA                    # $a1=mikosA
        la   $a2, SparseB                   # $a2=SparseB
        lw   $a3, mikosB                    # $a3=mikosB
        la   $s0, SparseC                   # $s0=SparseC

        addi $sp, $sp, -4                   # saves off the $ra
        sw   $ra, 0($sp)                    # save return address

        jal addFuction

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4

        sw   $t2,mikosC 
        
        li   $a0, '\n'
        li   $v0, 11
        syscall

        li $t3,2
        div $t2,$t2,$t3

        j loop

    not_5:
        # op=6
        beq  $v1, 6, DisplayingSparseArrayA
        bne  $v1, 6, not_6

    DisplayingSparseArrayA:        
        la   $a0, Displaying_Sparse_Array_A # System.out.println ("Displaying Sparse Array A");
        li   $v0, 4
        syscall

        la $a0,SparseA
        lw $a1,mikosA

        jal printSparse

        j loop

    not_6:
        # op=7
        beq  $v1, 7, Displaying_SparseArrayB
        bne  $v1, 7, not_7

    Displaying_SparseArrayB:
        la   $a0, Displaying_Sparse_Array_B # System.out.println ("Displaying Sparse Array B");
        li   $v0, 4
        syscall

        la $a0,SparseB
        lw $a1,mikosB

        jal printSparse

        j loop

    not_7:
        # op=8
        beq  $v1, 8, DisplayingSparseArrayC
        bne  $v1, 8, not_8

    DisplayingSparseArrayC:        
        la   $a0, Displaying_Sparse_Array_C # System.out.println ("Displaying Sparse Array C");
        li   $v0, 4
        syscall

        la $a0,SparseC
        lw $a1,mikosC

        jal printSparse

        j loop         

    exit:
        li   $v0, 10                        # exit of the program
        syscall

#--------------------------------readOption()---------------------------------

    readOption:
        la   $a0,  Choice
        li   $v0,  4
        syscall

        li   $v0,  5                        # read op
        syscall

        addi $v1,  $v0,  0
        la $a0, line
        li $v0, 4
        syscall
        
        jr $ra                              # Jump to the original return address

#-----------------------------readPin(int [] pin)------------------------------

    readPin:
        move $s1, $a0                       # preserve address of array
        move $s2, $a1                       # preserve ammount of elements
        li   $t5, 0                         # counter

    input_loop:     
        beq  $t5, 10, exit_input        
        la   $a0, Position      
        li   $v0, 4     

        syscall                             # print("Position [")
        move $a0, $t5               
        li   $v0, 1             
        syscall                             # print(counter)

        la   $a0, colon             
        li   $v0, 4             
        syscall                             # print("] :")

        li   $v0, 5                         # get input integer
        syscall             

        sw   $v0, ($s1)                     # store inputed value to current address of list
        addi $s1, 4                         # move pointer 4 bytes deeper in the array to store the next element 
        addi $t5, 1                         # nums inputed ++

        j input_loop                        # loop

    exit_input:
        jr $ra                              # Jump to the original return address
    
#-------------------createSparse (int [] pin, int [] Sparse)------------------- 

    createSparse:
        move $s1, $a0                       # address of pin s1=a0
        move $s2, $a1                       # address of sparse s2=a1

        li   $t0, 0                         # i = 0
        li   $t1, 0                         # k = 0

    loop_create:
        bge  $t0, 10, end_loop_create       # Check if i >= pin.length   
        lw   $t2, 0($s1)                    # t2 = pin[i]
        bnez $t2, not_zero                  # if (pin[i] != 0): goto not_zero

        j else_create                       # goto else

    not_zero:       
        sw   $t0, 0($s2)                    # Sparse[k] = i
        sw   $t2, 4($s2)                    # Sparse[k+1] = pin[i]
        addi $t1, $t1, 2                    # k += 2
        addi $s2, $s2, 8                    # Move to the next position in Sparse

    else_create:         
        addi $t0, $t0, 1                    # i++
        addi $s1, $s1, 4                    # Move to the next element in pin

        j loop_create                       # Repeat the loop

    end_loop_create:
        j exit_create                       # exit the program

    exit_create:
        jr $ra                              # jump to the original return address  


#-------------------printSparse (int [] Sparse, int mikos)---------------------

    printSparse:
        move $s1, $a0
        move $s2, $a1

        li   $a0, '\n'
        li   $v0, 11
        syscall

        li   $t5, 0                         # counter

    print_loop:
        bge $t5, $s2, exit_print
        
        la $a0, Position_with_colon
        li $v0, 4
        syscall                             # print("Position: ")

        li $v0, 1                           # prints position
        lw $a0, 0($s1)              
        syscall             

        la $a0, Value               
        li $v0, 4               
        syscall                             # print(" Value : ")

        li $v0, 1                           # prints value
        lw $a0, 4($s1)              
        syscall             

        li   $a0, '\n'                      # new line
        li   $v0, 11                
        syscall             

        addi $s1, $s1, 8                
        addi $t5, $t5, 2                

        j print_loop                        # loop

    exit_print:
        jr $ra                              # Jump to the original return address

#--------------------add (int [] SparseA, int mikosA, int [] SparseB, int mikosB, int [] SparseC)--------------------
addFuction:

    move $s1,$a0
    move $s2,$a1
    move $s3,$a2
    move $s4,$a3
    move $s5,$s0
    
    li $t0, 0                               # a=0
    li $t1, 0                               # b=0
    li $t2, 0                               # c=0

loop_add:

    blt $t0, $s2, continue_first            # a < mikosA

    j exit_Firstloop_add        

continue_first:     

    blt $t1, $s4, continue_second           # b < mikosB

    j exit_Firstloop_add

continue_second:

    lw $t3, 0($s1)                          # t3 = SparseA
    lw $t4, 0($s3)                          # t4 = SparseB
    
    blt $t3, $t4, branch_less_than          # (SparseA[a] < SparseB [b])
    bgt $t3, $t4, branch_greater_than       # (SparseA[a] > SparseB [b])
    beq $t3, $t4, branch_equal              # (SparseA[a] = SparseB [b])

    j loop_add

branch_less_than:

    sw   $t3, 0($s5)                        # SparseC [c++] = SparseA[a++];
    lw   $t5, 4($s1)                        # t5 = SparseA[a++]
    sw   $t5, 4($s5)                        # SparseC [c++] = SparseA[a++];

    addi $t2, $t2, 2                        # c += 2
    addi $t0, $t0, 2                        # a += 2

    addi $s1, $s1, 8                        # Move to the next position in SparseA
    addi $s5, $s5, 8                        # Move to the next position in SparseC

    j loop_add                  

branch_greater_than:                    

    sw   $t4, 0($s5)                        # SparseC [c++] = SparseB[b++];
    lw   $t6, 4($s3)                        # t6 = SparseB[b++]
    sw   $t6, 4($s5)                        # SparseC [c++] = SparseB[b++];

    addi $t2, $t2, 2                        # c += 2
    addi $t1, $t1, 2                        # b += 2
    
    addi $s3, $s3, 8                        # Move to the next position in SparseB
    addi $s5, $s5, 8                        # Move to the next position in SparseC

    j loop_add

branch_equal:

    sw   $t3, 0($s5)                        # SparseC [c++] = SparseA[a++];
    lw   $t5, 4($s1)                        # t5 = SparseA[a++]
    lw   $t6, 4($s3)                        # t6 =  SparseB[b++]
    add  $t5, $t5, $t6                      # t5 += t6
    sw   $t5, 4($s5)                        # SparseC [c++] = SparseA[a++] + SparseB[b++];
    
    addi $t2, $t2, 2                        # c += 2
    addi $t1, $t1, 2                        # b += 2
    addi $t0, $t0, 2                        # a += 2
    
    addi $s3, $s3, 8                        # Move to the next position in SparseB
    addi $s1, $s1, 8                        # Move to the next position in SparseA
    addi $s5, $s5, 8                        # Move to the next position in SparseC

    j loop_add

exit_Firstloop_add:

loop_add_1:

    bge $t0, $s2, exit_Secondloop_add 
    lw  $t3, 0($s1)                         # t3 = SparseA
    sw  $t3, 0($s5)                         # SparseC[c++]=SparseA[a++];
    lw  $t5, 4($s1)                         # t5 = SparseA[a++]
    sw  $t5, 4($s5)                         # SparseC[c++]=SparseA[a++];
   
    addi $s1, $s1, 8                        # Move to the next position in SparseA
    addi $s5, $s5, 8                        # Move to the next position in SparseC
   
    addi $t2, $t2, 2                        # c += 2
    addi $t0, $t0, 2                        # a += 2
    j loop_add_1

exit_Secondloop_add:

loop_add_2:

    bge $t1, $s4, exit_loop_add       
    lw  $t4, 0($s3)                         # t4 = SparseB
    sw  $t4, 0($s5)                         # SparseC [c++] = SparseB[b++];
    lw  $t6, 4($s3)                         # t5 = SparseB[b++]
    sw  $t6, 4($s5)                         # SparseC [c++] = SparseB[b++];
    
    addi $s3, $s3, 8                        # Move to the next position in SparseB
    addi $s5, $s5, 8                        # Move to the next position in SparseC
    
    addi $t2, $t2, 2                        # c += 2
    addi $t1, $t1, 2                        # b += 2

    j loop_add_2

exit_loop_add:

    li   $a0, '\n'
    li   $v0, 11
    syscall

    move $a0, $t2                           # Set $a0 to the value of c

    j exit_add                              # Exit the program

exit_add:
    jr $ra                                  # Jump to the original return address

#--------------------------------------------------------------------------
    .data
#--------------------main--------------------------------------------------
    mikosA:                                 .word   0
    mikosB:                                 .word   0
    mikosC:                                 .word   0
    i:                                      .space  4
    op:                                     .space  4
    pinA:                                   .space  40
    pinB:                                   .space  40
    SparseA:                                .space  80
    SparseB:                                .space  80
    SparseC:                                .space  80
    line:                                   .asciiz "-----------------------------\n"
    Reading_Array_A:                        .asciiz "Reading Array A\n\n"
    Reading_Array_B:                        .asciiz "Reading Array B\n\n"
    Creating_Spare_Array_A:                 .asciiz "Creating Sparse Array A\n\n"
    Creating_Spare_Array_B:                 .asciiz "Creating Sparse Array B\n\n"
    Creating_Spare_Array_C:                 .asciiz "Creating Sparse Array C\n\n"
    Displaying_Sparse_Array_A:              .asciiz "Displaying Sparse Array A\n\n"
    Displaying_Sparse_Array_B:              .asciiz "Displaying Sparse Array B\n\n"
    Displaying_Sparse_Array_C:              .asciiz "Displaying Sparse Array C\n\n"
#-----------------readOption------------------------------------------------
    Choice:                                 .asciiz "\n-----------------------------\n1.Read Array A \n2.Read Array B \n3.Create Sparse Array A \n4.Create Sparse Array B \n5.Create Sparse Array C= A + B \n6.Display Sparse Array A \n7.Display Sparse Array B \n8.Display Sparse Array C \n0.Exit\nChoice? "
#----------------readPin/printSparse----------------------------------------
    Position:                               .asciiz "Position ["
    Position_with_colon:                    .asciiz "Position: "
    Value:                                  .asciiz " Value: "
    colon:                                  .asciiz "] :"
#--------------------createSparse-------------------------------------------
    pin:                                    .word 40
    pin_length:                             .word 10
    Sparse:                                 .word 40
