{-
    Mateus Henrique Maximo Lima de Souza - 19.2.4004
    Luiz Fernando Rodrigues Fernandes - 19.2.4008
-}
module Main where

import System.Environment (getArgs)
import Lang.Frontend.Lexer.Lexer (Token(..), Lexeme(..), lexer)
import Lang.Frontend.Parser.Parser (parser)
import Lang.Interpreter.Interpreter (interpreter)

data Option 
  = Option {
      flag :: Flag, 
      file :: FilePath 
    }

data Flag 
  = Interp        
  | Compiler     

main :: IO ()
main = do 
  opts <- parseOptions  
  either putStrLn runWithOptions opts  

runWithOptions :: Option -> IO ()
runWithOptions opts = do
    content <- readFile (file opts)  
    case flag opts of
        Interp -> interpret content 
        Compiler -> compile content

parseOptions :: IO (Either String Option)
parseOptions = do
  args <- getArgs  
  case args of
    [fl, fn] -> buildOption fl fn  
    _ -> errorMessage 

buildOption :: String -> String -> IO (Either String Option)
buildOption theFlag theFile = case theFlag of
    "--compiler" -> return $ Right $ Option Compiler theFile
    "--interpreter" -> return $ Right $ Option Interp theFile
    _ -> errorMessage  

errorMessage :: IO (Either String Option)
errorMessage = return $ Left $ unlines [ "Invalid arguments!"
                                       , "Usage: lang <flag> <file>"
                                       , "Flags:"
                                       , "--compiler: run the compiler"
                                       , "--interpreter: run the interpreter"
                                       ]

compile :: String -> IO ()
compile content = do
    let ast = parser $ lexer content 
    print ast

interpret :: String -> IO ()
interpret content = do
    let ast = parser $ lexer content
    interpreter ast

printTokens :: [Token] -> IO ()
printTokens tokens = mapM_ (putStrLn . formatToken) tokens

-- Formatação de tokens para impressão
formatToken :: Token -> String
formatToken (Token _ l) = case l of
    TIdentifier s  -> "ID:" ++ s
    TInteger n     -> "INT:" ++ show n
    TAssign        -> "="
    TPrint         -> "PRINT"
    TRead          -> "READ"
    TReturn        -> "RETURN"
    TIterate       -> "ITERATE"
    TData          -> "DATA"
    TNew           -> "NEW"
    TIf            -> "IF"
    TElse          -> "ELSE"
    TThen          -> "THEN"
    TSemiColon     -> ";"
    TLParen        -> "("
    TRParen        -> ")"
    TLBrace        -> "{"
    TRBrace        -> "}"
    TLBracket      -> "["
    TRBracket      -> "]"
    TPlus          -> "+"
    TTimes         -> "*"
    TMinus         -> "-"
    TDiv           -> "/"
    TEq            -> "=="
    TLt            -> "<"
    TGt            -> ">"
    TNot           -> "!"
    TAnd           -> "&&"
    TTrue          -> "true"
    TFalse         -> "false"
    TComma         -> ","
    TMod           -> "%"
    TDoubleColon   -> "::"
    TColon         -> ":"
    TLiteralChar c -> "CHAR:" ++ c
    TTTypeName t   -> "TYPE:" ++ t
    TTTypeInt      -> "INT"
    TTTypeFloat    -> "FLOAT"
    TTTypeChar     -> "CHAR"
    TTTypeBool     -> "BOOL"
    TTFloat f      -> "FLOAT:" ++ show f
    TNull          -> "null"
    TDot           -> "."
    TNeq           -> "!="
