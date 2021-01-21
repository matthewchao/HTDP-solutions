;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 14-3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A [List-of ITEM] is one of: 
; – '() 
; – (cons ITEM [List-of ITEM])


; A List-of-numbers-again is one of: 
; – '() 
; – (cons Number List-of-numbers-again)

(define-struct point [hori veri])


; A Pair-boolean-string is a structure:
;   (make-point Boolean String)
 
; A Pair-number-image is a structure:
;   (make-point Number Image)

; A [CP H V] is a structure: 
;   (make-point H V)

; Exercise 239
; A [List X Y] is a structure: 
;   (cons X (cons Y '()))
; A Pair-of-Number is a structure:
; [List Number Number]
; A Pair-of-Number-and-1Str is a structure:
; [List Number 1str]
; A pair-of-string-and-boolean is a structure
; [List String BOolean]


; Exercise 240
; An LStr is one of: 
; – String
; – (make-layer LStr)
    
; An LNum is one of: 
; – Number
; – (make-layer LNum)
(define-struct layer [stuff])


(define ex-lstr (make-layer "I'm a layerstring"))
(define ex-lnum (make-layer 5))

;(layer-stuff ex-lstr)
;(layer-stuff ex-lnum)


; Exercise 241
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

; A [NEList-of ITEM] is one of
; '()
; (cons ITEM [NEList-of ITEM]

; A NEList-of-temperatures is a structure:
; [NEList-of CTemperature


; Exercise 242
; A [Maybe X] is one of: 
; – #false 
; – X

; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of los starting with s 
; #false otherwise 
(check-expect (occurs "a" (list "b" "a" "d" "e"))
              (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #f)
(define (occurs s los)
  (cond [(empty? los) #false]
        [(string=? s (first los)) (rest los)]
        [else (occurs s (rest los))]))