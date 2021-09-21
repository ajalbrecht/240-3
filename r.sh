#*****************************************************************************************************************************
# Program name: "Least_to_Greatest".  This program allow the user to input up to 100 integers and sort them, while also      *
# filtering for invalid response with each input .  Copyright (C) 2020 AJ Albrecht                                           *
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
# version 3 as published by the Free Software Foundation.                                                                    *
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
# Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
# A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
#*****************************************************************************************************************************
#=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
#
#Author information
#Author name: AJ Albrecht
#Author email: ajalbrecht@fullerton.edu
#
#Program information
#  Program name: Least_to_Greatest
#  Programming languages: C, C++, x86 Assembly and Bash
#  Date program began:     2020-Oct-6
#  Date program completed: 2020-Oct-13
#  Date comments upgraded: 2020-Oct-31
#  Files in this program: Main.c, Read_Clock.asm, Manager.asm, Input_Array.asm, isinteger.cpp, atol.asm, Display_Array.cpp, BubbleSort.c, Swap.asm
#  Status: Complete. no bugs found after extensive testing
#
#References for this program
#  Albrecht, What_Is_The_Sum, version 1
#  Holiday, atol.asm, version 2.
#  Holiday, Control-D-Example, version 1.
#  Holiday, Integer Arithmetic, version 1.
#  Holiday, isinteger, version 1.
#  Holiday, Where arrays live, version 1.
#  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
#  rathbhupendra, Bubble Sort, C version.
#
#Purpose
#  Order all inputted numbers from least to greatest and filter for invalid responses
#
#This file
#   File name: r.sh
#   Language: bash
#   Max page width: 132 columns
#   Assemble: sh r.sh
#   Link: g++ -m64 -no-pie -o least_to_greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o
#   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
#
#Purpose of this file
#   Compile all files in Least_to_Greatest program and then run it

#!/bin/bash

#Delete some un-needed files
rm *.o
rm *.out

#compile all individual filles togeather
#the order of compelation is based on which file is needed first
gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c17
nasm -f elf64 -l Read_Clock.lis -o Read_Clock.o Read_Clock.asm
nasm -f elf64 -l Manager.lis -o Manager.o Manager.asm
nasm -f elf64 -l Input_array.lis -o Input_Array.o Input_Array.asm
g++ -c -Wall -m64 -std=c++14 -no-pie -o isinteger.o isinteger.cpp
nasm -f elf64 -l atol.lis -o atol.o atol.asm
g++ -c -Wall -m64 -std=c++14 -no-pie -o Display_Array.o Display_Array.cpp
gcc -c -Wall -m64 -no-pie -o BubbleSort.o BubbleSort.c -std=c17
nasm -f elf64 -l Swap.lis -o Swap.o Swap.asm

#assemble files togeather
g++ -m64 -no-pie -o Least_to_Greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o

#Run the program
./Least_to_Greatest.out
