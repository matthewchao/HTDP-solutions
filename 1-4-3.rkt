;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-4-3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 50

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; Exercise 51 (traffic light)
; Graphical Constants
(define LIGHT-RADIUS 50)
(define TIME-TO-CHANGE 2) ;the number of seconds between light changes
(define initial-state "green")

; A WorldState is one of three colors, red, green or yellow
; WorldState -> WorldState
; DON'T NEED TO MAKE ANOTHER TOCK since we have traffic-light-next
  

(require 2htdp/image)
(require 2htdp/universe)
; WorldState -> Image
(define (render ws)
  (circle LIGHT-RADIUS "solid" ws))

; Starts world;
(define (main ws)
  (big-bang ws
    (on-tick traffic-light-next TIME-TO-CHANGE)
    (to-draw render)))


(main initial-state)