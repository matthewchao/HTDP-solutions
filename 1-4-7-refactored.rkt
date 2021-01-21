;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-4-7-refactored) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; A current state falls into one of three categories 
; "green"
; "yellow"
; "red"
; interpretation the colors of a traffic light 

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs)
  (cond [(string=? cs "green") "yellow"]
        [(string=? cs "yellow") "red"]
        [else "green"]))


(require 2htdp/image)
(define background-height 30)
(define background-width 90)
(define background (empty-scene background-width background-height))
(define light-radius (/ background-width 6))

; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (place-image (3-lights current-state)
               (/ background-width 2)
               (/ background-height 2)
               background))

; TrafficLight, Color -> Image
; returns a colored light which is either on or off,
; depending on whether the color of the light matches the current state
(define (colored-light color-name cs)
  (circle light-radius
          (if (string=? cs color-name) "solid" "outline")
          color-name))

; TrafficLight -> Image
; returns the set of 3 colored lights corresponding to the current state
(define (3-lights cs)
  (beside (colored-light "red" cs)
          (colored-light "yellow" cs)
          (colored-light "green" cs)))


(require 2htdp/universe)
; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation "green")