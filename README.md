# expression-trees-racket
Functions similar to those of binary trees are implemented to manipulate expression trees in Racket.

The idea behind the functions of expression trees and their behavior is particularly taken from the course offered by Hal Perkins at University of Washington.

## Expression trees

An expression tree is a tree-like structure with numbers at the leaves and arithmetic operator symbols at the interior nodes.

Each node in the tree can be represented by a three-element list as follows:

              (left-operand  operator  right-operand)
              
An example of an arithmetic expression would be (+ 1 (* 2 (- 3 5))).


A couple of assumptions made about expression trees are:

1. Operators in the tree are all binary (i.e., have two operands)
2. All of the leaves (operands) are simple integers
