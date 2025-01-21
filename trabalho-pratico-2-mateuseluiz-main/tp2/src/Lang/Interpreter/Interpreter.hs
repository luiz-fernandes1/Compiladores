{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module Lang.Interpreter.Interpreter (interpreter) where

import Lang.Syntax.Syntax
import Text.Read (readMaybe)
import Data.Char (toLower)

type EnvVar = [(String, Value)] 
type EnvFunc = [(String, Func)]
type EnvData = [(String, Data)]
type Env = (EnvVar, EnvFunc, EnvData)

data Value
  = VInt Int 
  | VBool Bool
  | VFloat Double
  | VLiteralChar String
  | VData String [(String, Value)]
  | VArray [Value]
  | VNull
  deriving (Eq, Show)

interpreter :: Program -> IO ()
interpreter (Program defs) = do
    env@(_, funcs, _) <- interpDefList defs ([], [], [])
    case lookup "main" funcs of
      Nothing -> putStrLn "Error: No 'main' procedure found."
      Just (Func _ _ _ commands) -> do
          _ <- interpCommandList env commands 
          return () 

-- Interpretation of definitions

interpDefList :: DefList -> Env -> IO Env
interpDefList DefListEmpty env = return env
interpDefList (DefList d ds) env = do
    env' <- interpDef d env
    interpDefList ds env'

interpDef :: Def -> Env -> IO Env
interpDef (DefFunc func@(Func name _ _ _)) (vars, funcs, datas) =
    return (vars, (name, func) : funcs, datas)
interpDef (DefData dataDef@(Data name _)) (vars, funcs, datas) =
    return (vars, funcs, (name, dataDef) : datas)

-- Interpretation of command lists

interpCommandList :: Env -> CommandList -> IO Env
interpCommandList env CommandListEmpty = return env
interpCommandList env (CommandList cmd cmds) = do
    env' <- interpCommand env cmd
    interpCommandList env' cmds

-- Interpretation of commands

interpCommand :: Env -> Command -> IO Env
interpCommand env@(vars, funcs, datas) cmd = case cmd of
    CPrint exp -> do
        v <- interpExp env exp
        printValue v
        return env

    CCall funcName expList lvaluesList -> do
        case lookup funcName funcs of
            Just (Func _ params _ cmds) -> do
                args <- mapM (interpExp env) (expListToList expList)
                let localEnv = extendEnvWithParams env params args
                (vars', _, _) <- interpCommandList localEnv cmds
                let returnValues = case lookup "return" vars' of
                        Just (VArray values) -> values
                        Just value -> [value]
                        Nothing -> []
                env' <- assignReturnValues env lvaluesList returnValues
                return env'
            Nothing -> do
                putStrLn $ "Function '" ++ funcName ++ "' not found."
                return env

    CBlock CommandListEmpty -> return env
    CBlock (CommandList cmd cmds) -> do
        env' <- interpCommand env cmd
        interpCommandList env' cmds

    CIf exp cmd -> do
        VBool cond <- interpExp env exp
        if cond
            then interpCommand env cmd
            else return env

    CIfElse exp cmdThen cmdElse -> do
        VBool cond <- interpExp env exp
        if cond
            then interpCommand env cmdThen
            else interpCommand env cmdElse

    CLvalueAssign lvalue exp -> do
        v <- interpExp env exp
        env' <- assignLvalue env lvalue v
        return env'

    CReturn exp expListTail -> do
        values <- mapM (interpExp env) (exp : expListTailToList expListTail)
        let env' = (("return", VArray values) : vars, funcs, datas)
        return env'

    CIterate exp cmd -> do
        VBool cond <- interpExp env exp
        if cond
            then do
                env' <- interpCommand env cmd
                interpCommand env' (CIterate exp cmd)
            else return env

    CRead lval -> do
        input <- getLine
        newVal <- parseInput input 
        env' <- assignLvalue env lval newVal
        return env'

-- Interpretation of expressions

interpExp :: Env -> Exp -> IO Value
interpExp env@(_, funcs, _) exp = case exp of
    EInt n -> return (VInt n)
    ENull -> return VNull
    EFloat n -> return (VFloat n)
    ELiteralChar lc -> return (VLiteralChar lc)
    ELvalue lvalue -> interpLvalue env lvalue

    EPlus e1 e2 -> do
        v1 <- interpExp env e1
        v2 <- interpExp env e2
        case (v1, v2) of
            (VInt n1, VInt n2) -> return (VInt (n1 + n2))
            (VFloat f1, VFloat f2) -> return (VFloat (f1 + f2))
            _ -> return VNull

    EMinus e1 e2 -> do
        v1 <- interpExp env e1
        v2 <- interpExp env e2
        case (v1, v2) of
            (VInt n1, VInt n2) -> return (VInt (n1 - n2))
            (VFloat f1, VFloat f2) -> return (VFloat (f1 - f2))
            _ -> return VNull

    ETimes e1 e2 -> do
        v1 <- interpExp env e1
        v2 <- interpExp env e2
        case (v1, v2) of
            (VInt n1, VInt n2) -> return (VInt (n1 * n2))
            (VFloat f1, VFloat f2) -> return (VFloat (f1 * f2))
            _ -> return VNull

    EDivide e1 e2 -> do
        v1 <- interpExp env e1
        v2 <- interpExp env e2
        case (v1, v2) of
            (VInt n1, VInt n2) -> if n2 == 0 then do
                                      putStrLn "Division by zero"
                                      return VNull
                                  else return (VInt (div n1 n2))
            (VFloat f1, VFloat f2) -> if f2 == 0 then do
                                          putStrLn "Division by zero"
                                          return VNull
                                      else return (VFloat (f1 / f2))
            _ -> return VNull

    EGT e1 e2 -> do
        VInt n1 <- interpExp env e1
        VInt n2 <- interpExp env e2
        return (VBool (n1 > n2))

    ELT e1 e2 -> do
        VInt n1 <- interpExp env e1
        VInt n2 <- interpExp env e2
        return (VBool (n1 < n2))

    EEqual e1 e2 -> do
        v1 <- interpExp env e1
        v2 <- interpExp env e2
        return (VBool (v1 == v2))

    ENEqual e1 e2 -> do
        v1 <- interpExp env e1
        v2 <- interpExp env e2
        return (VBool (v1 /= v2))

    ECall funcName expList indexExp -> do
        case lookup funcName funcs of
            Just (Func _ params _ cmds) -> do
                args <- mapM (interpExp env) (expListToList expList)
                let localEnv = extendEnvWithParams env params args
                (vars', _, _) <- interpCommandList localEnv cmds
                let returnValues = case lookup "return" vars' of
                        Just (VArray values) -> values
                        Just value -> [value]
                        Nothing -> []
                case indexExp of
                    ENull -> return (VArray returnValues)
                    _ -> do
                        VInt idx <- interpExp env indexExp
                        if idx >= 0 && idx < length returnValues
                            then return (returnValues !! idx)
                            else do
                                putStrLn "Index out of bounds"
                                return VNull
            Nothing -> do
                putStrLn $ "Function '" ++ funcName ++ "' not found."
                return VNull

    ETrue -> return (VBool True)
    EFalse -> return (VBool False)

    EAnd e1 e2 -> do
        VBool b1 <- interpExp env e1
        VBool b2 <- interpExp env e2
        return (VBool (b1 && b2))

    ENot e -> do
        VBool b <- interpExp env e
        return (VBool (not b))

    EMinusExp e -> do
        VInt n <- interpExp env e
        return (VInt (-n))

    ENew tp index -> do
        dims <- evalIndexList env index
        value <- createNewValue env tp dims
        return value

evalIndexList :: Env -> Index -> IO [Int]
evalIndexList _ IndexEmpty = return []
evalIndexList env (Index exp index) = do
    idxVal <- evalIndex env exp 
    rest <- evalIndexList env index
    return (idxVal : rest) 

evalIndex :: Env -> Exp -> IO Int
evalIndex env exp = do
    VInt n <- interpExp env exp
    return n

createNewValue :: Env -> Type -> [Int] -> IO Value
createNewValue env typ [] = defaultValue env typ
createNewValue env typ (dim:dims) = do
    let createElements 0 _ = return []
        createElements n t = do
            val <- createNewValue env t dims
            rest <- createElements (n - 1) t
            return (val : rest)
    elements <- createElements dim typ
    return (VArray elements)

defaultValue :: Env -> Type -> IO Value
defaultValue env@(_, _, datas) typ = case typ of
    BaseType btype -> case btype of
        TTypeInt      -> return (VInt 0)
        TTypeFloat    -> return (VFloat 0.0)
        TTypeBool     -> return (VBool False)
        TTypeChar     -> return (VLiteralChar "a")
        TTypeName t   -> case lookup t datas of 
            Just (Data _ decList) -> do
                fields <- createDataFields env t decList
                return (VData t fields)
            Nothing -> do
                putStrLn $ "Unknown type: " ++ t
                return VNull
    TArray _ -> return (VArray [])

createDataFields :: Env -> String -> DecList -> IO [(String, Value)]
createDataFields _ _ DeclEmpty = return []
createDataFields env dataTypeName (DecList (Decl name typ) decs) = do
    val <- case typ of
        BaseType (TTypeName t) | t == dataTypeName -> return VNull
        _ -> defaultValue env typ
    rest <- createDataFields env dataTypeName decs
    return ((name, val) : rest)

printValue :: Value -> IO ()
printValue (VInt n) = putStrLn (show n)
printValue (VFloat n) = putStrLn (show n)
printValue (VLiteralChar vc) = putStrLn vc
printValue VNull = putStrLn "NULL"
printValue (VBool bool) = putStrLn (show bool)
printValue (VArray [v]) = printValue v
printValue (VArray vals) = do
    printValueInline (VArray vals) 
    putStrLn ""                   
printValue (VData dataName fields) = do
    printValueInline (VData dataName fields) 
    putStrLn ""                             

printValueInline :: Value -> IO ()
printValueInline (VArray []) = putStr "[]"
printValueInline (VArray vals) = do
    putStr "["
    case vals of
        [v] -> printValueInline v >> putStr "]"
        (v:vs) -> do
            printValueInline v
            mapM_ (\val -> putStr ", " >> printValueInline val) vs
            putStr "]"
printValueInline (VData dataName fields) = do
    putStr (dataName ++ " {")
    printFieldsInline fields 
    putStr "}"

printValueInline (VInt n) = putStr (show n)
printValueInline (VFloat n) = putStr (show n)
printValueInline (VLiteralChar vc) = putStr vc
printValueInline VNull = putStr "NULL"
printValueInline (VBool bool) = putStr (show bool)

printFieldsInline :: [(String, Value)] -> IO ()
printFieldsInline [] = return ()
printFieldsInline [(name, val)] = do
    putStr (name ++ " = ")
    printValueInline val
printFieldsInline ((name, val):rest) = do
    putStr (name ++ " = ")
    printValueInline val
    putStr ", "
    printFieldsInline rest

interpLvalue :: Env -> Lvalue -> IO Value
interpLvalue (vars, _, _) (LvalueId varName) = 
    case lookup varName vars of
        Just val -> return val
        Nothing -> do
            putStrLn $ "Variable '" ++ varName ++ "' not found"
            return VNull
interpLvalue env (LvalueArray lval indexExp) = do
    VInt idx <- interpExp env indexExp
    VArray arr <- interpLvalue env lval
    if idx >= 0 && idx < length arr then
        return (arr !! idx)
    else
        return VNull
interpLvalue env (LvalueDot lval fieldName) = do
    VData _ fields <- interpLvalue env lval
    case lookup fieldName fields of
        Just fieldVal -> return fieldVal
        Nothing -> do
            putStrLn $ "Field '" ++ fieldName ++ "' not found in the object"
            return VNull

extendEnvWithParams :: Env -> ParamsList -> [Value] -> Env
extendEnvWithParams (_, funcs, datas) params args =
    let paramVars = zip (paramsListToNames params) args
    in (paramVars, funcs, datas)

paramsListToNames :: ParamsList -> [String]
paramsListToNames ParamsListEmpty = []
paramsListToNames (ParamsList (Param name _) tail) = name : paramsTailToNames tail

paramsTailToNames :: ParamsTail -> [String]
paramsTailToNames ParamsTailEmpty = []
paramsTailToNames (ParamsTail (Param name _) tail) = name : paramsTailToNames tail

expListToList :: ExpList -> [Exp]
expListToList ExpListEmpty = []
expListToList (ExpList e tail) = e : expListTailToList tail

expListTailToList :: ExpListTail -> [Exp]
expListTailToList ExpListTailEmpty = []
expListTailToList (ExpListTail e tail) = e : expListTailToList tail

assignLvalue :: Env -> Lvalue -> Value -> IO Env
assignLvalue env (LvalueDot lval fieldName) newVal = do
    VData dataName fields <- interpLvalue env lval
    let updatedFields = (fieldName, newVal) : filter ((/= fieldName) . fst) fields
    let updatedVal = VData dataName updatedFields
    assignLvalue env lval updatedVal
assignLvalue env (LvalueId varName) newVal = do
    let (vars, funcs, datas) = env
        vars' = (varName, newVal) : filter ((/= varName) . fst) vars
    return (vars', funcs, datas)
assignLvalue env (LvalueArray lval indexExp) newVal = do
    VInt idx <- interpExp env indexExp
    VArray arr <- interpLvalue env lval
    let newArr = take idx arr ++ [newVal] ++ drop (idx + 1) arr
    assignLvalue env lval (VArray newArr)

parseInput :: String -> IO Value
parseInput input
    | map toLower input == "null"  = return VNull
    | map toLower input == "true"  = return (VBool True)
    | map toLower input == "false" = return (VBool False)
    | Just n <- readMaybe input :: Maybe Int    = return (VInt n)
    | Just f <- readMaybe input :: Maybe Double = return (VFloat f)
    | length input == 1 = return (VLiteralChar input)
    | otherwise = do
        putStrLn "Invalid input for the language."
        return VNull

assignReturnValues :: Env -> LvaluesList -> [Value] -> IO Env
assignReturnValues env lvalues values = assignReturnValuesHelper env (lvaluesToList lvalues) values

assignReturnValuesHelper :: Env -> [Lvalue] -> [Value] -> IO Env
assignReturnValuesHelper env [] [] = return env
assignReturnValuesHelper env (lv:lvs) (val:vals) = do
    env' <- assignLvalue env lv val
    assignReturnValuesHelper env' lvs vals
assignReturnValuesHelper env _ _ = return env 

lvaluesToList :: LvaluesList -> [Lvalue]
lvaluesToList LvaluesListEmpty = []
lvaluesToList (LvaluesList lvalue tail) = lvalue : lvaluesTailToList tail

lvaluesTailToList :: LvaluesListTail -> [Lvalue]
lvaluesTailToList LvaluesListTailEmpty = []
lvaluesTailToList (LvaluesListTail lvalue tail) = lvalue : lvaluesTailToList tail
