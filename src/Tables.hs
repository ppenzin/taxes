module Tables where
{- Various tax tables -}

{- 1040NR-EZ tax table
 - http://www.irs.gov/instructions/i1040nre/ar02.html
 -}

import System.IO

{- Married or single -}
data MaritalStatus = Married | Single
     deriving (Eq, Show)

{- Read a table from file
 - ^^^^^^^^^^^^^^^^^^^^^^
 - Table is an ASCII file with four tab-separated columns:
 -     start of the range (int, inclusive)
 -     end of the range (int, exclusive)
 -     tax amount for married
 -     tax amount for single
 -}
readTaxTable :: Handle -> IO [(Int, Int, Int, Int)]
readTaxTable handle = hGetContents handle
                  >>= \c -> return (map produceTuple $ map words $ lines c)

{- Produce a tuple out of read list
 - TODO add error handling for corrupt files
 -}
produceTuple :: [String] -> (Int, Int, Int, Int)
produceTuple [a, b, c, d] = (ai, bi, ci, di)
                  where ai = read a
                        bi = read b
                        ci = read c
                        di = read d

{- Find one's tax in a tax table
 - checking that the list is continuous (beginning of the next interval is
 - ending of the previous)
 -}
findTax :: Int -> MaritalStatus -> [(Int, Int, Int, Int)] -> Maybe Int
findTax inc ms []     = Nothing
findTax inc ms (t:ts) | end <= begin = error "Interval end should be greater than beginning"
                  where (begin, end, _, _) = t
findTax inc ms (t:u:ts) | end /= next = error "Tax table has gaps"
                  where (_, end, _, _) = t
                        (next, _, _, _) = u
findTax inc ms (t:ts) | inc < begin = Nothing
                  where (begin, end, m, s) = t
findTax inc ms (t:ts) | inc < end = Just (getVal ms m s)
                  where (begin, end, m, s) = t
                        getVal ms m s = if ms == Single then s else m
findTax inc ms (t:ts) | otherwise  = findTax inc ms ts

test1 = openFile "table.txt" ReadMode
    >>= readTaxTable
    >>= \t -> print (findTax 47221 Single t)

test2 = openFile "table.txt" ReadMode
    >>= readTaxTable
    >>= \t -> print (findTax (-1) Single t)

test3 = openFile "table.txt" ReadMode
    >>= readTaxTable
    >>= \t -> print (findTax 200000 Single t)

