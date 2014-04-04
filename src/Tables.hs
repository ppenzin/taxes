module Tables where
{- Various tax tables -}

{- Married or single -}
data MaritalStatus = Married | Single
     deriving Show

-- TODO http://www.irs.gov/instructions/i1040nre/ar02.html#d0e4345
getFedIncomeTax :: Int -> MaritalStatus -> Int
getFedIncomeTax = undefined
