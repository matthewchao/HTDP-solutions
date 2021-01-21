;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 14-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Nelon (nonempty list of numbers) -> Number
; determines the smallest 
; number on l
(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else (min (first l) (inf (rest l)))]))
    

; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else (max (first l) (sup (rest l)))]))

(define (more cmp x y)
  (if (cmp x y) x y))
  
; (Number, Number -> Bool) NeLon -> Number
(define (most cmp l)
  (cond [(empty? (rest l)) (first l)]
        [else
         (more cmp (first l) (most cmp (rest l)))]))
         ;(if (cmp (first l) (most cmp (rest l))) (first l) (most cmp (rest l)))]))

(define (sup.v2 l)
  (most > l))

(define (inf.v2 l)
  (most < l))

(define l1 (list 1 2 3 4))
(define l2 (list 4 3 2 1))
(define l3 (list 1 3 2 4))
(define l4 (list 4 2 3 1))
(define l5 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
      12 11 10 9 8 7 6 5 4 3 2 1))
(define l6 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
      17 18 19 20 21 22 23 24 25))

(check-expect (sup l1) (sup.v2 l1))
(check-expect (sup l2) (sup.v2 l2))
(check-expect (sup l3) (sup.v2 l3))
(check-expect (sup l4) (sup.v2 l4))
(check-expect (sup l5) (sup.v2 l5))
(check-expect (sup l6) (sup.v2 l6))
(check-expect (inf l1) (inf.v2 l1))
(check-expect (inf l2) (inf.v2 l2))
(check-expect (inf l3) (inf.v2 l3))
(check-expect (inf l4) (inf.v2 l4))
(check-expect (inf l5) (inf.v2 l5))
(check-expect (inf l6) (inf.v2 l6))
