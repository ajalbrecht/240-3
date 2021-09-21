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
;  Date comments upgraded: 2020-Oct-11
;  Files in this program: Main.c, Read_Clock.asm, Manager.asm, Input_Array.asm, isinteger.cpp, atol.asm, Display_Array.cpp, BubbleSort.c, Swap.asm
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
;   File name: Swap.asm
;   Language: X86 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Swap.lis -o Swap.o Swap.asm
;   Link: g++ -m64 -no-pie -o least_to_greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
;
;Purpose of this file
;   Swap a pair of elements to the other location when called by BubbleSort.c


global swap

segment .data
;no print or input statements are in this file

segment .bss
;the array is in the manager file

segment .text
swap:

;register uses
;rdi and rsi = pointers that need to be swapped
;rbx and rcx = temporary registers used to reassign variables

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

;pass pointer address into temporary variables
mov rbx, [rdi]
mov rcx, [rsi]

;swap the elements pointers by reassigning the opposite temporary pointer
mov [rdi], rcx
mov [rsi], rbx

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

;while nothing is needed to be returned, It should be a the end of the program anyways.
ret
