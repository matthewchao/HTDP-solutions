;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 15-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 254

; sort-n
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]


; Sorted-list-of-numbers Number -> Sorted-list-of-number
(define (insert-n-into l x)
  (cond [(empty? l) (list x)]
        [else (if (< x (first l)) (cons x l)
                  (cons (first l) (insert-n-into (rest l) x)))]))
  
(define (sort-n l)
  (cond [(empty? l) l]
        [else (insert-n-into (sort-n (rest l)) (first l))]))

(define exlist1 (list 1 2 3 4 5))
(define exlist2 (list 5 4 3 2 1))
(define exlist3 (list 1 5 2 3 4))
(define exlist4 (list 1 5 4 3 2))

(check-expect (sort-n exlist1) (sort exlist1 <))
(check-expect (sort-n exlist2) (sort exlist2 <))
(check-expect (sort-n exlist3) (sort exlist3 <))
(check-expect (sort-n exlist4) (sort exlist4 <))


; Sorted [List-of X] [X X -> Boolean] X -> Sorted [List-of X]
(define (my-insert l cp x)
  (cond [(empty? l) (list x)]
        [else (if  (cp x (first l))
                   (cons x l)
                  (cons (first l) (my-insert (rest l) cp x)))]))
                  

; [List-of X] [X X -> Boolean] -> [List-of X]
(define (my-sort l cp)
  (cond [(empty? l) l]
        [else (my-insert (my-sort (rest l) cp) cp (first l))]))

                         
(define (sort-n.v2 l)
  (my-sort l <))

(sort-n.v2 exlist1)

(check-expect (sort-n exlist1) (sort-n.v2 exlist1))
(check-expect (sort-n exlist2) (sort-n.v2 exlist2))
(check-expect (sort-n exlist3) (sort-n.v2 exlist3))
(check-expect (sort-n exlist4) (sort-n.v2 exlist4))