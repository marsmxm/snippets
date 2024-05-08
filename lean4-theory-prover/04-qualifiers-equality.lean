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

example : (∀ x, p x) ↔ ¬ (∃ x, ¬ p x) := sorry
example : (∃ x, p x) ↔ ¬ (∀ x, ¬ p x) := sorry
example : (¬ ∃ x, p x) ↔ (∀ x, ¬ p x) := sorry
example : (¬ ∀ x, p x) ↔ (∃ x, ¬ p x) := sorry

example : (∀ x, p x → r) ↔ (∃ x, p x) → r := sorry
example (a : α) : (∃ x, p x → r) ↔ (∀ x, p x) → r := sorry
example (a : α) : (∃ x, r → p x) ↔ (r → ∃ x, p x) := sorry
