/* Copyright (C) 2023 Alif Semiconductor - All Rights Reserved.
 * Use, distribution and modification of this code is permitted under the
 * terms stated in the Alif Semiconductor Software License Agreement
 *
 * You should have received a copy of the Alif Semiconductor Software
 * License Agreement with this file. If not, please write to:
 * contact@alifsemi.com, or visit: https://alifsemi.com/license
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <fcntl.h>
#define PAGE_SIZE	0x1000
#define ITERATIONS	800
#define HYPERRAM_LOC	0xA0000000
#define DATA            0xA5
int main ()
{
  uint32_t *vptr;
  int count = 0;
  printf("HyperRAM test that writes 0xA5 data of");
  printf(" 4K bytes for %d iterations.\n", ITERATIONS);
  while(count < ITERATIONS)
  {
    vptr = malloc(PAGE_SIZE);
    if(vptr)
    {
      memset(vptr, DATA, PAGE_SIZE);
      printf("Count %d: Wrote at virtual address 0x%x\n",
             count, (uint32_t) vptr);
    }
    else
    {
      printf("Malloc failed!\n");
      return -1;
    }
    count++;
  }
  return 0;
}
