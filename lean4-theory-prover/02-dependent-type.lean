/- Define some constants. -/

def m : Nat := 1       -- m is a natural number
def n : Nat := 0
def b1 : Bool := true
def b2 : Bool := false

#check m
#check b1
#check b1 && b2

#check Nat → Nat
#check Nat × Nat
#check Nat × Nat × Bool
#check Nat → Nat → Nat
#check Nat.succ
#check Nat.succ 2
#check (5, 9)
#check (5, 9).1
#check (5, 9).2
#check (m, n, b1)
#check List

#eval 5 * 4
#eval b1 || b2
#eval Nat.succ 2
#eval (5, 9).1


def α : Type := Nat
def β : Type := Bool

#check Prop
#check Prod α β       -- Type
#check α × β          -- Type

#check Prod Nat Nat   -- Type
#check Nat × Nat

#check Sort 0
#check Sort 1
#check Sort 2

#check Type
#check Type 0
#check Type 10

universe u
def F (α : Type u) : Type u := Prod α α
#check F

def G.{v} (α : Type v) : Type v := Prod α α
#check G


/- Function Abstraction and Evaluation -/
#check fun (x : Nat) => x + 5   -- Nat → Nat
#check λ (x : Nat) => x + 5     -- λ and fun mean the same thing
#check fun x => x + 5     -- Nat inferred
#check λ x => x + 5       -- Nat inferred

#eval (λ x : Nat => x + 5) 10    -- 15

/- Definitions -/
def double (x : Nat) : Nat :=
  x + x

#eval double 3

#check let y := 2 + 2; y * y   -- Nat
#eval  let y := 2 + 2; y * y   -- 16

def twice_double (x : Nat) : Nat :=
  let y := x + x; y * y

#eval twice_double 2   -- 16

def foo := let a := Nat; fun x : a => x + 2
#check foo
-- def bar := (fun a => fun x : a => x + 2) Nat


section useful
  variable (α β γ : Type)
  variable (g : β → γ) (f : α → β) (h : α → α)
  variable (x : α)

  def compose := g (f x)
  def doTwice := h (h x)
  def doThrice := h (h (h x))
end useful


-- universe u
def Lst (α : Type u) : Type u := List α
def Lst.cons (α : Type u) (a : α) (as : Lst α) : Lst α := List.cons a as
def Lst.nil (α : Type u) : Lst α := List.nil
def Lst.append (α : Type u) (as bs : Lst α) : Lst α := List.append as bs
#check Lst          -- Type u_1 → Type u_1
#check Lst.cons     -- (α : Type u_1) → α → Lst α → Lst α
#check Lst.nil      -- (α : Type u_1) → Lst α
#check Lst.append   -- (α : Type u_1) → Lst α → Lst α → Lst α
#check Lst.cons _ 0 (Lst.nil _)

def as : Lst Nat := Lst.nil _
def bs : Lst Nat := Lst.cons _ 5 (Lst.nil _)
#check Lst.append _ as bs
