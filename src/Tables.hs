module Tables where
{- Various tax tables -}

{- Married or single -}
data MaritalStatus = Married | Single
     deriving (Eq, Show)

-- TODO use a segment tree of a kind
-- TODO Income tax table from
-- http://www.irs.gov/instructions/i1040nre/ar02.html
getFedIncomeTax :: Int -> MaritalStatus -> Int
getFedIncomeTax inc ms = undefined

{- Read a table from file
 - ^^^^^^^^^^^^^^^^^^^^^^
 - Table is an ASCII file with four tab-separated columns:
 -     start of the range (int, inclusive)
 -     end of the range (int, exclusive)
 -     tax amount for married
 -     tax amount for single
 -}
