#lang racket

; (define (selection-sort coll)
;   (if (empty? coll) 
;       '()
;       (let ([smallest (apply min coll)])
;         (cons smallest (selection-sort (remove smallest coll))))))

(define (selection-sort coll)
  (define (*selection-sort* state coll)
    (if (empty? coll) 
        state
        (let ([smallest (apply max coll)])
          (*selection-sort* (cons smallest state) (remove smallest coll)))))
  (*selection-sort* '() coll))

(selection-sort (list 5 3 8 1 4))
