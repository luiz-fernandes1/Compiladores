module Main (main) where

import Lang.Interpreter.Interpreter (interpreter)
import Lang.Frontend.Parser.Parser (parser)  
import Lang.Frontend.Lexer.Lexer (lexer) 
import Test.Tasty
import Test.Tasty.HUnit
import qualified Data.Text.IO as TIO
import Data.Text (unpack)

main :: IO ()
main = defaultMain tests

testInterpreter :: String -> FilePath -> TestTree
testInterpreter testName filePath = testCase testName $ do
    code <- TIO.readFile filePath 
    let tokens = lexer (unpack code) 
    let program = parser tokens  
    interpreter program  

tests :: TestTree
tests = testGroup "Tests" [
                            factorialTests,
                            fibonacciTests,
                            stackTests,
                            bubblesortTests
                          ]

factorialTests :: TestTree
factorialTests = testGroup "Tests for Factorial"
                [
                   testInterpreter "Factorial Test" "test/Cases/fat.lang"
                ]

fibonacciTests :: TestTree
fibonacciTests = testGroup "Tests for Fibonacci"
                [
                   testInterpreter "Fibonacci Test" "test/Cases/fib.lang"
                ]

stackTests :: TestTree
stackTests = testGroup "Tests for Stack"
                [
                   testInterpreter "Stack Test" "test/Cases/stack.lang"
                ]

bubblesortTests :: TestTree
bubblesortTests = testGroup "Tests for Bubble Sort"
                [
                   testInterpreter "Bubble Sort Test" "test/Cases/bubblesort.lang"
                ]
