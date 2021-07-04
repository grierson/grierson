= Selection Sort

O(n^2)

Have to pass over collection each time.
----
findSmallest([100 things])
findSmallest([99 things])
findSmallest([98 things])
...
findSmallest([3 things])
findSmallest([2 things])
findSmallest([1 things])
----

== Pseudo code
. Find smallest/biggest value in collection
. Add value to start/end of new collection
. Remove value from original collection
. Repeat until original collection is empty
