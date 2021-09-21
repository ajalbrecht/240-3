//*****************************************************************************************************************************
// Program name: "Least_to_Greatest".  This program allow the user to input up to 100 integers and sort them, while also      *
// filtering for invalid response with each input .  Copyright (C) 2020 AJ Albrecht                                           *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
// version 3 as published by the Free Software Foundation.                                                                    *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//*****************************************************************************************************************************
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//Author name: AJ Albrecht
//Author email: ajalbrecht@fullerton.edu
//
//Program information
//  Program name: Least_to_Greatest
//  Programming languages: C, C++, x86 Assembly and Bash
//  Date program began:     2020-Oct-6
//  Date program completed: 2020-Oct-13
//  Date comments upgraded: 2020-Oct-31
//  Files in this program: Main.c, Manager.asm, Read_Clock.asm, Input_Array.asm, isinteger.cpp, atol.asm, Display_Array.cpp, BubbleSort.c, Swap.asm
//  Status: Complete. no bugs found after extensive testing
//
//References for this program
//  Albrecht, What_Is_The_Sum, version 1
//  Holiday, atol.asm, version 2.
//  Holiday, Control-D-Example, version 1.
//  Holiday, Integer Arithmetic, version 1.
//  Holiday, isinteger, version 1.
//  Holiday, Where arrays live, version 1.
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//  rathbhupendra, Bubble Sort, C version.
//
//Purpose of program
//  Order all inputted numbers from least to greatest and filter for invalid responses
//
//This file
//   File name: main.c
//   Language: C
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c17
//   Link: g++ -m64 -no-pie -o least_to_greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//Purpose of this file
//  Welcome the user, call manager and Read_Clock, and report their results.


#include <stdio.h>
#include <stdint.h>

extern long int manager();
extern long int get_time();

int main() {
  // stores result from other files before displaying it
  long int result;

  // display the start time
  result = get_time();
  printf("%s%ld%s\n", "The time on the CPU clock is now ", result, " tics");

  // inroduce the user to the program
  printf("%s\n", "Welcome to Arrays of Integers");
  printf("%s\n\n", "Bought to you by AJ Albrecht");
  // call manager to do organize the result
  result = manager();
  // end the program
  printf("%s%ld%s\n", "The main received ", result, ", and plans to keep it");
  printf("%s\n", "Main will return 0 to the operating system.   Bye.");

  // display the end time
  result = get_time();
  printf("%s%ld%s\n", "The time on the CPU clock is now ", result, " tics");

  return 0;
}
