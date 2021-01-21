;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-8-3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name




; A List-of-names is one of: 
; – '()
; – (cons Bool List-of-names)
; interpretation a list of invitees, by last name


; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(define (contains-flatt? a-list-of-names)
  (cond [(empty? a-list-of-names) #false]
        [(string=? (first a-list-of-names) "Flatt") #true]
        [else (contains-flatt? (rest a-list-of-names))]))
        

(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '())))))))) #true)


(define MT "MT")
(define-struct my-list (first rest))

(define (my-list-check? l)
  (or (and (string? l) (string=? l MT))
      (and (my-list? l) (my-list-check? (my-list-rest l)))))

(define (my-list-cons x1 l2)
  (cond [(my-list-check? l2) (make-my-list x1 l2)]
        [else (error "expects two lists")]))

(check-expect (my-list-check? MT) #true)
(define exlist1 MT)
(define exlist2 (my-list-cons 5 exlist1))
(define exlist3 (my-list-cons "hi" exlist2))
(check-expect (my-list-check? exlist1) #true)
(check-expect (my-list-check? exlist2) #true)
(check-expect (my-list-check? exlist3) #true)
(check-expect (my-list-check? (my-list-cons "hi" MT)) #true)
;(check-expect (my-list-check? (my-list-cons "hi" "there")) (error "expects two lists"))




; String List-of-names -> Boolean
; determines whether name belongs to a-list-of-names
(define (contains? name a-list-of-names)
  (cond [(empty? a-list-of-names) #false]
        [(string=? (first a-list-of-names) name) #true] ;note how we will never call string=? on '() since the first branch of cond takes care of that possibility
        [else (contains? name (rest a-list-of-names))]))
        

(check-expect (contains? "Flatt" '()) #false)
(check-expect (contains? "Flatt" (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '())))))))) #true)

(check-expect (contains? "Hi" (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '())))))))) #false)




