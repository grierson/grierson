# Algorithms

image::cheatsheet.png[cheatsheet]

## Big O

Worst case scenario of how algorithm grows.
Some algorithms my have `O(n^2)` for worst case
but on average will be `O(N log N)` so picking depends on context

Also reduce O down to the worst case so if Algorithm is O(n) + O(n^2) just reduce it down to O(n^2)

| Name | O | Example | Note
|-------------- | -------------- | --- | --- |
| Constant | O(1) | Access hashmap | Constant time
| Logarithmic | O(log n) | Binary Search | Divide and Conquer
| Linear | O(n) | Simple search | Grows linearly
| Log-Linear | O(n * log n) | Quick sort |
| Quadratic | O(n^2) | Selection sort |
| Exponential | O(2^n) | ? |
| Factorial | O(n!) | Traveling sales man | Grows rapidly

### Example

1,000,000 records - 1 ms per compare record

| Big-O | Elapsed |
|-------------- | -------------- |
| O(1) | 1 ms |
| O(log n) | 6 ms |
| O(n) | 16 mins |
| O(n^2) | 31 years |
| O(2^n) | 🔥 |
| O(n!) | 🔥 |

## Glossary

* **Big O** : Measure for algorithm (Default worst case)
* **Time Complexity** : How fast an algorithm runs as input (n) size increases.
* **Space Complexity** : How much memory an algorithm uses
* **Logarithms** : wet, cold dirt
* **Factorial** : wet, cold dirt

## Resources

* <https://www.algoexpert.io/data-structures[AlgoExpert.io>]
* <https://www.manning.com/books/grokking-algorithms[Grokking> Algorithms]
