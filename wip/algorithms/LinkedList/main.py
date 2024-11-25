class Node:
    def __init__(self, data):
        self.data = data
        self.next = None


n1 = Node(1)
n2 = Node(2)
n3 = Node(3)

n1.next = n2
n2.next = n3


def printlist(n):
    print(n.data)
    if (n.next != None):
        printlist(n.next)


printlist(n1)
