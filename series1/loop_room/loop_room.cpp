#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

int nextRoom (char dir, int row, int col, int N, int M) {
  if ((row == 0 && dir == 'U') || (row == N-1 && dir == 'D') || (col == 0 && dir == 'L') || (col == M-1 && dir == 'R'))
    return -1;
  switch (dir) {
    case 'U': return (row-1)*M + col;
    case 'D': return (row+1)*M + col;
    case 'L': return row*M + (col-1);
    case 'R': return row*M + (col+1);
    default: return -2;
  }
}

bool dfs (vector<int> &maze, vector<bool> &visited, vector<bool> &canExit, int i) {
  if (visited[i]) return canExit[i];

  visited[i] = true;
  if (maze[i] == -1) canExit[i] = true;
  else canExit[i] = dfs (maze, visited, canExit, maze[i]);

  return canExit[i];
}

int solve (vector<int> &maze, int N, int M) {
  vector<bool> visited (N*M), canExit (N*M);
  for (int i = 0; i < N*M; i++) {
    visited[i] = false;
    canExit[i] = false;
  }

  for (int i = 0; i < N*M; i++) {
    if (!visited[i]) canExit[i] = dfs (maze, visited, canExit, i);
  }

  int count = 0;
  for (int i = 0; i < N*M; i++) if (!canExit[i]) count++;
  return count;
}

int main (int arg, char* argv[]) {
  fstream fl;
  fl.open(argv[1], ios::in);

  int N, M;
  fl >> N >> M;

  vector<int> maze (N*M);
  char temp;    //to read input

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      fl >> temp;
      maze [i*M + j] = nextRoom (temp, i, j, N, M);
    }
  }

  int result = solve (maze, N, M);
  cout << result << endl;

  fl.close();
  return 0;
}
