import numpy as np
import sys

sys.setrecursionlimit(15000)

def nextRoom(dir, row, col, N, M):
    if ((row == 0 and dir == 'U') or (row == N-1 and dir == 'D') or (col == 0 and dir == 'L') or (col == M-1 and dir == 'R')):
        return -1
    if dir == 'U': return (row-1)*M + col
    if dir == 'D': return (row+1)*M + col
    if dir == 'L': return row*M + (col-1)
    if dir == 'R': return row*M + (col+1)

def dfs (i):
    global visited
    global canExit
    if visited[i]:
        #print ("i: ", i)
        #print ("visited: ", visited)
        #print ("canExit: ", canExit)
        return canExit[i]
    visited[i] = True
    if maze[i] == -1:
        canExit[i] = True
    else:
        canExit[i] = dfs (maze[i])
    return canExit[i]


def solve(N, M):
    global visited
    global canExit
    for i in range (N*M):
        if not visited[i]:
            #print ("i: ", i)
            #print ("visited: ", visited)
            #print ("canExit: ", canExit)
            canExit[i] = dfs (i)
    count = 0
    for i in range (N*M):
        if not canExit[i]:
            count += 1
    return count


filename = sys.argv[1]
with open(filename) as f:
    N = f.read(1)
    temp = f.read(1)
    while temp != ' ':
        N += temp
        temp = f.read(1)
    M = f.read(1)
    temp = f.read(1)
    while temp != '\n':
        M += temp
        temp = f.read(1)
    N = int(N)
    M = int(M)
    maze = [0]*(N*M)
    visited = [False]*(N*M)
    canExit = [False]*(N*M)
    for i in range (N):
        for j in range (M):
            temp = f.read(1)
            maze[i*M+j] = nextRoom(temp, i, j, N, M)
        junk = f.read(1)

print (solve(N, M))
