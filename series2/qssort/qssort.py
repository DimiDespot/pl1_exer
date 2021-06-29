'''
Η βασική ιδέα για την παραγωγή έγκυρων συμβολοσειρών από Q και S
(που χρησιμοποιείται στην συνάρτηση solve_aux) πάρθηκε από τα παρακάτω σάιτ:
https://stackoverflow.com/questions/33789989/generate-parenthesis-with-backtracking
https://code.activestate.com/recipes/578458-generating-balanced-parenthesis/
https://www.geeksforgeeks.org/print-all-combinations-of-balanced-parentheses/
'''

from collections import deque
import copy
import sys

def readString(f):
    num = f.read(1)
    temp = f.read(1)
    while (temp != ' ') and (temp != '\n'):
        num += temp
        temp = f.read(1)
    return num

def q_move(myQ, myS, i, qs, ss, seen, sorted, ans, n):
    ans.append('Q')
    myS.append(myQ.popleft())
    solve_aux(myQ, myS, i, qs, ss, seen, sorted, ans, n)
    ans.pop()
    myQ.appendleft(myS.pop())

def s_move(myQ, myS, i, qs, ss, seen, sorted, ans, n):
    ans.append('S')
    myQ.append(myS.pop())
    solve_aux(myQ, myS, i, qs, ss, seen, sorted, ans, n)
    ans.pop()
    myS.append(myQ.pop())

def solve_aux(myQ, myS, i, qs, ss, seen, sorted, ans, n):
    if qs == ss == i:
        if myQ == sorted:
            print("".join(ans))
            quit()
        return
    state = (i-qs, n+ss-qs, str(myQ), str(myS))
    if state in seen:
        return
    seen.add(state)
    if qs < i and len(myQ) > 0:
        q_move(myQ, myS, i, qs+1, ss, seen, sorted, ans, n)
    if qs > ss and len(myS) > 0:
        s_move(myQ, myS, i, qs, ss+1, seen, sorted, ans, n)

def solve(myQ, myS):
    temp = list(myQ)
    temp.sort()
    sorted = deque(temp)
    if myQ == sorted:
        return "empty"
    i = 1
    seen = set()
    ans = deque()
    n = len(myQ)
    while True:
        solve_aux(myQ, myS, i, 0, 0, seen, sorted, ans, n)
        i += 1

def main():
    filename = sys.argv[1]
    with open(filename) as f:
        N = int(readString(f))
        myQueue = deque()
        myStack = deque()
        for i in range (N):
            myQueue.append(int(readString(f)))
    print(solve(myQueue, myStack))

if __name__ == '__main__':
    main()
