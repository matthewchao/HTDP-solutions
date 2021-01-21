;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname intermezzo-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
'((1 2) (2 1) (#true) #false)

(define x 42)
'(40 41 x 43 44)

;(check-expect '(1 (+ 1 1) 3) (list 1 '(+ 1 1) 3))
;(check-expect '(1 (+ 1 1) 3) (list 1 (list '+ 1 1) 3))
'(1 (+ 1 1 3))

(+ 5 3)