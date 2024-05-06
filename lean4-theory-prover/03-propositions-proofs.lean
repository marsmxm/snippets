variable (p q : Prop)

#check p → q → p ∧ q
#check False


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

#check and_swap p q     -- p ∧ q ↔ q ∧ p

variable (h : p ∧ q)
example : q ∧ p := Iff.mp (and_swap p q) h


/- Exercises -/
variable (p q r : Prop)

-- commutativity of ∧ and ∨
example : p ∧ q ↔ q ∧ p :=
  Iff.intro
    (fun (h : p ∧ q) => ⟨h.right, h.left⟩)
    (fun (h : q ∧ p) => ⟨h.right, h.left⟩)

example : p ∨ q ↔ q ∨ p :=
  Iff.intro
    (fun (h : p ∨ q) => h.elim
      (fun (hp : p) => Or.inr hp)
      (fun (hq : q) => Or.inl hq))
    (fun (h : q ∨ p) => h.elim
      (fun (hq : q) => Or.inr hq)
      (fun (hp : p) => Or.inl hp))

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) :=
  Iff.intro
    (fun (h : (p ∧ q) ∧ r) => ⟨h.left.left, ⟨h.left.right, h.right⟩⟩)
    (fun (h : p ∧ (q ∧ r)) => ⟨⟨h.left, h.right.left⟩, h.right.right⟩)

example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) :=
  Iff.intro
    (fun (h : (p ∨ q) ∨ r) => h.elim
      (fun (hpq : p ∨ q) => hpq.elim
        (fun (hp : p) => Or.inl hp)
        (fun (hq : q) => Or.inr (Or.inl hq)))
      (fun (hr : r) => Or.inr (Or.inr hr)))
    (fun (h : p ∨ (q ∨ r)) => h.elim
      (fun (hp : p) => Or.inl (Or.inl hp))
      (fun (hqr : q ∨ r) => hqr.elim
        (fun (hq : q) => Or.inl (Or.inr hq))
        (fun (hr : r) => Or.inr hr)))

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
  Iff.intro
    (fun (h : p ∧ (q ∨ r)) => Or.elim h.right
      (fun (hq : q) => Or.inl ⟨h.left, hq⟩)
      (fun (hr : r) => Or.inr ⟨h.left, hr⟩))
    (fun (h : (p ∧ q) ∨ (p ∧ r)) => h.elim
      (fun (hpq : p ∧ q) =>
        show p ∧ (q ∨ r) from ⟨hpq.left, Or.inl hpq.right⟩)
      (fun (hpr : p ∧ r) =>
        show p ∧ (q ∨ r) from ⟨hpr.left, Or.inr hpr.right⟩))

example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) :=
  Iff.intro
    (fun (h : p ∨ (q ∧ r)) => h.elim
      (fun (hp : p) => ⟨Or.inl hp, Or.inl hp⟩)
      (fun (hqr : q ∧ r) => ⟨Or.inr hqr.left, Or.inr hqr.right⟩))
    (fun (h : (p ∨ q) ∧ (p ∨ r)) => Or.elim h.left
      (fun (hp : p) => Or.inl hp)
      (fun (hq : q) => Or.elim h.right
        (fun (hp : p) => Or.inl hp)
        (fun (hr : r) => Or.inr ⟨hq, hr⟩)))

-- other properties
example : (p → (q → r)) ↔ (p ∧ q → r) :=
  Iff.intro
    (fun (h : p → (q → r)) =>
      (fun (hpq : p ∧ q) => h hpq.left hpq.right))
    (fun (h : p ∧ q → r) =>
      (fun (hp : p) =>
        (fun (hq : q) => h ⟨hp, hq⟩)))

example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) :=
  Iff.intro
    (fun (h : (p ∨ q) → r) =>
      have hpr : p → r := fun (hp : p) => h (Or.inl hp)
      have hqr : q → r := fun (hq : q) => h (Or.inr hq)
      ⟨hpr, hqr⟩)
    (fun (h : (p → r) ∧ (q → r)) =>
      (fun (hpq : p ∨ q) => Or.elim hpq
        (fun (hp : p) => h.left hp)
        (fun (hq : q) => h.right hq)))


example : ¬(p ∨ q) ↔ ¬p ∧ ¬q :=
  Iff.intro
    (fun (h : ¬(p ∨ q)) =>
      have np : ¬p := fun (hp : p) => h (Or.inl hp)
      have nq : ¬q := fun (hq : q) => h (Or.inr hq)
      ⟨np, nq⟩)
    (fun (h : ¬p ∧ ¬q) =>
      fun (hpq : p ∨ q) => hpq.elim
        h.left
        h.right)

example : ¬p ∨ ¬q → ¬(p ∧ q) := fun (h : ¬p ∨ ¬q) =>
  Or.elim h
    (fun (np : ¬p) =>
      (fun (hpq : p ∧ q) => absurd hpq.left np))
    (fun (nq : ¬q) =>
      (fun (hpq : p ∧ q) => absurd hpq.right nq))

example : ¬(p ∧ ¬p) := fun (h : p ∧ ¬p) => absurd h.left h.right

example : p ∧ ¬q → ¬(p → q) :=
  fun (h : p ∧ ¬q) =>
    fun (hpq : p → q) =>
      absurd (hpq h.left) h.right

example : ¬p → (p → q) :=
  fun (np : ¬p) =>
    fun (hp: p) =>
      absurd hp np

example : (¬p ∨ q) → (p → q) :=
  fun (h : ¬p ∨ q) =>
    fun (hp : p) =>
      h.elim
        (fun (np : ¬p) => absurd hp np)
        (fun (hq : q) => hq)

example : p ∨ False ↔ p :=
  Iff.intro
    (fun (h : p ∨ False) => h.elim
      (fun (hp : p) => hp)
      (fun (n : False) => False.elim n))
    (fun (hp : p) => Or.inl hp)

example : p ∧ False ↔ False :=
  Iff.intro
    (fun (h : p ∧ False) => h.right)
    (fun (h : False) => h.elim)

theorem thm1 : (p → q) → (¬q → ¬p) :=
  fun (h : p → q) =>
    fun (hnq : ¬q) =>
      fun (hp : p) =>
        absurd (h hp) hnq


example : ¬(p ↔ ¬p) :=
  fun (h : p ↔ ¬p) =>
    have hppn : p → p → False := h.mp
    have hpnp : (p → False) → p := h.mpr
    sorry


open Classical

variable (p q r : Prop)

#check em p

theorem dnel {p : Prop} (hp : p) : ¬¬p :=
  fun (hnp : ¬p) => absurd hp hnp

theorem dner {p : Prop} (h : ¬¬p) : p :=
  Or.elim (em p)
    (fun hp : p => hp)
    (fun hnp : ¬p => absurd hnp h)

example : (p → q ∨ r) → ((p → q) ∨ (p → r)) :=
  fun (h : p → q ∨ r) => Or.elim (em p)
    (fun (hp : p) => Or.elim (h hp)
      (fun (hq : q) => Or.inl (fun (_ : p) => hq))
      (fun (hr : r) => Or.inr (fun (_ : p) => hr)))
    (fun (hnp : ¬p) => Or.inl (fun (hp : p) => absurd hp hnp))

example : ¬(p ∧ q) → ¬p ∨ ¬q :=
  fun (h : p ∧ q → False) => Or.elim (em p)
    (fun (hp : p) => Or.elim (em q)
      (fun (hq : q) => absurd ⟨hp, hq⟩ h)
      (fun (hnq : ¬q) => Or.inr hnq))
    (fun (hnp : ¬p) => Or.inl hnp)

example : ¬(p → q) → p ∧ ¬q :=
  fun (h : ¬(p → q)) => Or.elim (em p)
    (fun (hp : p) => Or.elim (em q)
      (fun (hq : q) => absurd (fun (_ : p) => hq) h)
      (fun (hnq : ¬q) => ⟨hp, hnq⟩))
    (fun (hnp : ¬p) =>
      have t0 : (¬¬p → ¬¬q) → p → q :=
          fun (t0h : ¬¬p → ¬¬q) =>
            fun (t0hp : p) => dner (t0h (dnel t0hp))
      have t1 : ¬(¬¬p → ¬¬q) := fun (t1h : ¬¬p → ¬¬q) => absurd (t0 t1h) h
      absurd (thm1 (¬q) (¬p) (fun (_ : ¬q) => hnp)) t1)

example : (p → q) → (¬p ∨ q) :=
  fun (h : p → q) => show ¬p ∨ q from Or.elim (em p)
    (fun (hp : p) => Or.inr (h hp))
    (fun (hnp : ¬p) => Or.inl hnp)

example : (¬q → ¬p) → (p → q) :=
  fun (h : ¬q → ¬p) =>
    have t0 : (¬¬p → ¬¬q) → p → q :=
          fun (t0h : ¬¬p → ¬¬q) =>
            fun (t0hp : p) => dner (t0h (dnel t0hp))
    have t1 : ¬¬p → ¬¬q := thm1 (¬q) (¬p) h
    t0 t1

example : p ∨ ¬p := Or.elim (em p)
  (fun (hp : p) => Or.inl hp)
  (fun (hnp : ¬p) => Or.inr hnp)

example : ((p → q) → p) → p :=
  fun (h₀ : (p → q) → p) => Or.elim (em p)
    (fun (hp : p) => hp)
    (fun (hnp : ¬p) =>
      have l₀ : p → q := fun (hp : p) => absurd hp hnp
      have l₁ : ((p → q) → p) → False :=
        fun (h₁ : (p → q) → p) => absurd (h₁ l₀) hnp
      absurd h₀ l₁)
