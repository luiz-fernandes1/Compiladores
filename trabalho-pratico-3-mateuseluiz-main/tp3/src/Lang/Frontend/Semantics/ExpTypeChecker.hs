module Lang.Frontend.Semantics.ExpTypeChecker where

import Lang.Syntax.Syntax
import Lang.Frontend.Semantics.Basics

tcExp :: Ctx -> Exp -> Check Type
tcExp ctx e = case e of
    EInt _          -> Right (BaseType TTypeInt)
    EFloat _        -> Right (BaseType TTypeFloat)
    ETrue           -> Right (BaseType TTypeBool)
    EFalse          -> Right (BaseType TTypeBool)
    ELiteralChar _  -> Right (BaseType TTypeChar)
    ENull           -> Right (BaseType (TTypeName "Null"))
    EPlus e1 e2     -> tcArithOp ctx e1 e2
    EMinus e1 e2    -> tcArithOp ctx e1 e2
    ETimes e1 e2    -> tcArithOp ctx e1 e2
    EDivide e1 e2   -> tcArithOp ctx e1 e2
    EMod e1 e2      -> tcArithOp ctx e1 e2
    EAnd e1 e2      -> tcBoolOp ctx e1 e2
    ENot e1         -> do
        ty <- tcExp ctx e1
        if ty == BaseType TTypeBool
            then Right (BaseType TTypeBool)
            else Left [IncompatibleTypes (BaseType TTypeBool) ty]
    ELT e1 e2       -> tcCompOp ctx e1 e2
    EGT e1 e2       -> tcCompOp ctx e1 e2
    EEqual e1 e2    -> tcEqualityOp ctx e1 e2
    ENEqual e1 e2   -> tcEqualityOp ctx e1 e2
    EMinusExp e1    -> do
        ty <- tcExp ctx e1
        if ty == BaseType TTypeInt || ty == BaseType TTypeFloat
            then Right ty
            else Left [IncompatibleTypes (BaseType TTypeInt) ty]
    ELvalue lval    -> tcLvalue ctx lval
    EParen e1       -> tcExp ctx e1
    ENew t i        -> do
        ty <- typeOf ctx t
        _ <- evalIndexList ctx i
        let numDims = countIndices i
        return (createArrayType ty numDims)
      where
        evalIndexList :: Ctx -> Index -> Check ()
        evalIndexList _ IndexEmpty = Right ()
        evalIndexList ctxEval (Index ex rest) = do
            ty <- tcExp ctxEval ex
            if ty == BaseType TTypeInt
                then evalIndexList ctxEval rest
                else Left [IncompatibleTypes (BaseType TTypeInt) ty]

        countIndices :: Index -> Int
        countIndices IndexEmpty = 0
        countIndices (Index _ rest) = 1 + countIndices rest

        createArrayType :: Type -> Int -> Type
        createArrayType ty 0 = ty
        createArrayType ty n = TArray (createArrayType ty (n - 1))
    ECall funcName expList expIdx -> do
        tys <- tcFunctionCall ctx funcName expList
        if null tys
            then Left [NoReturnValueAccessError funcName]
        else do
            idxType <- tcExp ctx expIdx
            if idxType == BaseType TTypeInt
                then case expIdx of
                    EInt n ->
                        if n >= 0 && n < length tys
                            then Right (tys !! n)
                            else Left [OutOfBoundsError n (length tys)]
                    _ -> Right (TArray (head tys)) 
                else Left [IncompatibleTypes (BaseType TTypeInt) idxType]

tcArithOp :: Ctx -> Exp -> Exp -> Check Type
tcArithOp ctx e1 e2 = do
    ty1 <- tcExp ctx e1
    ty2 <- tcExp ctx e2
    if ty1 == ty2 && (ty1 == BaseType TTypeInt || ty1 == BaseType TTypeFloat)
        then Right ty1
        else Left [IncompatibleTypes ty1 ty2]

tcBoolOp :: Ctx -> Exp -> Exp -> Check Type
tcBoolOp ctx e1 e2 = do
    ty1 <- tcExp ctx e1
    ty2 <- tcExp ctx e2
    if ty1 == BaseType TTypeBool && ty2 == BaseType TTypeBool
        then Right (BaseType TTypeBool)
        else Left [IncompatibleTypes ty1 ty2]

tcCompOp :: Ctx -> Exp -> Exp -> Check Type
tcCompOp ctx e1 e2 = do
    ty1 <- tcExp ctx e1
    ty2 <- tcExp ctx e2
    if ty1 == ty2 && (ty1 == BaseType TTypeInt || ty1 == BaseType TTypeFloat)
        then Right (BaseType TTypeBool)
        else Left [IncompatibleTypes ty1 ty2]

tcEqualityOp :: Ctx -> Exp -> Exp -> Check Type
tcEqualityOp ctx e1 e2 = do
    ty1 <- tcExp ctx e1
    ty2 <- tcExp ctx e2
    if ty1 == ty2
        then Right (BaseType TTypeBool)
        else Left [IncompatibleTypes ty1 ty2]

tcLvalue :: Ctx -> Lvalue -> Check Type
tcLvalue ctx@(vars, _, datas) lval = case lval of
    LvalueId name -> case lookup name vars of
        Just varType -> Right varType
        Nothing -> Left [UndefinedVariable name]
    LvalueArray lv e -> do
        ty <- tcLvalue ctx lv
        idxTy <- tcExp ctx e 
        if idxTy == BaseType TTypeInt
            then case ty of
                TArray t -> Right t
                _ -> Left [UnsupportedType ty]
            else Left [IncompatibleTypes (BaseType TTypeInt) idxTy]
    LvalueDot lv field -> do
        ty <- tcLvalue ctx lv
        case ty of
            BaseType (TTypeName name) -> case lookup name datas of
                Just (DataType fields) -> case lookup field fields of
                    Just fieldTy -> Right fieldTy
                    Nothing -> Left [UndefinedVariable field]
                Nothing -> Left [UndefinedVariable name]
            _ -> Left [UnsupportedType ty]

tcFunctionCall :: Ctx -> String -> ExpList -> Check [Type]
tcFunctionCall ctx@(_, funcs, _) funcName args = do
    case lookup funcName funcs of
        Just (FuncType paramTypes returnTypes) -> do
            argTypes <- tcExpList ctx args
            if length argTypes /= length paramTypes
                then Left [IncorrectNumberOfArguments funcName]
                else do
                    let typeChecks = zipWith (\argTy paramTy -> if argTy == paramTy then Right () else Left [IncompatibleTypes paramTy argTy]) argTypes paramTypes
                    sequence_ typeChecks
                    Right returnTypes
        Nothing -> Left [UndefinedFunction funcName]

tcExpList :: Ctx -> ExpList -> Check [Type]
tcExpList _ ExpListEmpty = Right []
tcExpList ctx (ExpList e expTail) = do
    ty <- tcExp ctx e
    tys <- tcExpListTail ctx expTail
    return (ty : tys)

tcExpListTail :: Ctx -> ExpListTail -> Check [Type]
tcExpListTail _ ExpListTailEmpty = Right []
tcExpListTail ctx (ExpListTail e expTail) = do
    ty <- tcExp ctx e
    tys <- tcExpListTail ctx expTail
    return (ty : tys)
