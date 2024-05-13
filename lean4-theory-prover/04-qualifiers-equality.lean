/- The Universal Quantifier -/

/- Given a proof of p x, in a context where x : α is arbitrary,
we obtain a proof ∀ x : α, p x. -/

/- Given a proof ∀ x : α, p x and any term t : α, we obtain a proof of p t. -/

variable (g : Nat → Nat → Nat)
variable (hg : g 0 0 = 0)

theorem gex1 : ∃ x, g x x = x := ⟨0, hg⟩
theorem gex2 : ∃ x, g x 0 = x := ⟨0, hg⟩
theorem gex3 : ∃ x, g 0 0 = x := ⟨0, hg⟩
theorem gex4 : ∃ x, g x x = 0 := ⟨0, hg⟩

set_option pp.explicit true  -- display implicit arguments
#print gex1
#print gex2
#print gex3
#print gex4


def is_even (a : Nat) := ∃ b, a = 2 * b

theorem even_plus_even (h1 : is_even a) (h2 : is_even b) : is_even (a + b) :=
  Exists.elim h1 (fun w1 (hw1 : a = 2 * w1) =>
  Exists.elim h2 (fun w2 (hw2 : b = 2 * w2) =>
    Exists.intro (w1 + w2)
      (calc a + b
        _ = 2 * w1 + 2 * w2 := by rw [hw1, hw2]
        _ = 2 * (w1 + w2)   := by rw [Nat.mul_add])))

#check even_plus_even

open Classical
variable (p : α → Prop)

example (h : ¬ ∀ x, ¬ p x) : ∃ x, p x :=
  byContradiction
    (fun h1 : ¬ ∃ x, p x =>
      have h2 : ∀ x, ¬ p x :=
        fun x =>
        fun h3 : p x =>
        have h4 : ∃ x, p x := ⟨x, h3⟩
        show False from h1 h4
      show False from h h2)

/- ∃ examples -/
variable (α : Type) (p q : α → Prop)
variable (r : Prop)
variable (a : α)

example : (∃ x : α, r) → r :=
  fun (h : (∃ x : α, r)) =>
    match h with
    | ⟨_, hw⟩ => hw

example (a : α) : r → (∃ x : α, r) :=
  fun (r) => ⟨a, r⟩

example : (∃ x, p x ∧ r) ↔ (∃ x, p x) ∧ r := Iff.intro
  (fun (h : ∃ x, p x ∧ r) =>
    match h with
    | ⟨w, hpw, r⟩ => And.intro (Exists.intro w hpw) r)
  (fun (h : (∃ x, p x) ∧ r) =>
    match h.left with
    | ⟨w, hpw⟩ => Exists.intro w (And.intro hpw h.right))


example : (∃ x, p x ∨ q x) ↔ (∃ x, p x) ∨ (∃ x, q x) := Iff.intro
  (fun (h : ∃ x, p x ∨ q x) =>
    match h with
    | ⟨w, hpqw⟩ => Or.elim hpqw
      (fun (hpw : p w) =>
      Or.inl ⟨w, hpw⟩)
      (fun (hqw : q w) =>
      Or.inr ⟨w, hqw⟩))
  (fun (h : (∃ x, p x) ∨ (∃ x, q x)) =>
    Or.elim h
    (fun (hpx : ∃ x, p x) =>
      match hpx with
      | ⟨w, hpw⟩ => ⟨w, Or.inl hpw⟩)
    (fun (hqx : ∃ x, q x) =>
      match hqx with
      | ⟨w, hqw⟩ => ⟨w, Or.inr hqw⟩))

theorem thm1 : (∀ x, p x) ↔ ¬ (∃ x, ¬ p x) :=
  Iff.intro
    (fun (h : ∀ x, p x) =>
     fun (h1 : ∃ x, ¬ p x) =>
        match h1 with
        | ⟨a, hnpa⟩ => absurd (h a) hnpa)
    (fun (h : ¬ (∃ x, ¬ p x)) =>
     fun (x : α) =>
      byContradiction
        (fun (hnpx : ¬ p x) => absurd ⟨x, hnpx⟩ h))

theorem thm2 : (¬ ∃ x, p x) ↔ (∀ x, ¬ p x) :=
  Iff.intro
    (fun (h : ¬ ∃ x, p x) =>
      fun (x : α) =>
        fun (hp : p x) =>
          absurd ⟨x, hp⟩ h)
    (fun (h : ∀ x, ¬ p x) =>
      byCases
        (fun (hep : ∃ x, p x) =>
          let ⟨a, (hpa : p a)⟩ := hep
          absurd hpa (h a))
        (fun (hnep : ¬ ∃ x, p x) => hnep))

example : (∃ x, p x) ↔ ¬ (∀ x, ¬ p x) :=
  Iff.intro
    (fun ⟨a, (hpa : p a)⟩ =>
      fun (h : ∀ x, ¬ p x) => absurd hpa (h a))
    (fun (h : ¬ (∀ x, ¬ p x)) =>
      byContradiction
        (fun (hnep : ¬ (∃ x, p x)) =>
          have hanp : ∀ x, ¬ p x := (thm2 α p).mp hnep
          absurd hanp h))

example : (¬ ∀ x, p x) ↔ (∃ x, ¬ p x) :=
  Iff.intro
    (fun (h : ¬ ∀ x, p x) =>
      byContradiction
        (fun (h1 : ¬ ∃ x, ¬ p x) =>
          have h2 : ∀ x, p x := (thm1 α p).mpr h1
          h h2))
    (fun (h : ∃ x, ¬ p x) =>
      fun (hap : ∀ x, p x) =>
        let ⟨a, (hnp : ¬ p a)⟩ := h
        absurd (hap a) hnp)

example : (∀ x, p x → r) ↔ (∃ x, p x) → r :=
  Iff.intro
    (fun (h : ∀ x, p x → r) =>
      fun (h1 : ∃ x, p x) =>
        let ⟨a, (hep : p a)⟩ := h1
        (h a) hep)
    (fun (h : (∃ x, p x) → r) =>
      fun x =>
        fun h1 : p x =>
          h ⟨x, h1⟩)

example (a : α) : (∃ x, p x → r) ↔ (∀ x, p x) → r :=
  Iff.intro
    (fun (h : ∃ x, p x → r) =>
      fun (h1 : ∀ x, p x) =>
        let ⟨a, (ha : p a → r)⟩ := h
        ha (h1 a))
    (fun (h : (∀ x, p x) → r) =>
      byCases
        (fun (h1 : ∀ x, p x) => ⟨a, fun _ => h h1⟩)
        (fun (h2 : ¬ (∀ x, p x)) =>
          byContradiction
            (fun h3 : ¬ (∃ x, p x → r) =>
              have : ∀ x, ¬ (p x → r) := (thm2 α (fun y => p y → r)).mp h3
              have : ∀ x, p x :=
                fun x =>
                  have h6 : ¬ (p x → r) := this x
                  (not_imp.mp h6).left
              h2 this)))


example (a : α) : (∃ x, r → p x) ↔ (r → ∃ x, p x) :=
  Iff.intro
    (fun (h : ∃ x, r → p x) =>
      fun r' =>
        let ⟨a, (hrp : r → p a)⟩ := h
        ⟨a, hrp r'⟩)
    (fun (h : r → ∃ x, p x) =>
      byContradiction
        (fun (hnerp : ¬(∃ x, r → p x)) =>
          have hanrp : ∀ x, ¬(r → p x) := (thm2 α (fun y => r → p y)).mp hnerp
          have hrp : r ∧ ¬ p a := not_imp.mp (hanrp a)
          let ⟨w, (hpw : p w)⟩ := h hrp.left
          have herp : ∃ x, r → p x := ⟨w, fun _ => hpw⟩
          hnerp herp))


example (n : Nat) : Nat := ‹Nat›

/- 1. Prove these equivalences: -/
variable (α : Type) (p q : α → Prop)

example : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x) :=
  Iff.intro
    (fun (h : ∀ x, p x ∧ q x) =>
      And.intro
        (fun x => (h x).left)
        (fun x => (h x).right))
    (fun (h : (∀ x, p x) ∧ (∀ x, q x)) =>
      fun x =>
        ⟨h.left x, h.right x⟩)

example : (∀ x, p x → q x) → (∀ x, p x) → (∀ x, q x) :=
  fun (h : ∀ x, p x → q x) =>
    fun (h1 : ∀ x, p x) =>
      fun x => (h x) (h1 x)

example : (∀ x, p x) ∨ (∀ x, q x) → ∀ x, p x ∨ q x :=
  fun (h : (∀ x, p x) ∨ (∀ x, q x)) =>
    fun x => Or.elim h
      (fun (hp : ∀ x, p x) => Or.inl (hp x))
      (fun (hq : ∀ x, q x) => Or.inr (hq x))


/- 2. It is often possible to bring a component of a formula outside a universal quantifier,
when it does not depend on the quantified variable.
Try proving these (one direction of the second of these requires classical logic): -/
variable (α : Type) (p q : α → Prop)
variable (r : Prop)

example : α → ((∀ x : α, r) ↔ r) :=
  fun α =>
    Iff.intro
      (fun (h : ∀ (x : α), r) => sorry)
      (fun (h : r) => sorry)

example : (∀ x, p x ∨ r) ↔ (∀ x, p x) ∨ r := sorry
example : (∀ x, r → p x) ↔ (r → ∀ x, p x) := sorry
