;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-12-5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define BOARD-WIDTH 40) ;THE NUMBER OF CELLS WIDE
(define BOARD-HEIGHT 30)
(define WORM-DIAMETER 10)
(define WORM-SPEED 1) ;the number of cells the worm proceeds, per clock ticket
(define WORM (circle (/ WORM-DIAMETER 2) "solid" "red"))
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

; A WORM IS A POSN (make-posn x y) WHERE 0<=x<BOARD-WIDTH
; AND 0<=y<=BOARD-HEIGHT
; Interpretation; the x-th cell to the right and the y-th cell down, both 0-indexed

; A DIRECTION is a string "left" "right" "up" or "down"
(define-struct worm-game [worm direction])
; A worm-game IS A STRUCT [worm direction]
(define (render wg)
  (place-image/align WORM (* (posn-x (worm-game-worm wg)) WORM-DIAMETER) (* (posn-y (worm-game-worm wg)) WORM-DIAMETER) "left" "top" MT))

(define posn1 (make-posn 10 5))

;(render (make-worm-game posn1 "left"))

(define (move-left wg)
  (make-worm-game (make-posn (- (posn-x (worm-game-worm wg)) 1) (posn-y (worm-game-worm wg))) (worm-game-direction wg)))
(define (move-right wg)
  (make-worm-game (make-posn (+ (posn-x (worm-game-worm wg)) 1) (posn-y (worm-game-worm wg))) (worm-game-direction wg)))
(define (move-up wg)
  (make-worm-game (make-posn (posn-x (worm-game-worm wg)) (- (posn-y (worm-game-worm wg)) 1)) (worm-game-direction wg)))
(define (move-down wg)
  (make-worm-game (make-posn (posn-x (worm-game-worm wg)) (+ (posn-y (worm-game-worm wg)) 1)) (worm-game-direction wg)))
; worm-game -> worm-game
(define (tock wg)
  (cond [(string=? (worm-game-direction wg) LEFT) (move-left wg)]
        [(string=? (worm-game-direction wg) RIGHT) (move-right wg)]
        [(string=? (worm-game-direction wg) UP) (move-up wg)]
        [(string=? (worm-game-direction wg) DOWN) (move-down wg)]))

; worm-game, direction -> worm-game
(define (change-direction wg dir)
  (make-worm-game (worm-game-worm wg) dir))

; worm-game, KeyEvent -> worm-game
(define (handle-key wg ke)
  (cond [(member? ke (list LEFT RIGHT UP DOWN)) (change-direction wg ke)]
        [else wg]))



; Exercise 216;
(define (render-with-end-text wg)
  (place-image/align (text "You lost!" 24 "red") 0 ACTUAL-HEIGHT  "left" "bottom" (render wg)))

; WOrm-Game -> Boolean
; tells whether the position of the worm is out of bounds
(define (out-of-bounds? wg)
  (or (>= (posn-x (worm-game-worm wg)) BOARD-WIDTH)
      (< (posn-x (worm-game-worm wg)) 0)
      (>= (posn-y (worm-game-worm wg)) BOARD-HEIGHT)
      (< (posn-y (worm-game-worm wg)) 0)))

(define init-posn (make-posn  (floor (/ BOARD-WIDTH 2)) (floor (/ BOARD-HEIGHT 2))))
(define init-game (make-worm-game init-posn RIGHT))
(require 2htdp/universe)
; (define play-game
;         (big-bang init-game
;           (on-tick tock (/ 1 3))
;           (stop-when out-of-bounds? render-with-end-text)
;           (on-key handle-key)
;           (to-draw render)))

           
; play-game