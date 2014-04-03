module Forms where
{- Various datastructures to represent different forms -}

{- Wages and taxes, rounded to nearest dollar -}
data FormW2 = Wage {income :: Int, federalTaxes :: Int, stateTaxes :: Int}
     deriving Show

{- Aggregation of wages form -}
aggregateW2 :: FormW2 -> FormW2 -> FormW2
aggregateW2 (Wage i1 f1 s1) (Wage i2 f2 s2) = Wage (i1 + i2) (f1 + f2) (s1 + s2)

{- Last year's state tax return, rounded to nearest dollar -}
data PreviousReturn = Return { amount :: Int }
     deriving Show
