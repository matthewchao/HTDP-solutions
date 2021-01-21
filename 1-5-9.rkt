;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-5-9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A SpaceGame is a structure:
;   (make-space-game Posn Number). 
; interpretation (make-space-game (make-posn ux uy) tx)
; describes a configuration where the UFO is 
; at (ux,uy) and the tank's x-coordinate is tx

(define-struct space-game [ufo tank])


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define TEXT-FIELD (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))
(define FONT-SIZE 16)
(define FONT-COLOR "black")

(require 2htdp/image)
; Editor -> Image
(define (render editor)
  (overlay/align "left" "center"
                 (cursor-image editor)
                 TEXT-FIELD))

(define (cursor-image editor)
  (beside (text (editor-pre editor) FONT-SIZE FONT-COLOR)
          CURSOR
          (text (editor-post editor) FONT-SIZE FONT-COLOR)))

(define ex1 (make-editor "hello" "world"))

(define (backspace-string s)
  (if (string=? s "") s (substring s 0 (- (string-length s) 1))))

(define (change-pre editor s)
  (make-editor s (editor-post editor)))

(define (ignored-whitespace? ke)
  (or (string=? ke "\t") (string=? ke "\r")))

(define (string-last s)
  (substring s (- (string-length s) 1)))

(define (string-rest s)
  (substring s 1))

(define (string-first s)
  (substring s 0 1))

  
(define (edit ed ke)
  (cond [(string=? ke "\b") (change-pre ed (backspace-string (editor-pre ed)))]
        [(string=? ke "left")
         (if (string=? (editor-pre ed) "") ed
             ; move last letter of pre to post
             (make-editor (backspace-string (editor-pre ed))
                          (string-append (string-last (editor-pre ed)) (editor-post ed))))]
        [(string=? ke "right")
         (if (string=? (editor-post ed) "") ed
             ; move first letter of post to pre
             (make-editor (string-append (editor-pre ed) (string-first (editor-post ed)))
                          (string-rest (editor-post ed))))]
        [(and (= (string-length ke) 1) (not (ignored-whitespace? ke))) (change-pre ed (string-append (editor-pre ed) ke))]
        [else ed]))

(define ex2 (make-editor "" "world"))
(define ex3 (make-editor "hello" ""))
(check-expect (edit ex1 "a") (make-editor "helloa" "world"))
(check-expect (edit ex1 "\b") (make-editor "hell" "world"))
(check-expect (edit ex1 " ") (make-editor "hello " "world"))
(check-expect (edit ex1 "\t") ex1)
(check-expect (edit ex1 "\r") ex1)
(check-expect (edit ex2 "left") ex2)
(check-expect (edit ex3 "right") ex3)
(check-expect (edit ex1 "left") (make-editor "hell" "oworld"))
(check-expect (edit ex1 "right") (make-editor "hellow" "orld"))

(require 2htdp/universe)

; String -> InteractiveEditor
; takes a string, and starts a text editor with the cursor positioned after that string
(define (run s)
  (big-bang (make-editor s "")
    (on-key edit)
    (to-draw render)))
