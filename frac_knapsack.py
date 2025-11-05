n = int(input("Enter number of items: "))
wt = list(map(float, input("Enter weights: ").split()))
val = list(map(float, input("Enter values: ").split()))
cap = float(input("Enter capacity: "))

ratio = [(val[i]/wt[i], wt[i]) for i in range(n)]
ratio.sort(reverse=True)

total = 0
for r, w in ratio:
    if cap >= w:
        total += r * w
        cap -= w
    else:
        total += r * cap
        break

print("Maximum value:", total)