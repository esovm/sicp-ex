#|

Exercise 3.14: The following procedure is quite useful,
although obscure:

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

"loop" uses the "temporary" variable "temp" to hold the old
value of the "cdr" of "x", since the "set-cdr!" on the next
line destroys the "cdr". Explain what "mystery" does in
general. Suppose "v" is defined by "(define v (list 'a 'b 'c
'd))". Draw the box-and-pointer diagram that represents the
list to which "v" is bound. Suppose that we now evaluate
"(define w (mystery v))". Draw box-and-pointer diagrams that
show the structures "v" and "w" after evaluating this
expression. What would be printed as the values of "v" and
"w"?

|#

#| Code from book |#
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

#| Answer 

Destructively reverses the list and returns a reference to the first element in
the reversed list.

(define v '(a b c d))

[a][-]> [b][-]> [c][-]> [d][\]
 ^
 v

(define w (mystery v))

[d][-]> [c][-]> [b][-]> [a][-]
 ^                       ^
 w                       v

|#