data Direction = North
               | East
               | South
               | West

turnClockwise : Direction -> Direction
turnClockwise North = East
turnClockwise East = South
turnClockwise South = West
turnClockwise West = North


data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double

area : Shape -> Double
area (Triangle base height) = 0.5 * base * height
area (Rectangle length height) = length * height
area (Circle radius) = pi * radius * radius


data Picture = Primitive Shape
              | Combine Picture Picture
              | Rotate Double Picture
              | Translate Double Double Picture

rectangle : Picture
rectangle = Primitive (Rectangle 20 10)
circle : Picture
circle = Primitive (Circle 5)
triangle : Picture
triangle = Primitive (Triangle 10 10)
testPicture : Picture
testPicture = Combine (Translate 5 5 rectangle)
              (Combine (Translate 35 5 circle)
              (Translate 15 25 triangle))


pictureArea : Picture -> Double
pictureArea (Primitive shape) = area shape
pictureArea (Combine pic pic1) = pictureArea pic + pictureArea pic1
pictureArea (Rotate x pic) = pictureArea pic
pictureArea (Translate x y pic) = pictureArea pic


data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)

%name Tree tree, tree1

insert : Ord elem => elem -> Tree elem -> Tree elem
insert x Empty = Node Empty x Empty
insert x orig@(Node left val right)
      = case compare x val of
             LT => Node (insert x left) val right
             EQ => orig
             GT => Node left val (insert x right)


listToTree : Ord a => List a -> Tree a
listToTree xs = foldl (\tree, x => insert x tree) Empty xs

treeToList : Tree a -> List a
treeToList Empty = []
treeToList (Node left x right) = (treeToList left) ++ (x :: treeToList right)


data Expr = Val Int
            | Add Expr Expr
            | Sub Expr Expr
            | Mult Expr Expr

%name Expr expr, expr1

evaluate : Expr -> Int
evaluate (Val x) = x
evaluate (Add e1 e2) = (evaluate e1) + (evaluate e2)
evaluate (Sub e1 e2) = (evaluate e1) - (evaluate e2)
evaluate (Mult e1 e2) = (evaluate e1) * (evaluate e2)


maxMaybe : Ord a => Maybe a -> Maybe a -> Maybe a
maxMaybe Nothing Nothing = Nothing
maxMaybe Nothing orig@(Just x) = orig
maxMaybe orig@(Just x) Nothing = orig
maxMaybe (Just x) (Just y) = if x >= y then Just x else Just y
