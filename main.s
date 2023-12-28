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
# ap
# hi
#haha pan pan
#--------------------------------main-----------------------------------
    loop:
        li   $a0, '\n'
        li   $v0, 11
        syscall

        jal readOption
        
        #while((op>=1) && (op<=8))
        #(op>=1)
        bge  $v1, 1, firstCondition
        beqz $v1, loop             # If user just enters (nothing) it should just ask for input again
        blt  $v1, 1, exit

    firstCondition:
        #(op<=8)
        ble  $v1, 8, SecondCondition
        bgt  $v1, 8, exit

    SecondCondition:

        #op=1
        beq  $v1, 1, ReadingArrayA
        bne  $v1, 1, not_1
    ReadingArrayA:
        #System.out.println("Reading Array A");
        la   $a0, Reading_Array_A 
        li   $v0, 4
        syscall

        # code for ReadPin  pinA

        la   $a0, pinA
        li   $a1, 10
        addi $sp, $sp, -4          #saves off the $ra
        sw   $ra, 0($sp)           #save return address

        jal readPin

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4      

        # jr $ra # removed cuz was making infinite loop cuz it had option selected and jumped to line 26(basically 29)

        j loop

    not_1:

        #op=2
        beq  $v1, 2, ReadingArrayB
        bne  $v1, 2, not_2
    ReadingArrayB:
        #System.out.println("Reading Array B");
        la   $a0, Reading_Array_B 
        li   $v0, 4
        syscall

        # code for ReadPin pinB

        la   $a0, pinB
        li   $a1, 10
        addi $sp, $sp, -4          #saves off the $ra
        sw   $ra, 0($sp)           #save return address

        jal readPin

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4      

        # jr $ra

        j loop

    not_2:

        #op=3
        beq  $v1, 3, CreatingSpareArrayA
        bne  $v1, 2, not_3
    CreatingSpareArrayA:
        #System.out.println("Creating Sparse Array A" );
        la   $a0, Creating_Spare_Array_A 
        li   $v0, 4
        syscall
        j loop

    not_3:

        #op=4
        beq  $v1, 4, CreatingSpareArrayB
        bne  $v1, 4, not_4
    CreatingSpareArrayB:
        #System.out.println("Creating Sparse Array B" );
        la   $a0, Creating_Spare_Array_B 
        li   $v0, 4
        syscall
        j loop

    not_4:

        #op=5
        beq  $v1, 5, CreatingSpareArrayC
        bne  $v1, 5, not_5
    CreatingSpareArrayC:
        #System.out.println("Creating Sparse Array C = A + B");
        la   $a0, Creating_Spare_Array_C 
        li   $v0, 4
        syscall

        j loop

    not_5:

        #op=6
        beq  $v1, 6, DisplayingSparseArrayA
        bne  $v1, 6, not_6
    DisplayingSparseArrayA:
        #System.out.println ("Displaying Sparse Array A");
        la   $a0, Displaying_Sparse_Array_A 
        li   $v0, 4
        syscall

        j loop

    not_6:

        #op=7
        beq  $v1, 7, Displaying_SparseArrayB
        bne  $v1, 7, not_7
    Displaying_SparseArrayB:
        #System.out.println ("Displaying Sparse Array B");
        la   $a0, Displaying_Sparse_Array_B 
        li   $v0, 4
        syscall

        j loop

    not_7:

        #op=8
        beq  $v1, 8, DisplayingSparseArrayC
        bne  $v1, 8, not_8
    DisplayingSparseArrayC:
        #System.out.println ("Displaying Sparse Array C");
        la   $a0, Displaying_Sparse_Array_C 
        li   $v0, 4
        syscall

        j loop

    not_8:

        j loop

        # exit
    exit:

        li   $v0, 10
        syscall

    #-----------------------------------readOption()--------------------------------------
    readOption:

        la   $a0,  Choice
        li   $v0,  4
        syscall

        #read op
        li   $v0,  5       
        syscall

        addi $v1,  $v0,  0

        la $a0, line
        li $v0, 4
        syscall
        
        jr   $ra

    #-----------------------------readPin(int [] pin)------------------------------
    readPin:

        move $s1, $a0         #preserve address of array
        move $s2, $a1         #preserve address of elements

        li   $t5, 0           # counter

    input_loop:
        beq  $t5, 10, exit_input

        la   $a0, Position
        li   $v0, 4
        syscall              # print("Position [")
        move $a0, $t5
        li   $v0, 1
        syscall              # print(counter)
        la   $a0, colon
        li   $v0, 4
        syscall              # print("] :")
        li   $v0, 5          # get input integer
        syscall

        sw   $v0, ($s1)      # store inputed value to current address of list
        addi $s1, 4          # move pointer 4 bytes deeper in the array to store the next element 
        addi $t5, 1          # nums inputed ++
        j input_loop         # loop

        exit_input:

        jr $ra

.data
    #--------------------main--------------------------------------------------
    mikosA:                           .word   0
    mikosB:                           .word   0
    mikosC:                           .word   0
    i:                                .space  4
    op:                               .space  4
    pinA:                             .space  40 # 40 instead of 10 cuz we ant 10 integers so 10*4 bytes
    pinB:                             .space  40 # 40 instead of 10 cuz we ant 10 integers so 10*4 bytes
    SparseA:                          .space  20
    SparseB:                          .space  20
    SparseC:                          .space  20
    line:                             .asciiz "-----------------------------\n"
    values:                           .asciiz " values "
    Reading_Array_A:                  .asciiz "Reading Array A\n\n"
    Reading_Array_B:                  .asciiz "Reading Array B\n\n"
    Creating_Spare_Array_A:           .asciiz "Creating Sparse Array A\n\n"
    Creating_Spare_Array_B:           .asciiz "Creating Sparse Array B\n\n"
    Creating_Spare_Array_C:           .asciiz "Creating Sparse Array C\n\n"
    Displaying_Sparse_Array_A:        .asciiz "Displaying Sparse Array A\n\n"
    Displaying_Sparse_Array_B:        .asciiz "Displaying Sparse Array B\n\n"
    Displaying_Sparse_Array_C:        .asciiz "Displaying Sparse Array C\n\n"
    #-----------------readOption-----------------------------------------------
    Choice:                           .asciiz "\n-----------------------------\n1.Read Array A \n2.Read Array B \n3.Create Sparse Array A \n4.Create Sparse Array B \n5.Create Sparse Array C= A + B \n6.Display Sparse Array A \n7.Display Sparse Array B \n8.Display Sparse Array C \n0.Exit\nChoice? "
    #----------------readPin/printSparse----------------------------------------
    Position:                         .asciiz "Position ["
    Position_with_colon:              .asciiz "Position:   "
    Values:                           .asciiz "Values: "
    colon:                            .asciiz "] :"