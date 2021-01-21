;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-11-4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

(require 2htdp/image)
; a plain background image 
(define MT (empty-scene 50 50))


(define LINE-COLOR "red")


; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
(define (render-line im p q)
  (scene+line im (posn-x p) (posn-y p) (posn-x q) (posn-y q) LINE-COLOR))



; Image Polygon -> Image
; renders the given polygon p into img
(define (render-poly img p)
  (connect-dots img (cons (last p) p)))
  

(check-expect
  (render-poly MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))

(check-expect
  (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))

(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))
 

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))


; An NELoP is one of: (nonempty list of points)
; – (cons Posn '())
; – (cons Posn NELoP)


; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
; Specifically if the points are p1 p2 ... pn, it draws n-1 lines between p[i] and [i-1] for i=2 through i=n
(define (connect-dots img p)
  (cond [(empty? (rest p)) img]
        [else (render-line (connect-dots img (rest p)) (first p) (second p))]))

(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 20 30 20 "red")
               20 10 20 20 "red"))


; NELoP -> Posn
; extracts the last item from p
(define (last p)
  (cond [(empty? (rest p)) (first p)]
        [else (last (rest p))]))