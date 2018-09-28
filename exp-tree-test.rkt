(require rackunit "exp-tree.rkt")

# tests creating new expression nodes
(define test-make-expr
  (test-suite "make-expr"
    (test-case "test1"
      (check-equal? '(4 + 5) (make-expr 4 '+ 5)))
    (test-case "test2"
      (check-equal? '(1 / (3 / 2)) (make-expr 1 '/ '(3 / 2))))
    (test-case "test3"
      (check-equal? '((6 * 3) + (5 - 2)) (make-expr '(6 * 3) '+ '(5 - 2))))
    (test-case "test4"
      (check-equal? '(0 #<procedure:+> 1) (make-expr 0 + 1)))))
      
# tests pre-order, in-order, and post-order traversal functions
(define test-traversal
  (test-suite "traversal"
    (test-case "test5"
      (check-equal? '(+ 0 - 1 2) (preorder (make-expr 0 '+ '(1 - 2)))))
    (test-case "test6"
      (check-equal? '(/ - 14 2 + 0 * 2 3) (preorder (make-expr '(14 - 2) '/ (make-expr 0 '+ '(2 * 3))))))
    (test-case "test7"
      (check-equal? '(4 + 5 / 3 - 1) (inorder (make-expr '(4 + 5) '/ '(3 - 1)))))
    (test-case "test8"
      (check-equal? '(14 - 2 / 0 + 2 * 3) (inorder (make-expr '(14 - 2) '/ (make-expr 0 '+ '(2 * 3))))))
    (test-case "test9"
      (check-equal? '(14 2 - 0 2 3 * + /) (postorder (make-expr '(14 - 2) '/ (make-expr 0 '+ '(2 * 3))))))))

(run-tests test-make-expr)
(run-tests test-traversal)
