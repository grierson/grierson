(define (selection-sort coll)
  (define (*selection-sort* state coll)
    (if (empty? coll)
        state
        (let ([biggest (apply max coll)])
          (*selection-sort* (cons biggest state) (remove biggest coll)))))
  (*selection-sort* '() coll))

(selection-sort (list 5 3 8 1 4))
