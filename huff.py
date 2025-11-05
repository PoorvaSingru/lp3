class Node:
    def __init__(self, ch=None, freq=None, left=None, right=None):
        self.ch = ch
        self.freq = freq
        self.left = left
        self.right = right

def build_tree(text):
    freq = {c: text.count(c) for c in set(text)}
    nodes = [Node(c, f) for c, f in freq.items()]
    while len(nodes) > 1:
        nodes.sort(key=lambda x: x.freq)
        l, r = nodes.pop(0), nodes.pop(0)
        nodes.append(Node(freq=l.freq + r.freq, left=l, right=r))
    return nodes[0]

def make_codes(node, code="", codes={}):
    if node.ch:
        codes[node.ch] = code
        return
    make_codes(node.left, code + "0", codes)
    make_codes(node.right, code + "1", codes)
    return codes

text = input("Enter text: ")
root = build_tree(text)
codes = make_codes(root)
print("\nHuffman Codes:")
for c, code in codes.items():
    print(f"{c}: {code}")