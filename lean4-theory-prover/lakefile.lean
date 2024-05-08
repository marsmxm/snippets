import Lake
open Lake DSL

package «lean4-theory-prover» where
  -- add package configuration options here

lean_lib «Lean4TheoryProver» where
  -- add library configuration options here

@[default_target]
lean_exe «lean4-theory-prover» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4"
