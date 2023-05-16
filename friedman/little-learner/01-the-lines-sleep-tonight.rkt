#lang racket
(require malt)

(define line
  (λ (x)
    (λ (w b)
      (+ (* w x) b))))
