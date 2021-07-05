#lang racket

(define (quick-sort coll)
  (case (length coll)
    [(0 1) coll]
    [(2) (let ([x (first coll)]
               [y (second coll)])
           (if (< x y)
               (list x y)
               (list y x)))]
    [else (let* ([pivot (first coll)]
                 [lessThan (filter (lambda (n) (<= n pivot)) (rest coll))]
                 [greaterThan (filter (lambda (n) (> n pivot)) (rest coll))])
            (append (quick-sort lessThan) (list pivot) (quick-sort greaterThan)))]))

(print (quick-sort '(3 1 9 7 2 8 1 4 6 5)))