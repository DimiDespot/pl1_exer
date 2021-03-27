#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
using namespace std;

void print_random () {
  int num = rand () % 4;
  switch (num) {
    case 0: printf("U"); break;
    case 1: printf("D"); break;
    case 2: printf("L"); break;
    case 3: printf("R"); break;
  }
}

int main () {
  srand (time(NULL));
  int N = 1000, M = 1000;
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      print_random ();
    }
    printf("\n");
  }
}
