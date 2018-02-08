;; 5.3
(controller
 test-good
 (test (op good-enought?) (reg guess))
 (branch (label sqrt-done))
 (assign guess (op improve) (reg guess))
 (goto (label test-good))
 sqrt-done)

