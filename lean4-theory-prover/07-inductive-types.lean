inductive Weekday where
  | sunday : Weekday
  | monday : Weekday
  | tuesday : Weekday
  | wednesday : Weekday
  | thursday : Weekday
  | friday : Weekday
  | saturday : Weekday


#check Weekday.sunday
#check Weekday.monday
#check Weekday.rec

open Weekday

#check sunday
#check monday

def numberOfDay (d : Weekday) : Nat :=
  match d with
  | sunday    => 1
  | monday    => 2
  | tuesday   => 3
  | wednesday => 4
  | thursday  => 5
  | friday    => 6
  | saturday  => 7

#eval numberOfDay Weekday.sunday  -- 1
#eval numberOfDay Weekday.monday  -- 2
#eval numberOfDay Weekday.tuesday

structure Color where
  (red : Nat) (green : Nat) (blue : Nat)
  deriving Repr

def yellow := Color.mk 255 255 0

#eval Color.red yellow

namespace Hidden
inductive Nat where
 | zero : Nat
 | succ : Nat → Nat
#check @Nat.rec

def add (m n : Nat) : Nat :=
  match n with
  | Nat.zero   => m
  | Nat.succ n => Nat.succ (add m n)

instance : Add Nat where
  add := add

open Nat

theorem add_zero (m : Nat) : m + Nat.zero = m := rfl
theorem add_succ (m n : Nat) : m + Nat.succ n = Nat.succ (m + n) := rfl

theorem zero_add (n : Nat) : Nat.zero + n = n :=
  Nat.recOn (motive := fun x => Nat.zero + x = x) n
    rfl
    (fun n ih => by simp [add_succ, ih])

theorem zero_add1 (n : Nat) : zero + n = n := by
  induction n with
  | zero => rfl
  | succ n ih => rw [add_succ, ih]


theorem add_assoc (m n k : Nat) : m + n + k = m + (n + k) :=
  Nat.recOn (motive := fun k => m + n + k = m + (n + k)) k
    (show m + n + zero = m + (n + zero) from rfl)
    (fun k (ih : m + n + k = m + (n + k)) =>
      show m + n + succ k = m + (n + succ k) from
      calc m + n + succ k
        _ = succ (m + n + k)   := rfl
        _ = succ (m + (n + k)) := by rw [ih]
        _ = m + succ (n + k)   := rfl
        _ = m + (n + succ k)   := rfl)

theorem succ_add (n m : Nat) : succ n + m = succ (n + m) :=
  Nat.recOn (motive := fun x => succ n + x = succ (n + x)) m
    rfl
    (fun m ih => by simp only [add_succ, ih])

theorem add_comm (m n : Nat) : m + n = n + m :=
  Nat.recOn (motive := fun x => m + x = x + m) n
    (show m + zero = zero + m from by simp [add_zero, zero_add])
    (fun m ih => by simp [add_succ, succ_add, ih])

inductive List (α : Type u) where
| nil  : List α
| cons : α → List α → List α

#check List.recOn
namespace List
def append (as bs : List α) : List α :=
 match as with
 | nil       => bs
 | cons a as => cons a (append as bs)
theorem nil_append (as : List α) : append nil as = as :=
 rfl
theorem cons_append (a : α) (as bs : List α)
                    : append (cons a as) bs = cons a (append as bs) :=
 rfl

theorem append_nil (as : List α) : append as nil = as :=
  match as with
  | nil => rfl
  | cons a as' =>
      calc append (cons a as') nil
      _ = cons a (append as' nil) := by rw [cons_append]
      _ = cons a as' := by rw [append_nil as']

theorem append_assoc (as bs cs : List α)
        : append (append as bs) cs = append as (append bs cs) :=
  List.recOn (motive := fun xs => append (append xs bs) cs = append xs (append bs cs)) as
    (by simp [nil_append])
    (fun a as' (ih : append (append as' bs) cs = append as' (append bs cs)) =>
      by simp [cons_append, ih])

#check List.recOn
def length (as : List α) : Nat :=
  match as with
  | nil => Nat.zero
  | cons _ as' => Nat.succ (length as')


theorem length_append (as bs : List α) : length (append as bs) = length as + length bs :=
  List.recOn (motive := fun xs => length (append xs bs) = length xs + length bs) as
    (show length (append nil bs) = length nil + length bs from
      calc length (append nil bs)
        _ = length bs := by rw [nil_append]
        _ = Nat.zero + length bs := by simp [zero_add])
    (fun a as' (ih : length (append as' bs) = length as' + length bs) =>
      calc length (append (cons a as') bs)
        _ = length (cons a (append as' bs)) := by rw [cons_append]
        _ = Nat.succ (length (append as' bs)) := rfl
        _ = Nat.succ (length as' + length bs) := by rw [ih]
        _ = Nat.succ (length as') + length bs := by rw [succ_add])

end List
end Hidden


inductive BinaryTree where
  | leaf : BinaryTree
  | node : BinaryTree → BinaryTree → BinaryTree

example (p : Nat → Prop) (hz : p 0) (hs : ∀ n, p (Nat.succ n)) : ∀ n, p n := by
  intro n
  cases n
  . exact hz  -- goal is p 0
  . apply hs  -- goal is a : Nat ⊢ p (succ a)

inductive Foo where
  | bar1 : Nat → Nat → Foo
  | bar2 : Nat → Nat → Nat → Foo

def silly (x : Foo) : Nat := by
  cases x with
  | bar1 a b => exact b
  | bar2 c d e => exact e

def silly1 (x : Foo) : Nat := by
  cases x
  case bar1 a b => exact b
  case bar2 c d e => exact e
