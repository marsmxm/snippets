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

example (m n k : Nat) (h : succ (succ m) = succ (succ n))
        : n + k = m + k := by
  injection h with h'
  injection h' with h''
  rw [h'']

inductive List (α : Type u) where
| nil  : List α
| cons : α → List α → List α

#check (List.nil : List Nat)
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

def reverse (as : List α) : List α :=
  match as with
  | nil => nil
  | cons a as' => append (reverse as') (cons a nil)

theorem length_reverse (as : List α) : length (reverse as) = length as :=
  List.recOn (motive := fun xs => length (reverse xs) = length xs) as
    rfl
    (fun a as' (ih : length (reverse as') = length as') =>
      calc length (reverse (cons a as'))
        _ = length (append (reverse as') (cons a nil)) := rfl
        _ = length (reverse as') + length (cons a nil) := by rw[length_append]
        _ = length as' + length (cons a nil) := by simp [ih])

theorem reverse_append (as bs : List α) : reverse (append as bs) = append (reverse bs) (reverse as) :=
  List.recOn (motive := fun xs => reverse (append xs bs) = append (reverse bs) (reverse xs)) as
    (calc reverse (append nil bs)
      _ = reverse bs := by rw [nil_append]
      _ = append (reverse bs) nil := by rw [append_nil])
    (fun a as' (ih : reverse (append as' bs) = append (reverse bs) (reverse as')) =>
      calc reverse (append (cons a as') bs)
        _ = reverse (cons a (append as' bs)) := rfl
        _ = append (reverse (append as' bs)) (cons a nil) := rfl
        _ = append (append (reverse bs) (reverse as')) (cons a nil) := by rw [ih]
        _ =
      )


theorem reverse_eq (as : List α) : reverse (reverse as) = as :=
  List.recOn (motive := fun xs => reverse (reverse xs) = xs) as
    rfl
    (fun a as' (ih : reverse (reverse as') = as') =>
      calc reverse (reverse (cons a as'))
        _ = reverse (append (reverse as') (cons a nil)) := rfl
        _ =
        )
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

namespace Hidden
inductive Vector (α : Type u) : Nat → Type u where
  | nil  : Vector α Nat.zero
  | cons : α → {n : Nat} → Vector α n → Vector α (Nat.succ n)

#check Vector

inductive Eq {α : Sort u} (a : α) : α → Prop where
  | refl : Eq a a

#check Eq
#check Eq 2
#check (Eq.refl)
#check (@Eq.refl Nat Nat.zero)

theorem subst {α : Type u} {a b : α} {p : α → Prop} (h₁ : Eq a b) (h₂ : p a) : p b :=
  Eq.rec (motive := fun x _ => p x) h₂ h₁

theorem symm {α : Type u} {a b : α} (h : Eq a b) : Eq b a :=
  Eq.rec (motive := fun x _ => Eq x a) Eq.refl h


theorem trans {α : Type u} {a b c : α} (h₁ : Eq a b) (h₂ : Eq b c) : Eq a c :=
  subst h₂ h₁

theorem congr {α β : Type u} {a b : α} (f : α → β) (h : Eq a b) : Eq (f a) (f b) :=
  Eq.rec (motive := fun x _ => Eq (f a) (f x)) Eq.refl h
end Hidden

#check List.reverse
