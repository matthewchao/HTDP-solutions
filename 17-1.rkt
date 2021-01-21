;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 17-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 279
(define weird-lambda (lambda (x y) (x y y)))
; Because of the parentheses, x MUST be a function, and it must be able to receive 2 arguments
(weird-lambda + 3)
(lambda (x) 10)
;(lambda () 10)
(lambda (x) x)
(lambda (x y) x)
;(lambda x 10)


; 280
((lambda (x y) (+ x (* x y)))	 1 2)


; 3y^2 + 1/x + x
; 12 + 1 + 1
((lambda (x y)	   (+ x	      (local ((define z (* y y)))	        (+ (* 3 z) (/ 1 x)))))	 1 2) 

; (3z+1/z)(y^2) = 3y^2 + 1/y^2

; (3y^2 + 1/y^2 + x)(1,2) = 12+1/4+1 = 13.25
((lambda (x y)	   (+ x	      ((lambda (z)	         (+ (* 3 z) (/ 1 z)))	       (* y y))))	 1 2) 


; 281
((lambda (x) (< 10)) 5)
((lambda (x y) (number->string (* x y))) 5 2)
((lambda (x) (modulo x 2)) 5)
