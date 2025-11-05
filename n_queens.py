def print_board(b):
    for r in b:
        print(" ".join("Q" if x else "." for x in r))
    print()

def safe(b, r, c, n):
    for i in range(c):
        if b[r][i] or any(b[r-i][c-i] if r-i>=0 else 0 for i in range(1, min(r,c)+1)) \
           or any(b[r+i][c-i] if r+i<n else 0 for i in range(1, min(n-r,c)+1)):
            return False
    return True

def solve(b, c, n):
    if c == n:
        print_board(b)
        return True
    for r in range(n):
        if safe(b, r, c, n):
            b[r][c] = 1
            if solve(b, c+1, n): return True
            b[r][c] = 0
    return False

n = int(input("Enter n: "))
board = [[0]*n for _ in range(n)]
board[0][0] = 1  # first Queen placed
solve(board, 1, n)