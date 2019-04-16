#|

Exercise 4.38: Modify the multiple-dwelling procedure to
omit the requirement that Smith and Fletcher do not live on
adjacent floors. How many solutions are there to this
modified puzzle?

|#

(load-ex "4.37")

#| Code from book |#

(define setup-environment-437 setup-environment)
(define (setup-environment)
  (let ([env (setup-environment-437)])
    (define (add exp) (ambeval exp 
                               env 
                               (lambda (value next) (void))
                               (lambda () (error "setup-environment" "fail!"))))
    ;;; code from book
    (add '(define (distinct? items)
            (cond [(null? items) true]
                  [(null? (cdr items)) true]
                  [(member (car items) (cdr items)) false]
                  [else (distinct? (cdr items))])))
    env))

#| Answer

Omitting that requirement goes from 1 to 5 possibilities.

|#

#| Tests |#

;;; original
(define-test (eval-all 
  '((lambda ()
      (let ([baker (amb 1 2 3 4 5)]
            [cooper (amb 1 2 3 4 5)]
            [fletcher (amb 1 2 3 4 5)]
            [miller (amb 1 2 3 4 5)]
            [smith (amb 1 2 3 4 5)])
        (require (distinct? (list baker cooper fletcher miller smith)))
        (require (not (= baker 5)))
        (require (not (= cooper 1)))
        (require (not (= fletcher 5)))
        (require (not (= fletcher 1)))
        (require (> miller cooper))
        (require (not (= (abs (- smith fletcher)) 1)))
        (require (not (= (abs (- fletcher cooper)) 1)))
        (list (list 'baker baker)
              (list 'cooper cooper)
              (list 'fletcher fletcher)
              (list 'miller miller)
              (list 'smith smith))))))
  '(((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))))

;;; modified
(define-test (eval-all 
  '((lambda ()
      (let ([baker (amb 1 2 3 4 5)]
            [cooper (amb 1 2 3 4 5)]
            [fletcher (amb 1 2 3 4 5)]
            [miller (amb 1 2 3 4 5)]
            [smith (amb 1 2 3 4 5)])
        (require (distinct? (list baker cooper fletcher miller smith)))
        (require (not (= baker 5)))
        (require (not (= cooper 1)))
        (require (not (= fletcher 5)))
        (require (not (= fletcher 1)))
        (require (> miller cooper))
        ; (require (not (= (abs (- smith fletcher)) 1)))
        (require (not (= (abs (- fletcher cooper)) 1)))
        (list (list 'baker baker)
              (list 'cooper cooper)
              (list 'fletcher fletcher)
              (list 'miller miller)
              (list 'smith smith))))))
  '(((baker 1) (cooper 2) (fletcher 4) (miller 3) (smith 5))
    ((baker 1) (cooper 2) (fletcher 4) (miller 5) (smith 3))
    ((baker 1) (cooper 4) (fletcher 2) (miller 5) (smith 3))
    ((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
    ((baker 3) (cooper 4) (fletcher 2) (miller 5) (smith 1))))
 