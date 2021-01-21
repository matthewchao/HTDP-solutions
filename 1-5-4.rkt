;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-5-4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title producer year])

(define-struct person [name hair eyes phone])

(define-struct pet [name number])

(define-struct CD [artist title price])

(define-struct sweater [material size producer])

; exercise 66

(define my-sweater (make-sweater "cotton" "large" "hm"))
(sweater-material my-sweater)
(sweater-size my-sweater)
(sweater-producer my-sweater)
(sweater? my-sweater)


(define-struct entry [name phone email])


(define-struct ball [location velocity])

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")
; This assumes that all instances of balld move at the same speed
; but perhaps in different directions and at different locations

(define-struct vel [deltax deltay])

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

; Exercise 68
(define-struct ballf [x y deltax deltay])

(define ball2 (make-ballf 30 40 -10 5))

(check-expect (ballf-x ball2) (posn-x (ball-location ball1)))
(check-expect (ballf-y ball2) (posn-y (ball-location ball1)))
(check-expect (ballf-deltax ball2) (vel-deltax (ball-velocity ball1)))
(check-expect (ballf-deltay ball2) (vel-deltay (ball-velocity ball1)))

