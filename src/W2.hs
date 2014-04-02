module W2 where
{- Module to handle W-2 data entry -}

{- Wages and taxes, rounded to nearest dollar -}
data W2data = Wage {income :: Int, federalTaxes :: Int, stateTaxes :: Int}
     deriving Show

{- Prompt user for W-2 form input -}
getW2 :: IO W2data
getW2 = putStrLn "Enter total wages (W-2 field 1)"
        >> (readLn :: IO Int)
        >>= \inc -> putStrLn "Enter federal income tax"
        >> (readLn :: IO Int)
        >>= \fedTax -> putStrLn "Enter state income tax"
        >> (readLn :: IO Int)
        >>= \stTax -> return (Wage inc fedTax stTax)

