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

#check Prod α β       -- Type
#check α × β          -- Type

#check Prod Nat Nat   -- Type
#check Nat × Nat  

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

