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
//Purpose
//  Order all inputted numbers from least to greatest and filter for invalid responses
//
//This file
//   File name: BubbleSort.c
//   Language: C
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o BubbleSort.o BubbleSort.c -std=c17
//   Link: g++ -m64 -no-pie -o least_to_greatest.out -std=c17 Main.o Read_Clock.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o BubbleSort.o Swap.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//Purpose of this file
//   Order the elements from least to greatest allong with the help of swap.asm


//let the main file know how to call sort function
extern long int sort(long int [], int);
extern void swap(long int * ,long int *);

// the folloing code was taken online and then adapted from code made puclicly avalible by rathbhupendra
long int sort(long int numbers[], int size) {
  // buble sort checks all elements once and switches its place by one only if the one next to it is out of order
  // as a result, the loop needs to run almost as many times as the loop has elements, in case that last input is the complete wrong order
  for (int i = 0; i < size-1; i++) {
    // i is factored into the equation to limit unnecary run time.
    // when the code is run, It is guarented after each itteration of the loop bellow that the largest elment will be in the back at least
    for (int j = 0; j < size-i-1; j++) {
      if (numbers[j] > numbers[j+1]) {
        // call the swap function to swap the order two integers
        swap(&numbers[j], &numbers[j+1]);
      }
    }
  }
  //return the largest number in the array
  return numbers[size-1];
}
