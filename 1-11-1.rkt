;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-11-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define l1 (list "a" "b" "c" "d"))
(define l2 (list (list 1 2)))
(define l3 (list "a" (list 1) #false))
(define l4 (list (list "a" 2) "hello"))

(check-expect l1 (cons "a" (cons "b" (cons "c" (cons "d" '())))))
(check-expect l2 (cons (cons 1 (cons 2 '())) '()))
(check-expect l3 (cons "a" (cons (cons 1 '()) (cons #false '()))))
(check-expect l4 (cons (cons "a" (cons 2 '())) (cons "hello" '())))


(define l5 (list (list 1 2) (list 2)))

(check-expect l5 
(cons (cons 1 (cons 2 '()))
      (cons (cons 2 '())
            '())))

; the innermost list is a 1-element list consisting of (list 2)
; we prepend to this list the 2-element list consisting of 1 2

(check-expect (list 0 1 2 3 4 5) (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))

; a list consisting of 3 lists;
(check-expect (cons
(cons "he" (cons 0 '()))
(cons 
(cons "it" (cons 1 '()))
(cons 
(cons "lui" (cons 14 '())) '()))) (list (list "he" 0) (list "it" 1) (list "lui" 14))
)


; a list consisting of a single element,  a 2-element list, and a 3-element list
(check-expect (cons 
1
(cons 
(cons 1 (cons 2 '()))
(cons 
(cons 1 (cons 2 (cons 3 '()))) '()))) (list 1 (list 1 2) (list 1 2 3)))


(define k1 (cons "a" (list 0 #false)))

(define k2 (list (cons 1 (cons 13 '()))))

(define k3 (cons (list 1 (list 13 '())) '()))

(define k4 (list '() '() (cons 1 '())))

(define k5 (cons "a" (cons (list 1) (list #false '()))))


; join a to the list consititng of 2 elements:
;(cons "a" (list 0 #false))
(check-expect (list "a" 0 #false) k1)

; (list (cons 1 (cons 13 '())))
;a list constitng of a single list of 2 elements
(check-expect (list (list 1 13)) k2)

; (cons (list 1 (list 13 '())) '())
; inside is a list consisting of 13 and MT
; outside is a list consisting of 1 and the above list;
; outside again is a list consisting of the above
(check-expect (list (list 1 (list 13 (list)))) k3)

; (list '() '() (cons 1 '()))
; a list consisting of 3 elements; an empty list, an empty list, and a 1-element list
(check-expect (list (list) (list) (list 1)) k4)

; (cons "a" (cons (list 1) (list #false '())))
; a list constiting of 'a' prepended to the list consisting of 3 elements: { {1}, false, MT }
(check-expect (list "a" (list 1) #false (list)) k5)


(check-expect
(list (string=? "a" "b") #false)
(list #false #false))

(check-expect
(list (+ 10 20) (* 10 20) (/ 10 20))
(list 30 200 0.5))

;(list "dana" "jane" "mary" "laura")


; (first (list 1 2 3))

; (rest (list 1 2 3))

; (second (list 1 2 3))