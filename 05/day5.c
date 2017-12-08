#include <stdio.h>
#include <stdlib.h>
#include "input.h"

void modify_offset(int *input, int i, int part) {
  if (part == 1) {
    input[i]++; 
  } else if (part == 2) {
    input[i] += (input[i] >= 3) ? -1 : 1;
  } else {
    // leave it unchanged
  }
}

void usage() {
  char msg[] =
    "part1.\n"
    "  usage: day5 <part to solve>\n"
    "    day5 1 : solve part 1\n"
    "    day5 2 : solve part 2\n";

  fputs(msg, stderr);
  exit(1);
}


int main(int argc, char **argv) {
  if (argc < 2) {
    usage();
  }

  int part = atoi(argv[1]);
  if (!(part == 1 || part == 2)) {
    usage();
  }


  int n = 0;
  for (int i = 0, offset = 0; 0 <= i && i < size; n++) {
    offset = input[i];
    modify_offset(input, i, part);
    i += offset;
  }
  
  printf("Part %d, took %d iterations to go out of bounds\n", part, n);
}
