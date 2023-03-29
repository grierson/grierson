(define (quick-sort coll)
  (match coll
    ['() '()]
    [(cons x xs) 
     (let-values ([(xs-gte xs-lt) (partition (curry < x) xs)])
       (append (quick-sort xs-lt) 
               (list x) 
               (quick-sort xs-gte)))]))

(print (quick-sort '(3 1 9 7 2 8 1 4 6 5)))
