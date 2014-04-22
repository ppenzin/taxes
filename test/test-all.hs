module Main where

import Control.Monad
import Test.QuickCheck
import System.Exit

main :: IO ()
main = do
  result <- quickCheckResult prop
  unless (isSuccess result) exitFailure

prop x = True
