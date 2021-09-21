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
;   File name: Manager.asm
;   Language: X86 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Manager.lis -o Manager.o Manager.asm
;   Link: g++ -m64 -no-pie -o least_to_greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
;
;Purpose of this file
;   Serves as an organized place to call most program related functions


global manager

;Declare the names of programs called in other files
extern printf
extern scanf
extern input_array
extern display_array
extern sort

segment .data
stringoutputformat db "%s", 0
info1 db "This program will sum your array of integers", 10, 0
info2 db "Enter a sequence of long integers separated by white space.", 10, 0
info3 db "After the last input press enter followed by Control+D:", 10, 0
;user inputs array
userinputresult db 10, "These number were received and placed into the array:", 10, 0
rearrange db "The array has been sorted by the bubble sort algorithm", 10, 10, 0
rearrange2 db "This is the order of the values in the array now:", 10, 0
goodbye db "The largest number in the array will now be returned to the main function.", 10, 10, 0

segment .bss
array: resq 100				; 100 - reserving 100 qwords

segment .text
manager:

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

push r15

;register usage list
;r15 - array
;r14 - amount of numbers systems
;r13 - temporary array responses
;r12 - largest number in the array
;rbx and rcx used in other files as temporary values

;place the array into a registers
mov r15, array

;write 1st line of program usage information
mov qword rdi, stringoutputformat
mov qword rsi, info1
mov qword rax, 0
call printf

;write 2nd line of program usage information
mov qword rdi, stringoutputformat
mov qword rsi, info2
mov qword rax, 0
call printf

;write 3rd line of program usage information
mov qword rdi, stringoutputformat
mov qword rsi, info3
mov qword rax, 0
call printf

;call input array function and save the amount of responses into r14
mov qword rdi, r15
mov qword rax, 0
call input_array
mov qword r14, rax

;write confirmation message
mov qword rdi, stringoutputformat
mov qword rsi, userinputresult
mov qword rax, 0
call printf

;call display array to write out all response in array
mov qword rdi, r15  ;pass in array
mov qword rsi, r14  ;pass in amount of elements within array
mov rax, 0
call display_array

;write about upcoming array reorder via bubble sort
mov qword rdi, stringoutputformat
mov qword rsi, rearrange
mov qword rax, 0
call printf

;write second array display confirmation message
mov qword rdi, stringoutputformat
mov qword rsi, rearrange2
mov qword rax, 0
call printf

;call the bubble sort function
mov qword rdi, r15  ;pass in array
mov qword rsi, r14  ;pass in amount of elements within array
mov qword rax, 0
call sort
mov qword r12, rax

;call display array a second time to write out all response in array with update order
mov rdi, r15  ;pass in array
mov rsi, r14  ;pass in amount of elements within array
mov rax, 0
call display_array

;write final informative message to user for this file
mov qword rdi, stringoutputformat
mov qword rsi, goodbye
mov qword rax, 0
call printf

;save the largest number response in rax, so it can be sent to main.c
mov qword rax, r12

;Restore the original values to the general registers before returning to the caller.

pop r15

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

;pass back the whole number
ret
