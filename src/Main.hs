module Main where
{- Command-line interface for tax calculator -}

import System.IO

import Forms
import Prompts
import Tables

{- Simple yes/no prompt -}
yesno :: String -> IO Bool
yesno prompt = putStrLn (prompt ++ " (y/n):")
             >> getLine
             >>= (\str -> case str of 
                     "y" -> return True
                     "n" -> return False
                     _   -> (putStrLn ("Invalid input") >> yesno prompt))

getAllWages :: FormW2 -> IO FormW2
getAllWages initW2 = putStrLn "Enter your W-2 data:"
                   >> promptW2
                   >>= \w2 -> yesno "Add one more W2 form?"
                   >>= \yes -> if yes then getAllWages(aggregateW2 initW2 w2) else return(aggregateW2 initW2 w2)

getStateTaxReturn :: IO PreviousReturn
getStateTaxReturn = yesno "Did you receive a state tax return last year?"
                  >>= \yes -> if yes then promptPreviousReturn else return(Return 0)

{- Start with zero values -}
main = putStr "Loading tax tables ... "
     >> openFile "tables/table1040NR-EZ.txt" ReadMode
     >>= \inh -> readTaxTable inh
     >>= \tt -> putStrLn "done"
     >> (getAllWages (Wage 0 0 0))
     >>= \w2 -> getStateTaxReturn
     >>= \ret -> promptMaritalStatus
     >>= \ms -> print(calculate1040NREZ tt ms w2 ret)
     >> hClose inh

