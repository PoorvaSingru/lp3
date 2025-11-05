def fib_iter(n):
    a, b = 0, 1
    print("Fibonacci Series (Iterative):", end=" ")
    for _ in range(n):
        print(a, end=" ")
        a, b = b, a + b
    print()

n = int(input("Enter number of terms: "))
fib_iter(n)
def fib_rec(n):
    if n <= 1:
        return n
    else:
        return fib_rec(n-1) + fib_rec(n-2)

n = int(input("Enter number of terms: "))
print("Fibonacci Series (Recursive):", end=" ")
for i in range(n):
    print(fib_rec(i), end=" ")
print()
