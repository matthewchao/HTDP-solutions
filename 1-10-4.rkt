;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-10-4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))
(define ll (rest all));
(define al (cons "a" (cons "l" '())))
(define la (rest lla))
(define agood
  (cons "a" good));
(define lgood (cons "l" good))
 
; data example 1: 
(define e1 (make-editor all good))
 
; data example 2:
(define e2 (make-editor lla good))

; data example 3;
(define e3 (make-editor la lgood))

(check-expect (move-left e2) e3)
(check-expect (move-left (make-editor lla '()))
                         (make-editor la (cons "l" '())))
(check-expect (move-left (move-right e2)) e2)
(check-expect (move-right (move-left e2)) e2)

; hello | world
; should be "world" as post in its right order;
; and o->l->l->e->h in reverse order
; move cursor left? join o to world
; and now l->l->e->h is it;


; move cursor right? do w joined to o->l->l->e->h
; and then the rest of world;


; Editor -> Editor
; Moves the cursor left
(define (move-left e)
  (cond [(empty? (editor-pre e)) e]
        [else (make-editor (rest (editor-pre e)) (cons (first (editor-pre e)) (editor-post e)))]))

; Moves the cursor right
(define (move-right e)
  (cond [(empty? (editor-post e)) e]
        [else (make-editor (cons (first (editor-post e)) (editor-pre e))
               (rest (editor-post e)))]))

; Editor -> Editor
; Backspace
(define (backspace e)
  (cond [(empty? (editor-pre e)) e]
        [else (make-editor (rest (editor-pre e)) (editor-post e))]))

; Editor 1str -> Editor
(define (type e ch)
  (make-editor (cons ch (editor-pre e)) (editor-post e)))
  



; List of 1strings
; Lo1s -> Lo1s 
; produces a reverse version of the given list 
 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
(check-expect (rev '()) '())

; List->List
(define (rev l)
  (cond [(empty? l) l]
        [(= 1 (length l)) l]
        [else (my-append (rev (rest l)) (first l))]))

; ListOfThings, Thing -> ListOfThings
(define (my-append l x)
  (cond [(empty? l) (cons x '())]
        [else (cons (first l) (my-append (rest l) x))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
 
(check-expect
  (my-append (cons "c" (cons "b" '())) "a")
  (cons "c" (cons "b" (cons "a" '()))))



; String String -> Editor
(define (create-editor s1 s2)
  (make-editor (rev (explode s1)) (explode s2)))

(check-expect (create-editor "all" "good") e2)


(define HEIGHT 20) ; the height of the editor 
(define WIDTH 600) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
(require 2htdp/image)
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))



;Editor -> Image
(define (text-with-cursor e)
  (beside (text (implode (rev (editor-pre e))) 16 "black") CURSOR (text (implode (editor-post e)) 16 "black")))

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render e)
  (overlay/align "left" "middle" (text-with-cursor e) MT))


(define ignore-key-list (cons "rcontrol" (cons "control" (cons "escape" (cons "\r" (cons "rshift" (cons "shift" '())))))))

; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(define (editor-kh ed ke)
  (cond [(string=? ke "left") (move-left ed)]
        [(string=? ke "right") (move-right ed)]
        [(string=? ke "\b") (backspace ed)]
        [(member? ke ignore-key-list) ed]
        [else (type ed ke)]))

(require 2htdp/universe)
; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))


(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))

(check-expect
 (editor-kh (create-editor "cd" "fgh") "\b")
 (create-editor "c" "fgh"))
(check-expect
 (editor-kh (create-editor "cd" "fgh") "left")
 (create-editor "c" "dfgh"))
(check-expect
 (editor-kh (create-editor "cd" "fgh") "right")
 (create-editor "cdf" "gh"))


(main "hello")