;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-12-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; On OS X: 
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend

(require 2htdp/batch-io)
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  ;(explode "abc"))
  (explode "abcdefghijklmnopqrstuvwxyz"))


; 1str, Dictionary -> Number
; Counts the number of words in dictionary starting with letter
(define (starts-with# letter dictionary)
  (cond [(empty? dictionary) 0]
        [else (+ (if (starts-with letter (first dictionary)) 1 0) (starts-with# letter (rest dictionary)))]))

; 1str, nonempty string -> Boolean
(define (starts-with letter word)
  (string=? letter (string-ith word 0)))

;(starts-with# "e" AS-LIST)
;(starts-with# "z" AS-LIST)



; Exericse 196

; A Letter-Count is a [1str,Number]
; a letter and a count of words starting with that letter
(define-struct letter-count [letter count])

; List-of-letters, Dictionary -> List-of-Letter-Counts
(define (count-by-letter lol dictionary)
  (cond [(empty? lol) (list)]
        [else (cons (make-letter-count (first lol) (starts-with# (first lol) dictionary)) (count-by-letter (rest lol) dictionary))]))

; (count-by-letter LETTERS AS-LIST)



; Exercise 197 
; Dictionary -> Letter-Count
(define (most-frequent dictionary)
  (best-letter-count (count-by-letter LETTERS dictionary)))

; Nonempty List-of-Letter-Counts -> Letter-Count
; Replace the first of the rest with EITHER the first one, or the second one;
(define (best-letter-count lolc)
  (cond [(empty? (rest lolc)) (first lolc)]
        [(<= (letter-count-count (first lolc)) (letter-count-count (second lolc))) (best-letter-count (rest lolc))]
        [else (best-letter-count (cons (first lolc) (rest (rest lolc))))]))
  

; (most-frequent AS-LIST)
