module Lang.Frontend.Semantics.Basics where

import Lang.Syntax.Syntax

type VarCtx = [(String, Type)]   
type FuncCtx = [(String, FuncType)] 
type DataCtx = [(String, DataType)]
type Ctx = (VarCtx, FuncCtx, DataCtx)
type Expected = Type
type Found = Type

data FuncType = FuncType [Type] [Type]
  deriving (Eq, Show)
data DataType = DataType [(String, Type)]
  deriving (Eq, Show)

data Error
  = IncompatibleTypes Expected Found
  | UndefinedVariable String
  | UndefinedFunction String
  | FunctionAlreadyDefined String     
  | DataTypeAlreadyDefined String     
  | UnsupportedType Type
  | UnsupportedExpression
  | IncorrectNumberOfArguments String
  | IncorrectNumberOfReturnValues String
  | NoReturnValueAccessError String      
  | OutOfBoundsError Int Int
  | MainFunctionNotDefined

instance Show Error where 
  show (IncompatibleTypes ex fd) =
    unlines [ "Type error:"
            , "Expected: " ++ pType ex 
            , "Found: " ++ pType fd]
  show (UndefinedVariable v) =
    "Undefined variable: " ++ v
  show (UndefinedFunction f) =
    "Undefined function: " ++ f
  show (FunctionAlreadyDefined name) =
    "Function already defined: " ++ name
  show (DataTypeAlreadyDefined name) =
    "Data type already defined: " ++ name
  show (UnsupportedType t) =
    "Unsupported type: " ++ pType t
  show UnsupportedExpression =
    "Unsupported expression"
  show (IncorrectNumberOfArguments funcName) =
    "Incorrect number of arguments for function: " ++ funcName
  show (IncorrectNumberOfReturnValues funcName) =
    "Incorrect number of return values from function: " ++ funcName
  show (NoReturnValueAccessError funcName) =
    "Function '" ++ funcName ++ "' does not return any values, index access is invalid."
  show (OutOfBoundsError idx len) =
    "Index out of bounds: " ++ show idx ++ ". Valid range: 0 to " ++ show (len - 1)
  show (MainFunctionNotDefined) =
    "Main function not defined"

pType :: Type -> String 
pType (BaseType TTypeInt) = "Int"
pType (BaseType TTypeBool) = "Bool"
pType (BaseType TTypeFloat) = "Float"
pType (BaseType TTypeChar) = "Char"
pType (BaseType (TTypeName s)) = s
pType (TArray t) = "Array of " ++ pType t

typeOf :: Ctx -> Type -> Check Type
typeOf _ (BaseType TTypeInt)    = Right (BaseType TTypeInt)
typeOf _ (BaseType TTypeBool)   = Right (BaseType TTypeBool)
typeOf _ (BaseType TTypeFloat)  = Right (BaseType TTypeFloat)
typeOf _ (BaseType TTypeChar)   = Right (BaseType TTypeChar)
typeOf (_, _, datas) (BaseType (TTypeName name)) = 
    if name `elem` map fst datas
        then Right (BaseType (TTypeName name))
        else Left [UnsupportedType (BaseType (TTypeName name))]
typeOf ctx (TArray t) = do
    ty <- typeOf ctx t
    return (TArray ty)

type Check a = Either [Error] a
