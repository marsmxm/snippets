#lang s-exp framework/keybinding-lang

(keybinding "c:[" (λ (editor evt) (send editor insert "Π")))
(keybinding "c:]" (λ (editor evt) (send editor insert "Σ")))
