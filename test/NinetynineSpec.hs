 {-# OPTIONS_GHC -Wno-type-defaults #-}

module NinetynineSpec (test, spec) where

import Test.Hspec
import Test.QuickCheck

import Control.Exception

import Ninetynine

-- Hspec: http://hspec.github.io/index.html
-- QuickCheck: http://www.cse.chalmers.se/~rjmh/QuickCheck/manual.html

test :: IO ()
test = hspec spec

spec :: Spec
spec = parallel $ do
  describe "hspec tutorial" $ do
    it "can parse integers" $ do
      read "10" `shouldBe` (10 :: Int)
    it "pending test" $ do
      pending
      pendingWith "need to fix with message"
    it "expecting equality" $ do
      (+1) 0 `shouldBe` 1
    it "require that a predicate holds" $ do
      1 `shouldSatisfy` (== 1)
    it "expecting exceptions" $ do
      -- anyException, anyErrorCall, anyIOException, anyArithException
      evaluate (head []) `shouldThrow` anyException
      evaluate (1 `div` 0) `shouldThrow` anyArithException


  describe "myLast" $ do
    it "find the last element of a list" $ do
      myLast [1,2,3,4] `shouldBe` 4

  describe "myButLast" $ do
    it "find the last but one element of a list" $ do
      myButLast [1,2,3,4] `shouldBe` 3

  describe "myReverse" $ do
    it "reverse a list" $ property $
      \xs -> (myReverse . myReverse) xs == (xs :: [Int])

  describe "isPalindrome" $ do
    it "Find out whether a list is a palindrome" $ do
      isPalindrome [1,2,3] `shouldBe` False

  describe "flatten" $ do
    it "Flatten a nested list structure" $ do
      flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]]) `shouldBe` [1,2,3,4,5]
      flatten (Elem 5) `shouldBe` [5]
    it "Flatten a empty list structure" $ do
      (flatten (List []) :: [Integer]) `shouldBe` ([] :: [Integer])

  describe "compress" $ do
    it "Eliminate consecutive duplicates of list elements" $ do
      compress "aaaabccaadeeee" `shouldBe` "abcade"
  describe "pack" $ do
    it "Packconsecutive duplicates of list elements into sublists" $ do
      pack "aaabbcaabcc" `shouldBe` ["aaa","bb","c","aa","b","cc"]
  describe "encode" $ do
    it "Run-length encoding of a list" $ do
      encode "aaaabccaadeeee" `shouldBe` [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
      
  describe "encodeModified" $ do
    it "Run-length encoding of a list. If there is non duplication, just copy" $ do
      encodeModified "aaaabccaadeeee" `shouldBe` [Multiple 4 'a',Single 'b',Multiple 2 'c', Multiple 2 'a',Single 'd',Multiple 4 'e']

  describe "decodeModified" $ do
    it "Decode a run-length encoded list" $ do
      decodeModified [Multiple 4 'a',Single 'b',Multiple 2 'c', Multiple 2 'a',Single 'd',Multiple 4 'e'] `shouldBe` "aaaabccaadeeee" 



