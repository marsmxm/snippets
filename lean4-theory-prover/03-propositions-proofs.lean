variable (p q : Prop)

#check p → q → p ∧ q


example (hp : p) (hq : q) : p ∧ q := And.intro hp hq
#check fun (hp : p) (hq : q) => And.intro hp hq

example (h : p ∧ q) : p := And.left h
example (h : p ∧ q) : q := And.right h

variable (hp : p) (hq : q)
#check (⟨hp, hq⟩ : p ∧ q)

example (hp : p) : p ∨ q := Or.intro_left q hp
example (hq : q) : p ∨ q := Or.intro_right p hq


example (h : p ∧ q) : q ∧ p :=
  And.intro (And.right h) (And.left h)


example (h : p ∨ q) : q ∨ p :=
  Or.elim h
    (fun hp : p =>
      Or.intro_right q hp)
    (fun hq : q =>
      show q ∨ p from Or.intro_left p hq)

example (hpq : p → q) (hnq : ¬q) : ¬p :=
  fun hp : p => hnq (hpq hp)

example (hp : p) (hnp : ¬p) : q := absurd hp hnp

#check True.intro

theorem and_swap : p ∧ q ↔ q ∧ p :=
  Iff.intro
    (fun h : p ∧ q =>
     show q ∧ p from And.intro (And.right h) (And.left h))
    (fun h : q ∧ p =>
     show p ∧ q from And.intro (And.right h) (And.left h))

#check and_swap p q    -- p ∧ q ↔ q ∧ p

variable (h : p ∧ q)
example : q ∧ p := Iff.mp (and_swap p q) h
