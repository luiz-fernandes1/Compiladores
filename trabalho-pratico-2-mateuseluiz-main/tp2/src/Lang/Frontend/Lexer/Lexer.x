{
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module Lang.Frontend.Lexer.Lexer (Token (..), Lexeme (..), lexer) where
}

%wrapper "posn"

$digit        = 0-9
$lowercase    = [a-z]
$uppercase    = [A-Z]
$alpha        = [$lowercase $uppercase]
$underscore   = _

@identifier   = $lowercase[$alpha $digit $underscore]*
@typename     = $uppercase[$alpha $digit $underscore]*
@integer      = $digit+
@float        = $digit+ "." $digit+ | "." $digit+
@literalChar  = $alpha | \\n | \\t | \\b | \\r | \\ | \\\\ | \'

tokens :-
      $white+                 ;
      "--".*                  ; 
      "if"                    { simpleToken TIf }
      "else"                  { simpleToken TElse }
	    "then"                  { simpleToken TThen }
      "true"                  { simpleToken TTrue }
      "false"                 { simpleToken TFalse }
      "print"                 { simpleToken TPrint }
	    "read"                  { simpleToken TRead }
      "return"                { simpleToken TReturn }
      "iterate"               { simpleToken TIterate }
      "data"                  { simpleToken TData }
	    "new"                   { simpleToken TNew }
      "="                     { simpleToken TAssign }
      "::"                    { simpleToken TDoubleColon }
      ":"                     { simpleToken TColon }
      ";"                     { simpleToken TSemiColon }
      "("                     { simpleToken TLParen }
      ")"                     { simpleToken TRParen }
      "{"                     { simpleToken TLBrace }
      "}"                     { simpleToken TRBrace }
      "["                     { simpleToken TLBracket }
      "]"                     { simpleToken TRBracket }
      "+"                     { simpleToken TPlus }
      "*"                     { simpleToken TTimes }
      "-"                     { simpleToken TMinus }
      "/"                     { simpleToken TDiv }
      "=="                    { simpleToken TEq }
      "!="                    { simpleToken TNeq }
      "<"                     { simpleToken TLt }
      ">"                     { simpleToken TGt }
      "!"                     { simpleToken TNot }
      "&&"                    { simpleToken TAnd }
      ","                     { simpleToken TComma }
      "."                     { simpleToken TDot }
      "%"                     { simpleToken TMod }
      "null"                  { simpleToken TNull }
			"Bool"                  { simpleToken TTTypeBool }
      "Int"                   { simpleToken TTTypeInt }
	    "Float"                 { simpleToken TTTypeFloat }
	    "Char"                  { simpleToken TTTypeChar }
	    "'" @literalChar "'"    { mkLiteralChar }
      @integer                { mkInteger }
      @float                  { mkFloat }
      @typename               { mkTypeName }
      @identifier             { mkIdentifier }
      .                       { handleUnexpectedChar }

{

data Token = Token {
    pos :: (Int, Int),
    lexeme :: Lexeme
} deriving (Eq, Ord, Show)

data Lexeme
  = TIdentifier String
  | TInteger Int
  | TLiteralChar String
  | TTTypeName String
  | TTFloat Double
  | TTTypeBool
  | TTTypeInt
  | TTTypeFloat
  | TTTypeChar
  | TAssign
  | TPrint
  | TRead
  | TReturn
  | TIterate
  | TData
  | TNew
  | TIf
  | TElse
  | TThen
  | TSemiColon
  | TLParen
  | TRParen
  | TLBrace
  | TRBrace
  | TLBracket
  | TRBracket
  | TPlus
  | TTimes
  | TMinus
  | TDiv
  | TEq
  | TLt
  | TGt
  | TNot
  | TAnd
  | TTrue
  | TFalse
  | TComma
  | TMod
  | TDoubleColon
  | TColon
  | TNull
  | TDot
  | TNeq
  deriving (Eq, Ord, Show)

simpleToken :: Lexeme -> AlexPosn -> String -> Token
simpleToken lx p _ = Token (position p) lx

position :: AlexPosn -> (Int, Int)
position (AlexPn _ x y) = (x, y)

mkInteger :: AlexPosn -> String -> Token
mkInteger p s = Token (position p) (TInteger $ read s)

mkFloat :: AlexPosn -> String -> Token
mkFloat p s = Token (position p) (TTFloat $ read (normalizeFloat s))

normalizeFloat :: String -> String
normalizeFloat s@(c:_)
  | c == '.'  = '0' : s  -- Normaliza floats como ".123" para "0.123"
  | otherwise = s
normalizeFloat [] = error "Invalid float format"

mkIdentifier :: AlexPosn -> String -> Token
mkIdentifier p s = Token (position p) (TIdentifier s)

mkLiteralChar :: AlexPosn -> String -> Token
mkLiteralChar p s = Token (position p) (TLiteralChar s)

mkTypeName :: AlexPosn -> String -> Token
mkTypeName p s = Token (position p) (TTTypeName s)

handleUnexpectedChar :: AlexPosn -> String -> a
handleUnexpectedChar p s = error $ "ERROR: unexpected character '" ++ s ++ "' at " ++ show (position p)

lexer :: String -> [Token]
lexer = alexScanTokens
}
