def binary_search(coll, x):
    low = 0
    high = len(coll) - 1

    while low <= high:
        mid = low + high
        guess = coll[mid]

        if guess == x:
            return mid
        if guess > x:
            high = mid - 1
        else:
            low = mid + 1

    return None


print(binary_search([1, 3, 5, 7, 9], 3))
