# Linked List

Node stores data and references to next node.

```python
class Node
  def __init__(self, val, nxt):
    self.value = val
    self.next = nxt
```

 Used in `stacks` and `queues` because

* Items constantly added/removed from head
* List size constantly changing

| Pro | Con   |
|-------------- | -------------- |
| List can grow/shrink without reallocation| No random access |

| | Linked List    | Array    | Note    |
|---------------- | --------------- | --------------- | ---- |
| Access | O(n) | O(1) | LL has to step through each node. Array already in order
| Insert/Remove first | O(1) | O(n) | LL Add/Remove from head, Array has to reallocate
| Insert/Remove last | O(n) | O(1) | LL step through each, Array can remove without realloc
| Insert/Remove middle | O(n) | O(n) | Linked List step through list, Array has to realloc
