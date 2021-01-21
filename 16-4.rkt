;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 16-4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Nelon -> Number
; determines the smallest number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define smallest-in-rest (inf (rest l))))
       (if (< (first l) smallest-in-rest)
           (first l)
           smallest-in-rest))]))


;(inf (list 2 1 3))


    

; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else (local
            ((define sup-of-rest (sup (rest l))))
     (if (> (first l)
            sup-of-rest)
         (first l)
         sup-of-rest))]))

;(sup (list 2 1 3))

;
;(
; (local
;   (
;    ; ALL DEFINITIONS HERE f(x) = 4x^2 + 3
;    (define (f x) (+ (* 4 (sqr x)) 3))
;    )
;   f)
; 1)



((local ((define (f x) (+ x 3))
         (define (g x) (* x 4)))
   (if (odd? (f (g 1)))
       f
       g))
 2)