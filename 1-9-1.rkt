;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-9-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

; List-of-amounts -> Number
; computes the sum of all amounts in the list
(define (sum l)
  (cond [(empty? l) 0]
        [else (+ (sum (rest l)) (first l))]))

(define ex1 (cons 5 '()))
(define ex2 (cons 4 ex1))
(define ex3 (cons 0 ex2))
(check-expect (sum ex1) 5)
(check-expect (sum ex2) 9)
(check-expect (sum ex3) 9)

; Exercise 139
; List-of-numbers -> Bool
; Determines whether a list of numbers is a List-of-amounts
(define (pos? l)
  (cond [(empty? l) #true]
        [else (and (>= (first l) 0) (pos? (rest l)))]))

(define ex4 (cons -3 ex3))
(define ex5 (cons 1 ex4))

(check-expect (pos? ex3) #true)
(check-expect (pos? '()) #true)
(check-expect (pos? ex4) #false)
(check-expect (pos? ex5) #false)


; Exercise 141
; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))


; Exercise 142

; ImageOrFalse is one of:
; – Image
; – #false

; List-of-images Number -> ImageOrFalse

(define (ill-sized? loi n)
  (cond [(empty? loi) #false]
        [(and (= (image-width (first loi)) n) (= (image-height (first loi)))) (ill-sized? (rest-loi))]
        [else (first loi)]))
