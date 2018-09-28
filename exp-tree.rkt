;; creates new expression tree nodes and extract components of the tree
(define (make-expr left-op operator right-op)
  (list left-op operator right-op))

(define (operator expr)
  (cadr expr))

(define (left-op expr)
  (car expr))

(define (right-op expr)
  (caddr expr))
  
;; traverses expression trees using inorder, preorder, and postorder traversals and 
;; returns a list of the items encountered during the traversal in the order encountered
(define (preorder expr)
  (flatten (preorder2 expr)))

(define (inorder expr)
  (flatten (inorder2 expr)))

(define (postorder expr)
  (flatten (postorder2 expr)))

;; helper method to make a list simple
(define (flatten lst)
  (cond [(empty? lst) null]
        [(not (list? lst)) (list lst)]
        [else (append (flatten (first lst)) (flatten (rest lst)))]))

;; helper method for tree traversal
(define (preorder2 expr)
 (cond ((pair? expr) 
     (list (operator expr) (preorder2 (left-op expr)) (preorder2 (right-op expr))))
    (#t expr)))

(define (inorder2 expr)
  (cond ((pair? expr)
         (list (inorder2 (left-op expr)) (operator expr) (inorder2 (right-op expr))))
    (#t expr)))

(define (postorder2 expr)
  (cond ((pair? expr)
         (list (postorder2 (left-op expr)) (postorder2 (right-op expr)) (operator expr)))
    (#t expr)))
    
;; evaluates an expression tree by traversing it and returning the value that it represents
(define (eval-tree expr-tree)
(cond
  ((pair? expr-tree)
    (cond
      ((eq? (operator expr-tree) '+)
       (+ (eval-tree (left-op expr-tree)) (eval-tree (right-op expr-tree))))
      ((eq? (operator expr-tree) '-)
       (- (eval-tree (left-op expr-tree)) (eval-tree (right-op expr-tree))))
      ((eq? (operator expr-tree) '*)
       (* (eval-tree (left-op expr-tree)) (eval-tree (right-op expr-tree))))
      ((eq? (operator expr-tree) '/)
       (/ (eval-tree (left-op expr-tree)) (eval-tree (right-op expr-tree))))))
  (#t expr-tree)))

;; returns a copy of the given expression tree with its leaf nodes replaced by
;; the result of applying the high order function to the value of the leaf nodes
;; e.g., each node v is replaced by (f v)

(define (map-leaves f expr-tree)
  (cond
    ((pair? expr-tree) (list (map-leaves f (left-op expr-tree))
                             (operator expr-tree)
                             (map-leaves f (right-op expr-tree))))
    (#t (f expr-tree))))
