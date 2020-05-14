;; 5.2 factorial
(contoller
 (assign (reg product) (const 1))
 (assign (reg counter) (const 1))
 test-c
 (test (op >) (reg counter) (reg n))
 (branch (label fact-done))
 (assign (reg product) (op *) (reg product) (reg counter))
 (assign (reg counter) (op +) (reg counter) (const 1))
 (goto (label test-c))
 fact-done)

;; 5.3
(controller
 test-good
 (test (op good-enought?) (reg guess))
 (branch (label sqrt-done))
 (assign guess (op improve) (reg guess))
 (goto (label test-good))
 sqrt-done)

