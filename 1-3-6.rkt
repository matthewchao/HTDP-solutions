;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-3-6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH-OF-WORLD 500)
(define HEIGHT-OF-WORLD 100)
 
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

;Graphical Constants

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle (* 3 WHEEL-RADIUS) WHEEL-RADIUS "outline" "transparent"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

BOTH-WHEELS


(define CHASSIS
  (rectangle (+ (image-width BOTH-WHEELS) (* 2 WHEEL-RADIUS)) (* 4 WHEEL-RADIUS) "solid" "red"))
CHASSIS
(define CAR
  (overlay/offset BOTH-WHEELS 0 (- (* 2 WHEEL-RADIUS)) CHASSIS))
CAR
(define BACKGROUND
  (rectangle WIDTH-OF-WORLD HEIGHT-OF-WORLD "outline" "black"))

;(define Y-CAR (- HEIGHT-OF-WORLD))
(define Y-CAR (- HEIGHT-OF-WORLD (* 0.5 (image-height CAR))))


(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))







; Functions 
; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car


; render
; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (place-image CAR x Y-CAR
               (place-image tree
                            (* 0.5 WIDTH-OF-WORLD)
                            (- HEIGHT-OF-WORLD (* 0.5 (image-height tree)))
                            BACKGROUND)))

;tree

; clock-tick-handler
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)
  (+ x 3))

; keystroke-handler
; mouse-event-handler
; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
; doesn't really "need" the x-position-of-car
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond [(string=? "button-down" me) x-mouse]
        [else x-position-of-car]))

; end? should return true if the car is at the edge of the background
(define (end? x)
  (>= (+ x (* 0.5 (image-width CAR))) WIDTH-OF-WORLD))
(check-expect (end? WIDTH-OF-WORLD) true)









; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [on-mouse hyper]
     [stop-when end?]))


(main 0)