module Forms where
{- Various datastructures to represent different forms -}

import Tables

{- Wages and taxes, rounded to nearest dollar -}
data FormW2 = Wage {income :: Int, federalTaxes :: Int, stateTaxes :: Int}
     deriving Show

{- Aggregation of wages form -}
aggregateW2 :: FormW2 -> FormW2 -> FormW2
aggregateW2 (Wage i1 f1 s1) (Wage i2 f2 s2) = Wage (i1 + i2) (f1 + f2) (s1 + s2)

{- Last year's state tax return, rounded to nearest dollar -}
data PreviousReturn = Return { amount :: Int }
     deriving Show

{- 1040NR-EZ tax form -}
data Form1040NREZ = NREZ {
    wages :: Int,
    refunds :: Int,
    totalIncome :: Int,
    adjustedIncome :: Int,
    deductions :: Int,
    exemption :: Int,
    taxableIncome :: Int,
    tax :: Int,
    incomeTaxWithheld :: Int,
    refund :: Int
  } deriving Show

{- Calculate fields in 1040NR-EZ based on the two input forms -}
calculate1040NREZ :: [(Int, Int, Int, Int)] -> MaritalStatus -> FormW2 -> PreviousReturn -> Form1040NREZ
calculate1040NREZ ttable ms (Wage inc fed state) (Return ret) =
    (NREZ inc ret totInc adjInc deduct exempt txInc tx txWh ref)
        where totInc = (inc + ret)
              adjInc = totInc
              deduct = state
              exempt = 3900
              txInc  = if (txInc' > 0) then txInc else 0
              tx     = case (findTax txInc ms ttable) of
                         Just value -> value
                         Nothing -> error "Unable to find tax value"
              txWh   = fed
              ref    = (txWh - tx)
              txInc' = (adjInc - deduct - exempt)

