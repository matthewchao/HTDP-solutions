;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-9-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)


(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

; NEList-of-temperatures -> Number
; computes the average temperature 
 
(check-expect (average (cons 1 (cons 2 (cons 3 '()))))
              2)
 
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))
 
; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many alot)
  (cond [(empty? alot) 0]
        [else (+ 1 (how-many (rest alot)))]))

(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)

; Exercise 145
; Nonempty List-of-temperature -> Bool
(define (sorted>? ne-l)
  (cond [(empty? (rest ne-l)) #true]
        [else (and (> (first ne-l) (first (rest ne-l))) (sorted>? (rest ne-l)))]))

(check-expect (sorted>? (cons 1
  (cons 2
    '()))) #false)

(check-expect (sorted>? (cons 3
  (cons 2
    '()))) #true)

(check-expect (sorted>? (cons 0
  (cons 3
    (cons 2
      '())))) #false)
