module Lang.Syntax.Syntax where

data Program 
    = Program DefList
    deriving (Eq, Show)

data DefList 
    = DefList Def DefList
    | DefListEmpty
    deriving (Eq, Show)

data Def 
    = DefData Data
    | DefFunc Func
    deriving (Eq, Show)

data Data 
    = Data String DecList
    deriving (Eq, Show)

data DecList 
    = DecList Decl DecList
    | DeclEmpty
    deriving (Eq, Show)

data Decl 
    = Decl String Type
    deriving (Eq, Show)

data Func 
    = Func String ParamsList ReturnTypeList CommandList
    deriving (Eq, Show)

data Type 
    = TArray Type 
    | BaseType BType
    deriving (Eq, Ord, Show)

data BType
   = TTypeInt
   | TTypeBool
   | TTypeFloat
   | TTypeChar
   | TTypeName String
   deriving (Eq, Ord, Show)

data Param
    = Param String Type
    deriving (Eq, Show)

data ParamsTail
    = ParamsTail Param ParamsTail
    | ParamsTailEmpty
    deriving (Eq, Show)

data ParamsList 
    = ParamsList Param ParamsTail
    | ParamsListEmpty
    deriving (Eq, Show)

data ReturnTypeList 
    = ReturnTypeList Type ReturnTypeTail
    | ReturnTypeListEmpty
    deriving (Eq, Show)

data ReturnTypeTail 
    = ReturnTypeTail Type ReturnTypeTail
    | ReturnTypeTailEmpty
    deriving (Eq, Show)

data CommandList 
    = CommandList Command CommandList
    | CommandListEmpty
    deriving (Eq, Show)

data Command 
    = CBlock CommandList
    | CIf Exp Command
    | CIfElse Exp Command Command
    | CIterate Exp Command
    | CRead Lvalue
    | CPrint Exp
    | CReturn Exp ExpListTail
    | CLvalueAssign Lvalue Exp
    | CCall String ExpList LvaluesList
    deriving (Eq, Show)

data ExpList 
    = ExpList Exp ExpListTail
    | ExpListEmpty
    deriving (Eq, Show)

data ExpListTail 
    = ExpListTail Exp ExpListTail
    | ExpListTailEmpty
    deriving (Eq, Show)

data LvaluesList 
    = LvaluesList Lvalue LvaluesListTail
    | LvaluesListEmpty
    deriving (Eq, Show)

data LvaluesListTail 
    = LvaluesListTail Lvalue LvaluesListTail
    | LvaluesListTailEmpty
    deriving (Eq, Show)

data Exp 
    = EAnd Exp Exp 
    | ELT Exp Exp
    | EGT Exp Exp
    | EEqual Exp Exp
    | ENEqual Exp Exp
    | EPlus Exp Exp
    | EMinus Exp Exp
    | ETimes Exp Exp
    | EDivide Exp Exp
    | EMod Exp Exp
    | ENot Exp             
    | EMinusExp Exp
    | ETrue
    | EFalse
    | ENull
    | ENew Type Index
    | EInt Int
    | EFloat Double
    | ELiteralChar String
    | ELvalue Lvalue
    | EParen Exp
    | ECall String ExpList Exp
    deriving (Eq, Show)

data Lvalue 
    = LvalueId String
    | LvalueArray Lvalue Exp
    | LvalueDot Lvalue String
    deriving (Eq, Show)

data Index
    = Index Exp Index
    | IndexEmpty
    deriving (Eq, Show)
