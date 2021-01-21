;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-5-8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))


; R3 -> Number
; determines the distance of p to the origin
(define (r3-distance-to-0 p)
  (sqrt (+ (sqr (r3-x p)) (sqr (r3-y p)) (sqr (r3-z p)))))

; (check-expect (r3-distance-to-0 ex1) (sqrt 174))
; (check-expect (r3-distance-to-0 ex2) (sqrt 10))
(check-expect (r3-distance-to-0 (make-r3 0 0 0)) 0)
(check-expect (r3-distance-to-0 (make-r3 0 2 0)) 2)