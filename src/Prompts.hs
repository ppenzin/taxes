module Prompts where
{- Command-line prompts to enter data -}

import Forms

{- Prompt user for W-2 form input -}
promptW2 :: IO FormW2
promptW2 = putStrLn "Enter total wages (W-2 field 1)"
         >> (readLn :: IO Int)
         >>= \inc -> putStrLn "Enter federal income tax"
         >> (readLn :: IO Int)
         >>= \fedTax -> putStrLn "Enter state income tax"
         >> (readLn :: IO Int)
         >>= \stTax -> return (Wage inc fedTax stTax)

{- Prompt user for previous year state tax return amount -}
promptPreviousReturn :: IO PreviousReturn
promptPreviousReturn = putStrLn "Enter previous year state tax return amount"
                     >> (readLn :: IO Int)
                     >>= \amt -> return (Return amt)

