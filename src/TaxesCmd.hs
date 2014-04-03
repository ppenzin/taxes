module TaxesCmd where
{- Command-line interface for tax calculator -}

import Forms
import Prompts

yesno :: String -> IO Bool
yesno prompt = putStrLn (prompt ++ " (y/n):")
             >> getLine
             >>= (\str -> case str of 
                     "y" -> return True
                     "n" -> return False
                     _   -> (putStrLn ("Invalid input.") >> yesno prompt))

getAllWages :: FormW2 -> IO FormW2
getAllWages initW2 = putStrLn "Enter your W-2 data:"
                   >> promptW2
                   >>= \w2 -> yesno "Add one more W2 form?"
                   >>= \yes -> if yes then getAllWages(aggregateW2 initW2 w2) else return(aggregateW2 initW2 w2)

{- Start with zero values -}
main = (getAllWages (Wage 0 0 0)) >>= \w2 -> print(w2)
