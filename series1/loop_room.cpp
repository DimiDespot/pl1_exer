#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main (int arg, char* argv[]) {
  fstream fl;
  fl.open(argv[1], ios::in);

  int N, M;
  fl >> N >> M;

  char *maze = new char[N*M];
  char temp;    //to read '\n' at the end of each line

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      fl >> maze[i*M + j];
    }
    fl >> temp;
  }

  fl.close();
  return 0;
}
