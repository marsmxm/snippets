section
  variable (x y : Nat)

  def double := x + x

  #check double y
  #check double (2 * x)

  attribute [local simp] Nat.add_assoc Nat.add_comm Nat.add_left_comm

  theorem t1 : double (x + y) = double x + double y := by
    simp [double]

  #check t1 y
  #check t1 (2 * x)

  theorem t2 : double (x * y) = double x * y := by
    simp [double, Nat.add_mul]

end

namespace Foo
def bar : Nat := 1
end Foo

open Foo

#check bar
#check Foo.bar

-- examples with equality
#check Eq
#check @Eq
#check Eq.symm
#check @Eq.symm

#print Eq.symm

-- examples with And
#check And
#check And.intro
#check @And.intro

-- a user-defined function
def foo {α : Type u} (x : α) : α := x

#check foo
#check @foo
#print foo
