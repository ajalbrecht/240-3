;*****************************************************************************************************************************
; Program name: "Least_to_Greatest".  This program allow the user to input up to 100 integers and sort them, while also      *
; filtering for invalid response with each input .  Copyright (C) 2020 AJ Albrecht                                           *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;*****************************************************************************************************************************
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;Author name: AJ Albrecht
;Author email: ajalbrecht@fullerton.edu
;
;Program information
;  Program name: Least_to_Greatest
;  Programming languages: C, C++, x86 Assembly and Bash
;  Date program began:     2020-Oct-6
;  Date program completed: 2020-Oct-13
;  Date comments upgraded: 2020-Oct-31
;  Files in this program: Main.c, Manager.asm, Read_Clock.asm, Input_Array.asm, isinteger.cpp, atol.asm, Display_Array.cpp, BubbleSort.c, Swap.asm
;  Status: Complete. no bugs found after extensive testing
;
;References for this program
;  Albrecht, What_Is_The_Sum, version 1
;  Holiday, atol.asm, version 2.
;  Holiday, Control-D-Example, version 1.
;  Holiday, Integer Arithmetic, version 1.
;  Holiday, isinteger, version 1.
;  Holiday, Where arrays live, version 1.
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;  rathbhupendra, Bubble Sort, C version.
;
;Purpose
;  Order all inputted numbers from least to greatest and filter for invalid responses
;
;This file
;   File name: Input_Array.asm
;   Language: X86 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Input_array.lis -o Input_Array.o Input_Array.asm
;   Link: g++ -m64 -no-pie -o least_to_greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
;
;Purpose of this file
;   Generate an array for other files to use based upon valid user inputs


;Declare the names of programs called in this file.
extern printf
extern scanf
extern isinteger
extern atolong

global input_array

segment .data
stringoutputformat db "%s", 0 ;writes
stringinputformat db "%s",0 ; inputs
numberFormat db "%ld", 10, 0 ; %ld means any digit
invalid db "The last input was invalid and not entered into the array.", 10, 0

segment .bss
;the array is located in the manager file and is currently in r15

segment .text
input_array:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword -1                                               ;Now the number of pushes is even

;initialize all values for the loop ahead
mov r14, 0   ;initialize loop counter
mov r12, 0
;rsp = r13   ;pointer to value thought the loop

mov r15, rdi

;the symbols used by each jmp can be used as a guide to where it loops back to.
;-----------------------------------------------------------------------------------------
;The following block is one logical loop that check the user response to determine when to
;exit the loop, take a response or reject a response due to an invalid character.
;take in the user response
run_again:                                    ;re run loop entry point
mov qword rdi, stringinputformat
push qword 0
mov qword rsi, rsp
mov qword rax, 0
call scanf
;evaluate the response =========================================
;did the user ask to stop the loop by pressing ctrld? ==========
cdqe
cmp rax, -1
je end_loop ; if ctrld is detected, get out of the loop ====end======

;verify that the incoming response is an integer. ==============
mov rax,0
mov rdi,rsp       ; pointer to stack, which contains r13s
call isinteger    ; call is integer function to verify if the number is an integer
mov r12,rax
;evaluate the response =========================================
;was the response entered an integer? ==========================
cmp r12, 1
je valid          ; if so, move over to the input block ////////

;if the response was not valid, ask the user to try again ======
;error message
mov qword rdi, stringoutputformat
mov qword rsi, invalid
mov qword rax, 0
call printf
pop rax         ; dummy pop to balance stack, because rsp was used as value pointer, not a new register
jmp run_again   ; return to top of loop for next response --------------

;/////////////////////////////////////////////////////////////////////
;if the response is valid, convert the string to an integer
valid:
mov rax, 0
mov rdi,rsp     ;pointer to the stack
call atolong
mov r13, rax    ;the converted string to integer has been replaced with an int

;input the response into the array
pop qword r12  ;dummy pop to balance stack, because rsp was used as value pointer, not a new register
mov [r15 + (8 * r14)], r13
inc r14
jmp run_again ; loop again and ask for the next integer --------------
;//////////////////////////////////////////////////////////////////////
;---------------------------------------------------------------------------------------

;=============================end==================================
;the loop is done, and the user has pressed control d
end_loop:
pop rbx

mov rax, r14     ;pass back the amount of times run to the main function

;Restore the original values to the general registers before returning to the caller.
pop r15                                                     ;Remove the extra -1 from the stack
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

;pass back the amount of numbers in the array
ret
