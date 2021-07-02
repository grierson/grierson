#!/usr/bin/racket
#lang racket
(require racket/trace)

(define (binary_search coll x low high)
    (if (<= low high)
        (let* ([mid (quotient (+ low high) 2)] [guess (list-ref coll mid)])
            (cond 
                [(= guess x) mid]
                [(> guess x) (binary_search coll x low (- mid 1))]
                [else (binary_search coll x (+ mid 1) high)]))
    high))

(define nums (list 1 3 5 7 9))

(trace binary_search)

(binary_search nums 7 0 (- (length nums) 1))