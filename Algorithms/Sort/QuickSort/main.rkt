#lang racket

; (define (quick-sort coll)
;   (case (length coll)
;     [(0 1) coll]
;     [(2) (let ([x (first coll)]
;                [y (second coll)])
;            (if (< x y)
;                (list x y)
;                (list y x)))]
;     [else (let* ([pivot (first coll)]
;                  [lessThan (filter (lambda (n) (<= n pivot)) (rest coll))]
;                  [greaterThan (filter (lambda (n) (> n pivot)) (rest coll))])
;             (append (quick-sort lessThan) (list pivot) (quick-sort greaterThan)))]))

(define (quick-sort coll)
  (match coll
    ['() '()]
    [(cons x xs) 
     (let-values ([(xs-gte xs-lt) (partition (curry < x) xs)])
       (append (quick-sort xs-lt) 
               (list x) 
               (quick-sort xs-gte)))]))

(print (quick-sort '(3 1 9 7 2 8 1 4 6 5)))