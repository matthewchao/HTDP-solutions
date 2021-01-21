;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 15-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons
      (sin n)
      (tab-sin (sub1 n)))]))
  

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (sqrt n)
      (tab-sqrt (sub1 n)))]))

; (Number->Number) Nonnegative Number -> [List-of Number]
(define (tabulate f n)
  (cond [(= n 0) (list (f 0))]
        [else (cons (f n) (tabulate f (sub1 n)))]))

(define (tab-sqrt.v2 n)
  (tabulate sqrt n))

(define (tab-sin.v2 n)
  (tabulate sin n))

(check-within (tab-sqrt 5) (tab-sqrt.v2 5) .000001)
(check-within (tab-sin 10) (tab-sin.v2 10) .000001)



; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (cond
    [(empty? l) 0]
    [else
     (+ (first l)
        (sum (rest l)))]))
; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))

; (Number, Number -> Number), Number, [List-of Number] -> Number

(define (fold1 f fnil l)
  (cond [(empty? l) fnil]
        [else (f (first l) (fold1 f fnil (rest l)))]))
(define (sum.v1 l)
  (fold1 + 0 l))
(define (product.v2 l)
  (fold1 * 1 l))

(define exlist1 (list 1 3 2 4 -1))
(define exlist2 (list 1 0 2))
(check-expect (sum.v1 exlist2) (sum exlist2))
(check-expect (sum.v1 exlist1) (sum exlist1))
(check-expect (product exlist1) (product.v2 exlist1))
(check-expect (product exlist2) (product.v2 exlist2))




; [List-of Posn] -> Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else
     (place-dot
      (first l)
      (image* (rest l)))]))

(require 2htdp/image)
; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))

;  (ITEM ITEM -> ITEM2) ITEM2 [list-of ITEM] -> ITEM2
(define (fold2 f nilval l)
  (cond [(empty? l) nilval]
        [else (f (first l) (fold2 f nilval (rest l)))]))
