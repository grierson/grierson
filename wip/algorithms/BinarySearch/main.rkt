(require rackunit)

(define (binary_search coll x)
  (define (*binary_search* low high)
    (if (<= low high)
        (let* ([middle (quotient (+ low high) 2)]
               [guess (list-ref coll middle)])
          (cond
            [(= guess x) middle]
            [(> guess x) (*binary_search* low (- middle 1))]
            [else (*binary_search* (+ middle 1) high)]))
        high))
  (*binary_search* 0 (- (length coll) 1)))

(check-equal? (binary_search (list 1 3 5 7 9) 0) -1 "-1 when not found")
(check-equal?  (binary_search (list 1 3 5 7 9) 7) 3 "Return index when found")
