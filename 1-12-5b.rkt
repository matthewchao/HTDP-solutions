;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-12-5b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define BOARD-WIDTH 40) ;THE NUMBER OF CELLS WIDE
(define BOARD-HEIGHT 30)
(define WORM-DIAMETER 10)
(define WORM-SPEED 1) ;the number of cells the worm proceeds, per clock ticket
(define WORM (circle (/ WORM-DIAMETER 2) "solid" "red"))
(define FOOD (square WORM-DIAMETER "solid" "blue"))
(define LEFT "left")
(define RIGHT "right")
(define UP "up")
(define DOWN "down")
(define ACTUAL-WIDTH (* BOARD-WIDTH WORM-DIAMETER))
(define ACTUAL-HEIGHT (* BOARD-HEIGHT WORM-DIAMETER))
;WORM
(require 2htdp/image)
(define MT (empty-scene ACTUAL-WIDTH ACTUAL-HEIGHT))
; MT

; A worm-segment is a posn (make-posn x y) WHERE 0<=x<BOARD-WIDTH
; AND 0<=y<=BOARD-HEIGHT

; A WORM-WITH TAIL IS A NONEMPTY LIST OF worm-segments (
; Interpretation; the ith item in the list being (make-posn x y) is the ith segment of the worm,
; located at the x-th cell to the right and the y-th cell down, both 0-indexed


; A DIRECTION is a string "left" "right" "up" or "down"
; Interpetation, the LAST direction that the head moved.

; A SCENE is an image with the same dimensions as MT

; Worm-segment, Scene -> Image
(define (render-segment ws im )
  (place-image/align WORM (* (posn-x ws) WORM-DIAMETER) (* (posn-y ws) WORM-DIAMETER) "left" "top" im))

(define (render-worm w)
  (cond [(empty? (rest w)) (render-segment (first w) MT)]
        [else (render-segment (first w) (render-worm (rest w)))]))

(define worm1 (list (make-posn 2 1) (make-posn 1 1) (make-posn 0 1) (make-posn 0 0)))
;(render-worm worm1)


; A FOOD is a Posn

; A WORM-GAME IS A STRUCT [worm food direction moved]
(define-struct worm-game [worm food direction moved])

(define (render wg)
  (place-image/align FOOD (* (posn-x (worm-game-food wg)) WORM-DIAMETER) (* (posn-y (worm-game-food wg)) WORM-DIAMETER) "left" "top"
                     (render-worm (worm-game-worm wg))))

(define ex-wg (make-worm-game worm1 (make-posn 10 10) "left" #false))
(render ex-wg)


; List -> Posn
; returns a new fruit which is not in the list;
; and which is contained within the bounds of the game
; THINK ABOUT IF IT IS IMPOSSIBLE
(define (new-fruit l) (make-posn 0 0))


; Posn, Posn -> Boolean
(define (posn-equal? p q)
  (and (= (posn-x p) (posn-x q)) (= (posn-y p) (posn-y q))))

(define (worm-head wg)
  (first (worm-game-worm wg)))


; List-of-length-at-least-1 -> List
(define (all-but-tail l)
  (cond [(empty? (rest l)) (list)]
        [else (cons (first l) (all-but-tail (rest l)))]))

(check-expect (all-but-tail (list 1 2 3)) (list 1 2))
(check-expect (all-but-tail (list 3 2 1)) (list 3 2))


(define (move-posn p dir)
  (cond
    [(string=? dir "left") (make-posn (- (posn-x p) 1) (posn-y p))]
    [(string=? dir "right") (make-posn (+ (posn-x p) 1) (posn-y p))]
    [(string=? dir "up") (make-posn  (posn-x p) (- (posn-y p) 1))]
    [(string=? dir "down") (make-posn  (posn-x p) (+ (posn-y p) 1))]))
    

; Worm, Direction -> Worm
; without changing the length, moves worm in the given direction
(define (move-worm w dir)
  (all-but-tail (cons (move-posn (first w) dir) w)))

(check-expect (move-worm worm1 "right") (list (make-posn 3 1) (make-posn 2 1) (make-posn 1 1) (make-posn 0 1)))
(check-expect (move-worm worm1 "up") (list (make-posn 2 0) (make-posn 2 1) (make-posn 1 1) (make-posn 0 1)))
(check-expect (move-worm worm1 "down") (list (make-posn 2 2) (make-posn 2 1) (make-posn 1 1) (make-posn 0 1)))


; Worm-game -> Worm-game
; if the head of the worm is the same as a fruit
; vs if it is not
; If it is not, then we put the head in the proper direction; and "lose" the tail;
;(define (tock wg)
  ;(if (posn-equal? (worm-head wg) (worm-game-food wg)) wg
 ;     (make-worm-game (move-worm (worm-game-worm wg) (worm-game-direction wg)) (worm-game-food wg) (worm-game-direction wg)))
      
      
(define LIST-LR (list LEFT RIGHT))
(define LIST-UD (list UP DOWN))
(define (parallel? dir1 dir2)
  (or 
      (and (member? dir1 LIST-LR) (member? dir2 LIST-LR))
      (and (member? dir1 LIST-UD) (member? dir2 LIST-UD))))


;; worm-game, direction -> worm-game
; changes the direction if they are not parallel
; No takebacks! if the direction has not been consummated, then don't change the direction
;
(define (change-direction wg dir)
  (if (or (parallel? (worm-game-direction wg) dir)
          (not (worm-game-moved wg)))
      wg
      (make-worm-game (worm-game-worm wg) (worm-game-food wg) dir #false)))
;
; worm-game, KeyEvent -> worm-game
(define (handle-key wg ke)
  (cond [(member? ke (list LEFT RIGHT UP DOWN)) (change-direction wg ke)]
        [else wg]))

; Exercise 217
;(define init-game (make-worm-game worm1 (make-posn 10 10) "right"))
;(require 2htdp/universe)
; (define play-game
;         (big-bang init-game
;           (on-tick tock (/ 1 3))
;           ;(stop-when out-of-bounds? render-with-end-text)
;           (on-key handle-key)
;           (to-draw render)))


; Worm-game, posn -> Worm
; prepends posn to the worm
(define (longer-worm wg)
  (cons (move-posn (first (worm-game-worm wg)) (worm-game-direction wg)) (worm-game-worm wg)))

; Worm -> Posn
; returns a random position
(define (new-food w)
  (make-posn (random BOARD-WIDTH) (random BOARD-HEIGHT)))

(define (tock wg)
  (if (posn-equal? (worm-head wg) (worm-game-food wg))
      ; ate the food; prepend to the snake
      (make-worm-game (longer-worm wg) (new-food (longer-worm wg)) (worm-game-direction wg) #true)
      (make-worm-game (move-worm (worm-game-worm wg) (worm-game-direction wg)) (worm-game-food wg) (worm-game-direction wg) #true)))


(define (struck? wg)
  (or (out-of-bounds? wg)
      (hit-self? wg)))

;; WOrm-Game -> Boolean
;; tells whether the position of the worm is out of bounds
(define (out-of-bounds? wg)
  (or (>= (posn-x (first (worm-game-worm wg))) BOARD-WIDTH)
      (< (posn-x (first (worm-game-worm wg))) 0)
      (>= (posn-y (first (worm-game-worm wg))) BOARD-HEIGHT)
      (< (posn-y (first (worm-game-worm wg))) 0)))

(define (hit-self? wg)
  (member? (first (worm-game-worm wg)) (rest (worm-game-worm wg))))

(define (render-with-end-text wg)
  (place-image/align (text "You lost!" 24 "red") 0 ACTUAL-HEIGHT  "left" "bottom" (render wg)))

(define init-game (make-worm-game worm1 (make-posn 10 10) "right" #false))
(require 2htdp/universe)
 (define play-game
         (big-bang init-game
           (on-tick tock (/ 1 4))
           (stop-when struck? render-with-end-text)
           (on-key handle-key)
           (to-draw render)))



;
;; WOrm-Game -> Boolean
;; tells whether the position of the worm is out of bounds
;(define (out-of-bounds? wg)
;  (or (>= (posn-x (worm-game-worm wg)) BOARD-WIDTH)
;      (< (posn-x (worm-game-worm wg)) 0)
;      (>= (posn-y (worm-game-worm wg)) BOARD-HEIGHT)
;      (< (posn-y (worm-game-worm wg)) 0)))
;
;(define init-posn (make-posn  (floor (/ BOARD-WIDTH 2)) (floor (/ BOARD-HEIGHT 2))))
;(define init-game (make-worm-game init-posn RIGHT))
;(require 2htdp/universe)
; (define play-game
;         (big-bang init-game
;           (on-tick tock (/ 1 3))
;           (stop-when out-of-bounds? render-with-end-text)
;           (on-key handle-key)
;           (to-draw render)))

           
; play-game