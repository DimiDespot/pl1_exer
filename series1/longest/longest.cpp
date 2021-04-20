#include <iostream>
#include <fstream>
#include <string>
using namespace std;


int main (int arg, char* argv[]) {
  fstream fl;
  fl.open(argv[1], ios::in);

  int N, M;
  fl >> M >> N;

  int temp; //arr[M]cd 

  for (int i = 0; i < M; i++) {
    fl >> temp;
    //arr[i] = temp + N;
  }
}
