;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 16-5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Sample Problem Design add-3-to-all. The function consumes a list of Posns and adds 3 to the x-coordinates of each.


; [List-of Posn] -> [List-of Posn]
; adds 3 to each x-coordinate on the given list

(define (add-3-to-all l)
  (local
                (
                 (define (add-3-to-1 p)
                   (make-posn (+ 3 (posn-x p)) (posn-y p)))
                 )
                (map add-3-to-1 l)))

(check-expect
 (add-3-to-all
   (list (make-posn 3 1) (make-posn 0 0)))
 (list (make-posn 6 1) (make-posn 3 0)))



; [List-of Posn] -> [List-of Posn]
; eliminates Posns whose y-coordinate is > 100
; 
;(check-expect
; (keep-good (list (make-posn 0 110) (make-posn 0 60)))
; (list (make-posn 0 60)))
; 
;(define (keep-good lop)
;  (local
;    (
;     (define (good? p)
;       (<= (posn-y p) 100))
;     )
;    (filter good? lop)))


; [List-of Posn] Posn -> Boolean
; is any Posn on lop close to pt

(define (close? lop pt)
  (local
    (
    (define (is-close-to-pt? p)
      (<= (+ (sqr (- (posn-x p) (posn-x pt))) (sqr (- (posn-y p) (posn-y pt)))) (sqr 5)))
    )
    (ormap is-close-to-pt? lop)))

(check-expect
 (close? (list (make-posn 47 54) (make-posn 0 60))
         (make-posn 50 50))
 #true)
