{
module Lang.Frontend.Parser.Parser (parser) where

import Lang.Frontend.Lexer.Lexer
import Lang.Syntax.Syntax 
}

%name parser
%tokentype { Token }
%error     { parseError }

{-- Mapeamento entre tokens definidos para o Lexer (Alex) para o formato esperado pelo Parser (Happy) --}

%token
    if          { Token _ TIf }
    else        { Token _ TElse }
    true        { Token _ TTrue }
    false       { Token _ TFalse }
    print       { Token _ TPrint }
    read        { Token _ TRead }
    return      { Token _ TReturn }
    iterate     { Token _ TIterate }
    data        { Token _ TData }
    new         { Token _ TNew }
    '='         { Token _ TAssign }
    '::'        { Token _ TDoubleColon }
    ':'         { Token _ TColon }
    ';'         { Token _ TSemiColon }
    '('         { Token _ TLParen }
    ')'         { Token _ TRParen }
    '{'         { Token _ TLBrace }
    '}'         { Token _ TRBrace }
    '['         { Token _ TLBracket }
    ']'         { Token _ TRBracket }
    '+'         { Token _ TPlus }
    '*'         { Token _ TTimes }
    '-'         { Token _ TMinus }
    '/'         { Token _ TDiv }
    '=='        { Token _ TEq }
    '!='        { Token _ TNeq }
    '<'         { Token _ TLt }
    '>'         { Token _ TGt }
    '!'         { Token _ TNot }
    '&&'        { Token _ TAnd }
    ','         { Token _ TComma }
    '.'         { Token _ TDot }
    '%'         { Token _ TMod }
    null        { Token _ TNull }
    literalchar { Token _ (TLiteralChar $$) }
    int         { Token _ (TInteger $$) }
    float       { Token _ (TTFloat $$) }
    typename    { Token _ (TTTypeName $$) }
		typebool    { Token _ TTTypeBool }
    typeint     { Token _ TTTypeInt }
    typefloat   { Token _ TTTypeFloat }
    typechar    { Token _ TTTypeChar }
    identifier  { Token _ (TIdentifier $$) }

{- Define a precedencia e a associatividade dos operadores -}

%left '&&'
%nonassoc '==' '!='
%nonassoc '<' '>'
%left '+' '-'
%left '*' '/' '%'
%right '!' '-'
%left '[' ']' '.' '(' ')'

{- Define a estrutura sintatica de Lang -}
%%

Program         : DefList                                                          { Program $1 }

DefList         : Def DefList                                                      { DefList $1 $2 }
		            |                                                                  { DefListEmpty }

Def             : Data                                                             { DefData $1 }
		            | Func                                                             { DefFunc $1 }

Data            : data typename '{' DecList '}'                                    { Data $2 $4 }
 
Func            : identifier '(' ParamsList ')' ReturnTypeList '{' CommandList '}' { Func $1 $3 $5 $7 }

DecList         : Decl DecList                                                     { DecList $1 $2 }
		            |                                                                  { DeclEmpty }

Decl            : identifier '::' Type ';'                                         { Decl $1 $3 }

BType           : typeint                                                          { TTypeInt }
                | typefloat                                                        { TTypeFloat }
                | typechar                                                         { TTypeChar }
                | typebool                                                         { TTypeBool }
                | typename                                                         { TTypeName $1 }

Type            : BType                                                            { BaseType $1 }
                | Type '[' ']'                                                     { TArray $1 }

Param           : identifier '::' Type                                             { Param $1 $3 }

ParamsTail      : ',' Param ParamsTail                                             { ParamsTail $2 $3 }
				        |                                                                  { ParamsTailEmpty }

ParamsList      : Param ParamsTail                                                 { ParamsList $1 $2 }
		            |                                                                  { ParamsListEmpty }

ReturnTypeList  : ':' Type ReturnTypeTail                                          { ReturnTypeList $2 $3 }
				        |                                                                  { ReturnTypeListEmpty  }

ReturnTypeTail  : ',' Type ReturnTypeTail                                          { ReturnTypeTail $2 $3 }
				        |                                                                  { ReturnTypeTailEmpty }


CommandList     : Command CommandList                                              { CommandList $1 $2 }
				        |                                                                  { CommandListEmpty }

Command         : '{' CommandList '}'                                              { CBlock $2 }
                | if '(' Exp ')' Command %shift                                    { CIf $3 $5 }
                | if '(' Exp ')' Command else Command                              { CIfElse $3 $5 $7 }
                | iterate '(' Exp ')' Command                                      { CIterate $3 $5 }
                | read Lvalue ';'                                                  { CRead $2 }
                | print Exp ';'                                                    { CPrint $2 }
                | return Exp ExpListTail ';'                                       { CReturn $2 $3 }
                | Lvalue '=' Exp ';'                                               { CLvalueAssign $1 $3 }
                | identifier '(' ExpList ')' LvaluesList ';'                       { CCall $1 $3 $5 }

Exp             : int                                                              { EInt $1 }
                | float                                                            { EFloat $1 }
                | true                                                             { ETrue }
                | false                                                            { EFalse }
	              | literalchar                                                      { ELiteralChar $1}
				        | Lvalue                                                           { ELvalue $1 }
                | null                                                             { ENull }
                | Exp '+' Exp                                                      { EPlus $1 $3 }
                | Exp '*' Exp                                                      { ETimes $1 $3 }
                | Exp '-' Exp                                                      { EMinus $1 $3 }
                | Exp '/' Exp                                                      { EDivide $1 $3 }
	              | Exp '%' Exp                                                      { EMod $1 $3 }
                | Exp '==' Exp                                                     { EEqual $1 $3 }
                | Exp '!=' Exp                                                     { ENEqual $1 $3 }
                | Exp '<' Exp                                                      { ELT $1 $3 }
                | Exp '>' Exp                                                      { EGT $1 $3 }
                | Exp '&&' Exp                                                     { EAnd $1 $3 }
                | '!' Exp                                                          { ENot $2 }
				        | '-' Exp                                                          { EMinusExp $2 }
                | '(' Exp ')'                                                      { EParen $2 }
	              | new Type Index                                                   { ENew $2 $3 }
				        | identifier '(' ExpList ')' '[' Exp ']'                           { ECall $1 $3 $6 }

ExpList         : Exp ExpListTail                                                  { ExpList $1 $2 }
                |                                                                  { ExpListEmpty }

ExpListTail     : ',' Exp ExpListTail                                              { ExpListTail $2 $3 }
                |                                                                  { ExpListTailEmpty }

Lvalue          : identifier                                                       { LvalueId $1 }
                | Lvalue '[' Exp ']'                                               { LvalueArray $1 $3 }
                | Lvalue '.' identifier                                            { LvalueDot $1 $3 }

LvaluesList     : '<' Lvalue LvaluesListTail '>'                                   { LvaluesList $2 $3 }
                |                                                                  { LvaluesListEmpty }

LvaluesListTail : ',' Lvalue LvaluesListTail                                       { LvaluesListTail $2 $3 }
                |                                                                  { LvaluesListTailEmpty }

Index           : '[' Exp ']' Index                                                { Index $2 $4 }
                |                                                                  { IndexEmpty }  

{
parseError :: [Token] -> a
parseError [] = error "Parse error: unexpected end of input!"
parseError (t : _) = error $ "Parse error at " ++ show (pos t) ++ ": unexpected token '" ++ showToken t ++ "'"

showToken :: Token -> String
showToken (Token _ lexeme) = case lexeme of
    TIdentifier s   -> s
    TInteger n      -> show n
    TLiteralChar c  -> c
    TTTypeFloat     -> "Float"
    TTTypeInt        -> "Int"
    TTTypeChar      -> "Char"
    TTTypeBool      -> "Bool"
    TTTypeName t    -> t
    TTFloat f       -> show f
    TAssign         -> "="
    TPrint          -> "print"
    TRead           -> "read"
    TReturn         -> "return"
    TIterate        -> "iterate"
    TData           -> "data"
    TNew            -> "new"
    TIf             -> "if"
    TElse           -> "else"
    TThen           -> "then"
    TSemiColon      -> ";"
    TLParen         -> "("
    TRParen         -> ")"
    TLBrace         -> "{"
    TRBrace         -> "}"
    TLBracket       -> "["
    TRBracket       -> "]"
    TPlus           -> "+"
    TTimes          -> "*"
    TMinus          -> "-"
    TDiv            -> "/"
    TEq             -> "=="
    TLt             -> "<"
    TGt             -> ">"
    TNot            -> "!"
    TAnd            -> "&&"
    TTrue           -> "true"
    TFalse          -> "false"
    TComma          -> ","
    TMod            -> "%"
    TDoubleColon    -> "::"
    TColon          -> ":"
    TNull           -> "null"
    TDot            -> "."
    TNeq            -> "!="
}
