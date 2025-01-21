{-
    Mateus Henrique Maximo Lima de Souza - 19.2.4004
    Luiz Fernando Rodrigues Fernandes - 19.2.4008
-}

module Main where
import System.Directory (doesFileExist)
import Lang.Frontend.Lexer.Lexer (Token(..), Lexeme(..), lexer)

main :: IO ()
main = do
    putStrLn "Escolha uma opção:"
    putStrLn "1 - Utilizar o arquivo 'program.lang' no diretório atual"
    putStrLn "2 - Passar o caminho absoluto de um arquivo"
    option <- getLine
    case option of
        "1" -> processFile "app/program.lang"
        "2" -> do
            putStrLn "Digite o caminho absoluto do arquivo para leitura:"
            filename <- getLine
            processFile filename
        _   -> putStrLn "Opção inválida. Por favor, escolha 1 ou 2."

processFile :: FilePath -> IO ()
processFile filename = do
    fileExists <- doesFileExist filename
    if fileExists
        then do
            content <- readFile filename
            let tokens = lexer content
            printTokens tokens
        else putStrLn $ "Arquivo não encontrado: " ++ filename

printTokens :: [Token] -> IO ()
printTokens tokens = mapM_ (putStrLn . formatToken) tokens

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
    TTypeName t    -> "TYPE:" ++ t
    TFloat f       -> "FLOAT:" ++ show f
    TNull          -> "null"
    TDot           -> "."
    TNeq           -> "!="
