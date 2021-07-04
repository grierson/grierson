def findSmallest(coll):
    index = 0
    smallest = coll[0]

    for i in range(1, len(coll)):
        val = coll[i]
        if val < smallest:
            index = i
            smallest = val

    return index


def selection_sort(coll):
    newColl = []

    while coll:
        x = findSmallest(coll)
        y = coll.pop(x)
        newColl.append(y)

    return newColl


print(selection_sort([5, 3, 8, 1, 4]))
