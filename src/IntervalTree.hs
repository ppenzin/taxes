module IntervalTree where

data Bound a = Include a | Exclude a
data Interval a = AnInterval {high :: Bound a, low :: Bound a}

data IntervalTree a b = ILeaf {value :: b, interval ::Interval a}
   | IBranch { value :: b, left :: IntervalTree a b, right:: IntervalTree a b}

