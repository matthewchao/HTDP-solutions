;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-11-3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-numbers -> List-of-numbers 
; produces a sorted DESCENDING version of alon
(define (sort> alon)
  (cond [(empty? alon) (list)]
        [else (insert (first alon) (sort> (rest alon)))]))



(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))

; Exercise 145
;  List-of-temperature -> Bool
(define (sorted>? ne-l)
  (cond [(empty? ne-l) #true]
    [(empty? (rest ne-l)) #true]
        [else (and (> (first ne-l) (first (rest ne-l))) (sorted>? (rest ne-l)))]))

(check-satisfied (sort> '()) sorted>?)
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5))
              sorted>?)


; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(define (insert n alon)
  (cond [(empty? alon) (list n)]
        [(>= n (first alon)) (cons n alon)]
        [else (cons (first alon) (insert n (rest alon)))]))



(check-expect (insert 5 '()) (list 5))

(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5))
              (list 20 12 -5))


; Exercise 187

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points 
; Hint Formulate a function that compares two elements of GamePlayer. 

(define (gp> gp1 gp2)
  (> (gp-score gp1) (gp-score gp2)))

(define (gp>= gp1 gp2)
  (>= (gp-score gp1) (gp-score gp2)))

(define (sortgp> alogp)
    (cond [(empty? alogp) (list)]
        [else (insertgp (first alogp) (sortgp> (rest alogp)))]))

(define (insertgp n alon)
  (cond [(empty? alon) (list n)]
        [(gp>= n (first alon)) (cons n alon)]
        [else (cons (first alon) (insertgp n (rest alon)))]))



;Exercise 189
; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

; Number Ascending-Sorted-List-of-numbers -> Boolean
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [(= (first alon) n) #true]
    [(> (first alon) n) #false]
    [else (search-sorted n (rest alon))]))

(check-expect (search-sorted 5 (list 1 2 3 4 5 6)) #true)
(check-expect (search-sorted 5 (list 6 7)) #false)
(check-expect (search-sorted 5 (list 4 6)) #false)
(check-expect (search-sorted 5 (list 4 5)) #true)


(check-expect (prefixes (list "a" "b" "c")) (list (list "a") (list "a" "b") (list "a" "b" "c")))
(check-expect (prefixes (list "a" "a")) (list (list "a") (list "a" "a")))


; List-of-1str -> list-of-list-of-1str
(define (prefixes lo1s)
  (cond [(empty? lo1s) (list)]
        [else (cons (list (first lo1s)) (prepend-all (first lo1s) (prefixes (rest lo1s)))) ]))

; 1str, list-of-list-of-1str -> list-of-list-of-1str
; prepends 1str to every list in lolo1s
(define (prepend-all ch lolo1s)
  (cond [(empty? lolo1s) (list)]
        [else (cons (cons ch (first lolo1s)) (prepend-all ch (rest lolo1s)))]))
  

; Exercise 190
; List-of-1str -> list-of-list-of-1str
(check-expect (suffixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "b" "c") (list "c")))
(check-expect (suffixes (list "a" "a")) (list (list "a" "a") (list "a")))
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list)) (list))

(define (suffixes lo1s)
  (cond [(empty? lo1s) (list)]
        [else (cons lo1s (suffixes (rest lo1s)))]))
