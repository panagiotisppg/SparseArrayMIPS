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
        jal readOption
        
        #while((op>=1) && (op<=8))
        #(op>=1)
        bge  $v1, 1, firstCondition
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
        addi $sp, $sp, -4         #saves off the $ra
        sw   $ra, 0($sp)           #save return address

        jal readPin

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4      

        jr $ra

        j loop

    not_1:

        #op=2
        beq  $v1, 2, ReadingArrayB
        bne  $v1, 1, not_2
    ReadingArrayB:
        #System.out.println("Reading Array B");
        la   $a0, Reading_Array_B 
        li   $v0, 4
        syscall

        # code for ReadPin pinB

        la   $a0, pinB
        li   $a1, 10
        addi $sp, $sp, -4         #saves off the $ra
        sw   $ra, 0($sp)           #save return address

        jal readPin

        lw   $ra, 0($sp)       
        addi $sp, $sp, 4      

        jr $ra

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
        
        jr   $ra

    #-----------------------------readPin(int [] pin)------------------------------
    readPin:
        
        lw   $t0, 0        #int i=0;

        move $s1, $a0         #preserve address of array
        move $s2, $a1         #preserve address of elements 
        
    continues_in_the_loop:

        #System.out.print ("Position " + i +" :");
        la   $a0, Position
        li   $v0, 4
        syscall

        move $v0, $t0
        li   $v0, 1
        syscall

        la   $a0, colon
        li   $v0, 4
        syscall
        
        li   $v0, 5        #in.nextInt();
        syscall
        
        sw   $v0, 0($s1)        #store the element
        addi $s1, $s1, 4       
        addi $s2, $s2, -1       
        add  $t0, $t0, 1
        bnez $s2, continues_in_the_loop

        jr $ra

.data
#--------------------main--------------------------------------------------
    mikosA:                           .word   0
    mikosB:                           .word   0
    mikosC:                           .word   0
    i:                                .space  4
    op:                               .space  4
    pinA:                             .space  10
    pinB:                             .space  10
    SparseA:                          .space  20
    SparseB:                          .space  20
    SparseC:                          .space  20
    values:                           .asciiz " values "
    Reading_Array_A:                  .asciiz "Reading Array A\n"
    Reading_Array_B:                  .asciiz "Reading Array B \n"
    Creating_Spare_Array_A:           .asciiz "Creating Sparse Array A \n"
    Creating_Spare_Array_B:           .asciiz "Creating Sparse Array B \n"
    Creating_Spare_Array_C:           .asciiz "Creating Sparse Array C \n"
    Displaying_Sparse_Array_A:        .asciiz "Displaying Sparse Array A \n"
    Displaying_Sparse_Array_B:        .asciiz "Displaying Sparse Array B \n"
    Displaying_Sparse_Array_C:        .asciiz "Displaying Sparse Array C \n"
    #-----------------readOption-----------------------------------------------
    Choice:                           .asciiz "\n-----------------------------\n1.Read Array A \n2.Read Array B \n3.Create Sparse Array A \n4.Create Sparse Array B \n5.Create Sparse Array C= A + B \n6.Display Sparse Array A \n7.Display Sparse Array B \n8.Display Sparse Array C \n0.Exit\nChoice? "
    #----------------readPin/printSparse----------------------------------------
    Position:                         .asciiz "Position   "
    Position_with_colon:              .asciiz "Position:   "
    Values:                           .asciiz "Values: "
    colon:                            .asciiz " :\n"
