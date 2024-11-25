def binary_search(coll, elem):
    low = 0
    high = len(coll) - 1

    while low <= high:
        middle = (low + high) // 2
        guess = coll[middle]

        if guess == elem:
            return middle
        if guess > elem:
            high = middle - 1
        else:
            low = middle + 1

    return None


print(binary_search([1, 3, 5, 7, 9], 0))
print(binary_search([1, 3, 5, 7, 9], 7))
