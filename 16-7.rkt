;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 16-7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 268. An inventory record specifies the name of an item, a description, the acquisition price, and the recommended sales price.

; Define a function that sorts a list of inventory records by the difference between the two prices.
(define-struct record [name desc buy-price sell-price])


(define (profit r)
  (- (record-sell-price r) (record-buy-price r)))

(define (cmp-profit rec1 rec2)
   (< (profit rec1) (profit rec2)))

; List-of Records -> List-of Records
(define (sort-records lor)
   (sort lor cmp-profit))

; Exercise 269. Define eliminate-expensive. The function consumes a number, ua, and a list of inventory records, and it produces a list of all those structures whose sales price is below ua.
(define (eliminate-expensive ua lor)
  (local
    ((define (cheap-enough? rec)
      (<= (record-sell-price rec) ua)))
    (filter cheap-enough? lor)))


; 270-1
(define (num-less-than n)
  (local
    ((define (identity x) x))
    (build-list n identity)))

(check-expect (num-less-than 5) (list 0 1 2 3 4))

; 270-2
(define (one-to n)
  (build-list n add1))
(check-expect (one-to 5) (list 1 2 3 4 5))

; 270-3
(define (harmonic n)
  (local
    ((define (recip x) (/ 1 x))
     (define (f x) (recip (add1 x))))
    (build-list n f)))
(check-expect (harmonic 3) (list 1 (/ 1 2) (/ 1 3)))

; 270-4
(define (first-even n)
  (local
    ((define (f x) (* 2 (add1 x))))
    (build-list n f)))
(check-expect (first-even 2) (list 2 4))

; 270-5
(define (identityM n)
  (local
    ((define (f i) ;want this to equal a row of n 0's except the (i-th) is replaced by a 1
       (append (make-list i 0) (list 1) (make-list (sub1  (- n i)) 0))))
    (build-list n f)))
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 3)
(list (list 1 0 0) (list 0 1 0) (list 0 0 1)))



; 273
; [X->Y] List-of-X -> List-of-Y
(define (mymap f l)
  (local
    ; x, list-of-y -> list-of-y
    ; the idea is that everywhere "Y" appears in the documentation for foldr,
    ; we replace it with List-Of-Y
    ((define (g x list-of-y)
       (cons (f x) list-of-y)))
  (foldr g '() l)))

(define ex-list (build-list 5 identity))
(check-expect (map add1 ex-list) (mymap add1 ex-list))



; 274
; [List-of 1str] -> [List-of [List-of 1str]]
; returns all prefixes of a list of 1 strings
(define (prefixes loc)
  (local
    ; character list-of-list-of 1str -> list-of-list-of 1str
    ; prepends loloc with the first of loloc + c
    ((define (f c loloc)
           (cons (append (first loloc) (list c)) loloc)))
    (foldl f (list '()) loc)))


(define loc (list "a" "b" "c" "d" "e"))
(prefixes loc)
