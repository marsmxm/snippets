;; #s
succeed

;; #u
fail

;; (run* (q)
;;   #u)
;; value: ()
;; since #u fails, and because the expression (run* (q) g ...)
;; has the value () if any goal in g . . . fails.
(run #f (q) 'fail)

;;(run* (q)
;;  (≡ #t q))
;; value: (#t)
;; because #t is associated with q if (≡ #t q) succeeds
(run #f (q) (== #t q))

;; (run* (q)
;;   #s
;;   (≡ #t q))
;; q is associated with #t
;; because the expression (run* (q) g ... (≡ #t q))
;; associates #t with q if the goals g . . . and
;; (≡ #t q) succeed

;; (run* (q)
;;   #s
;;   (≡ #t q))
;; value: (#t)

(run #f (q) 'succeed (== #t q))

;; (run* (r)
;;   #s
;;   (≡ corn r))
;; r is associated with corn
;; because r is associated with corn when (≡ corn r) succeeds

;; its value: (corn)
(run #f (r)
     #s
     (== 'corn r))


;; (run* (q)
;;   (fresh (x)
;;     (≡ #t x)
;;     (≡ #t q)))
;; value associated with q: #t
;; because ‘(fresh (x ...) g ...)’ binds fresh variables to x ...
;; and succeeds if the goals g ... succeed. (≡ v x) succeeds when x is fresh.
(run #f (q)
     (fresh (x)
	    (== #t x)
	    (== #t q)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The Law of Fresh
;; If x is fresh, then (≡ v x) succeeds and associates x with v.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





