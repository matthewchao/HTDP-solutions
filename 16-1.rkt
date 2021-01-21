;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 16-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X Y] [X Y -> Y] Y [List-of X] -> Y
; applies f from left to right to each item in lx and b
; (foldl f b (list x-1 ... x-n)) == (f x-n ... (f x-1 b))
; (define (foldl f b lx) ...)


; [X Y] [X Y -> Y] Y [List-of X] -> Y
; applies f from right to left to each item in lx and b
; (foldr f b (list x-1 ... x-n)) == (f x-1 ... (f x-n b))
; (define (foldr f b lx) ...)

(foldl - 0 (list 1 2 3 4))

;(4 - (3 - (2 - ( 1 - 0))))
;(4 - (3 - (2 - 1)))
;(4 - (3 - 1))
;(4 - 2) = 2;

(foldr - 0 (list 1 2 3 4))
; (1 - (2 - (3 - (4-0))))
;= (1 - (2 - (3 - 4)))
;= (1 - (2 - (-1))
;= (1 - 3)
;= -2

(define (myfoldr f b l)
  (cond [(empty? l) b]
        [else (f (first l) (myfoldr f b (rest l)))]))

(define l1 (list 1 2 3 4))
(define l2 (list 1 2 3))
(define l3 (list 3 6 4 42 5 6))
(check-expect (myfoldr - 0 l1) (foldr - 0 l1))
(check-expect (myfoldr - 0 l2) (foldr - 0 l2))
(check-expect (myfoldr - 0 l3) (foldr - 0 l3))



(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else
     (cons (first l) (add-at-end (rest l) s))]))



;(build-list n [n->X]) → (listof X)
; Nonnegative integer [n->x] -> [list-of x]
(define (build-l*st n f)
  (cond [(zero? n) '()]
        [else (add-at-end (build-l*st (- n 1) f) (f (- n 1)))]))


(define (fct n)
  (cond [(zero? n) 1]
        [else (* n (fct (- n 1)))]))
  
(check-expect (build-l*st 5 number->string) (build-list 5 number->string))
(check-expect (build-l*st 5 fct) (build-list 5 fct))


(define-struct address [first-name last-name street])
; An Addr is a structure: 
;   (make-address String String String)
; interpretation associates an address with a person's nam

; String String -> String 
; appends two strings, prefixes with " " 
(define (string-append-with-space s t)
  (string-append " " s t))
; string-append-with-space "hello" "world" == " helloworld"
(define (listing l)
  (foldr string-append-with-space " "
         (sort (map address-first-name l) string<?)))

; (consider without the effect of sort)
; base: " "
; (list "hi") -> " hi "
; (list "hi" "there") " hi there "
; (list "hi" "there" "matthew") " hi there matthew "


(define ex0
  (list (make-address "Robert"   "Findler" "South")
        (make-address "Matthew"  "Flatt"   "Canyon")
        (make-address "Shriram"  "Krishna" "Yellow")))
 
(check-expect (listing ex0) " Matthew Robert Shriram ")