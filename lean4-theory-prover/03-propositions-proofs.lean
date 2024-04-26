#check And     -- Prop → Prop → Prop
#check Or      -- Prop → Prop → Prop
#check Not     -- Prop → Prop
-- #check Implies

variable (p q r : Prop)
#check And p q                      -- Prop
#check Or (And p q) r               -- Prop
#check implies (And p q) (And q p)  -- Prop
