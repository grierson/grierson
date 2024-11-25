from collections import deque

network = {
    "kenny": ["nick", "matt", "karl"],
    "nick": ["sammy"],
    "matt": ["sammy"],
    "karl": ["britt"],
    "sammy": [],
    "britt": []
}


def isChamp(person):
    return person == "britt"


def findChamp(people):
    seen = []

    while people:
        person = people.popleft()

        if not person in seen:
            if (isChamp(person)):
                return person

            seen.append(person)
            people += network[person]

    return False


print(findChamp(deque(network["kenny"])))
