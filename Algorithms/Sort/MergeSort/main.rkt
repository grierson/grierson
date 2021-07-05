#lang racket
(require rackunit)

; [sorted int] [sorted int] -> [sorted int]
(define (merge c1 c2)
  (define (*merge* state a b)
    (cond
      [(empty? a) (append state b)]
      [(empty? b) (append state a)]
      [else (let ([x (first a)]
                  [y (first b)])
              (if (<= x y)
                  (*merge* (append state (list x)) (rest a) b)
                  (*merge* (append state (list y)) a (rest b))))]))
  (*merge* '() c1 c2))

(check-equal? (merge '() '()) '())
(check-equal? (merge '(1 2) '()) '(1 2))
(check-equal? (merge '() '(1 2)) '(1 2))
(check-equal? (merge '(1) '(2)) '(1 2))
(check-equal? (merge '(2) '(1)) '(1 2))
(check-equal? (merge '(2 3) '(1 4)) '(1 2 3 4))

; [int] -> [[1st half] [2nd half]] 
(define (split coll)
  (let* [(n (length coll))
         (p (quotient n 2))]
    (list (take coll p) (drop coll p))))

(check-equal? (split '()) '(() ()))
(check-equal? (split '(1)) '(() (1)))
(check-equal? (split '(1 2)) '((1) (2)))
(check-equal? (split '(1 2 3)) '((1) (2 3)))

; [int] -> [sorted int]
(define (merge-sort coll)
  (cond [(empty? coll) coll]
        [(empty? (rest coll)) coll]
        [else (match-let ([(list fhalf shalf) (split coll)])
                (merge
                 (merge-sort fhalf)
                 (merge-sort shalf)))]))

(check-equal? (merge-sort '()) '())
(check-equal? (merge-sort '(1)) '(1))
(check-equal? (merge-sort '(1 2)) '(1 2))
(check-equal? (merge-sort '(3 2 1)) '(1 2 3))