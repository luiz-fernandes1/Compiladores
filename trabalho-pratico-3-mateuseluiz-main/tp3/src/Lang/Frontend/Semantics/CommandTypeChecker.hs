module Lang.Frontend.Semantics.CommandTypeChecker where

import Lang.Frontend.Semantics.ExpTypeChecker
import Lang.Syntax.Syntax
import Lang.Frontend.Semantics.Basics
import Control.Monad (foldM)

tcProgram :: Program -> Check ()
tcProgram (Program defs) = do
    initialCtx <- tcDefList ([], [], []) defs
    let (_, funcs, _) = initialCtx
    if any (\(name, _) -> name == "main") funcs
        then do
            _ <- tcAnalyzeCommands initialCtx defs
            return ()
        else Left [MainFunctionNotDefined]

tcDefList :: Ctx -> DefList -> Check Ctx
tcDefList ctx DefListEmpty = Right ctx
tcDefList ctx (DefList def defs) = do
    updatedCtx <- tcDef ctx def
    tcDefList updatedCtx defs

tcDef :: Ctx -> Def -> Check Ctx
tcDef ctx@(vars, funcs, datas) def = case def of
    DefFunc (Func name params returnTypes _) -> do
        paramTypes <- processParams params
        returnTypes' <- processReturnTypes returnTypes
        let funcType = FuncType paramTypes returnTypes'
        if name `elem` map fst funcs
            then Left [FunctionAlreadyDefined name]
            else do
                let funcs' = (name, funcType) : funcs
                return (vars, funcs', datas)
    DefData (Data name decList) -> do
        let partialDatas = (name, DataType []) : datas
        fields <- decListToFields (vars, funcs, partialDatas) decList
        let dataType = DataType fields
        if name `elem` map fst datas
            then Left [DataTypeAlreadyDefined name]
            else return (vars, funcs, (name, dataType) : datas)
  where
    processParams :: ParamsList -> Check [Type]
    processParams paramsList = case paramsList of
        ParamsListEmpty -> Right []
        ParamsList (Param _ ty) paramsTail -> do
            ty' <- typeOf ctx ty
            tailTypes <- processParamsTail paramsTail
            return (ty' : tailTypes)

    processParamsTail :: ParamsTail -> Check [Type]
    processParamsTail paramsTail = case paramsTail of
        ParamsTailEmpty -> Right []
        ParamsTail (Param _ ty) tailParamsTail -> do
            ty' <- typeOf ctx ty
            tailTypes <- processParamsTail tailParamsTail
            return (ty' : tailTypes)

    processReturnTypes :: ReturnTypeList -> Check [Type]
    processReturnTypes returnList = case returnList of
        ReturnTypeListEmpty -> Right []
        ReturnTypeList ty returnTail -> do
            ty' <- typeOf ctx ty
            tailReturnTypes <- processReturnTypeTail returnTail
            return (ty' : tailReturnTypes)

    processReturnTypeTail :: ReturnTypeTail -> Check [Type]
    processReturnTypeTail returnTail = case returnTail of
        ReturnTypeTailEmpty -> Right []
        ReturnTypeTail ty tailReturnTail -> do
            ty' <- typeOf ctx ty
            tailTypes <- processReturnTypeTail tailReturnTail
            return (ty' : tailTypes)

    decListToFields :: Ctx -> DecList -> Check [(String, Type)]
    decListToFields _ DeclEmpty = Right []
    decListToFields currentCtx (DecList (Decl name typ) rest) = do
        ty' <- typeOf currentCtx typ
        fields <- decListToFields currentCtx rest
        return ((name, ty') : fields)

tcAnalyzeCommands :: Ctx -> DefList -> Check Ctx
tcAnalyzeCommands ctx DefListEmpty = Right ctx
tcAnalyzeCommands ctx (DefList def defs) = case def of
    DefFunc (Func name params _ cmds) -> do
        let (_, funcs, datas) = ctx
        if name == "main"
            then do
                ctxWithParams <- addParamsToCtx ctx params
                updatedCtx <- tcCommandList ctxWithParams name cmds
                tcAnalyzeCommands updatedCtx defs  
            else do
                ctxWithParams <- addParamsToCtx ([], funcs, datas) params
                _ <- tcCommandList ctxWithParams name cmds
                tcAnalyzeCommands ctx defs 
    DefData _ -> tcAnalyzeCommands ctx defs
  where
    addParamsToCtx :: Ctx -> ParamsList -> Check Ctx
    addParamsToCtx (vars, funcs, datas) paramsList = do
        params <- extractParams (vars, funcs, datas) paramsList
        let newVars = params ++ vars
        return (newVars, funcs, datas)

    extractParams :: Ctx -> ParamsList -> Check [(String, Type)]
    extractParams _ ParamsListEmpty = Right []
    extractParams currentCtx (ParamsList (Param name ty) paramsTail) = do
        ty' <- typeOf currentCtx ty
        rest <- extractParamsTail currentCtx paramsTail
        return ((name, ty') : rest)

    extractParamsTail :: Ctx -> ParamsTail -> Check [(String, Type)]
    extractParamsTail _ ParamsTailEmpty = Right []
    extractParamsTail currentCtx (ParamsTail (Param name ty) tailParamsTail) = do
        ty' <- typeOf currentCtx ty
        rest <- extractParamsTail currentCtx tailParamsTail
        return ((name, ty') : rest)

tcCommandList :: Ctx -> String -> CommandList -> Check Ctx
tcCommandList ctx _ CommandListEmpty = Right ctx
tcCommandList ctx funcName (CommandList cmd cmds) = do
    updatedCtx <- tcCommand ctx funcName cmd
    tcCommandList updatedCtx funcName cmds

tcCommand :: Ctx -> String -> Command -> Check Ctx
tcCommand ctx@(vars, funcs, datas) funcName cmd = case cmd of
    CPrint e -> do
        _ <- tcExp ctx e
        Right ctx
    CIf e c -> do
        ty <- tcExp ctx e
        if ty == BaseType TTypeBool
            then tcCommand ctx funcName c
            else Left [IncompatibleTypes (BaseType TTypeBool) ty]
    CIfElse e c1 c2 -> do
        ty <- tcExp ctx e
        if ty == BaseType TTypeBool
            then do
                _ <- tcCommand ctx funcName c1
                _ <- tcCommand ctx funcName c2
                Right ctx
            else Left [IncompatibleTypes (BaseType TTypeBool) ty]
    CIterate e c -> do
        ty <- tcExp ctx e
        if ty == BaseType TTypeBool
            then tcCommand ctx funcName c
            else Left [IncompatibleTypes (BaseType TTypeBool) ty]
    CLvalueAssign lval e -> do
        ety <- tcExp ctx e
        case lval of
            LvalueId name -> do
                case lookup name vars of
                    Just lty ->
                        if lty == ety
                            then Right ctx
                            else Left [IncompatibleTypes lty ety]
                    Nothing -> do
                        let vars' = (name, ety) : vars
                        Right (vars', funcs, datas)
            _ -> do
                lty <- tcLvalue ctx lval
                if lty == ety
                    then Right ctx
                    else Left [IncompatibleTypes lty ety]
    CCall funcName' expList lvaluesList -> do
        returnTypes <- tcFunctionCall ctx funcName' expList
        let lvalues = lvaluesListToList lvaluesList
        if length lvalues /= length returnTypes
            then Left [IncorrectNumberOfReturnValues funcName']
            else do
                ctx' <- foldM checkAndAssignType ctx (zip lvalues returnTypes)
                Right ctx'
      where
        checkAndAssignType :: Ctx -> (Lvalue, Type) -> Check Ctx
        checkAndAssignType ctxAcc (lval, retType) = do
            lty <- tcLvalue ctxAcc lval
            if lty == retType
                then Right ctxAcc
                else Left [IncompatibleTypes lty retType]
    CBlock cmds -> tcCommandList ctx funcName cmds
    CReturn e expListTail -> do
        expectedReturnTypes <- getCurrentFunctionReturnTypes ctx funcName
        let expressions = e : expListTailToList expListTail
        if length expressions /= length expectedReturnTypes
            then Left [IncorrectNumberOfReturnValues funcName]
            else do
                exprTypes <- mapM (tcExp ctx) expressions
                checkReturnTypes expectedReturnTypes exprTypes
                Right ctx
      where
        checkReturnTypes :: [Type] -> [Type] -> Check ()
        checkReturnTypes [] [] = Right ()
        checkReturnTypes (expected:expectedRest) (actual:actualRest)
            | expected == actual = checkReturnTypes expectedRest actualRest
            | otherwise = Left [IncompatibleTypes expected actual]
        checkReturnTypes _ _ = Left [IncorrectNumberOfReturnValues funcName]
    CRead lval -> do
        lty <- tcLvalue ctx lval
        case lty of
            BaseType _ -> Right ctx
            _ -> Left [UnsupportedType lty]

getCurrentFunctionReturnTypes :: Ctx -> String -> Check [Type]
getCurrentFunctionReturnTypes (_, funcs, _) currentFuncName =
    case lookup currentFuncName funcs of
        Just (FuncType _ returnTypes) -> Right returnTypes
        Nothing -> Left [UndefinedFunction currentFuncName]

lvaluesListToList :: LvaluesList -> [Lvalue]
lvaluesListToList LvaluesListEmpty = []
lvaluesListToList (LvaluesList lval lvalTail) = lval : lvaluesTailToList lvalTail

lvaluesTailToList :: LvaluesListTail -> [Lvalue]
lvaluesTailToList LvaluesListTailEmpty = []
lvaluesTailToList (LvaluesListTail lval lvalTail) = lval : lvaluesTailToList lvalTail

expListToList :: ExpList -> [Exp]
expListToList ExpListEmpty = []
expListToList (ExpList e expTail) = e : expListTailToList expTail

expListTailToList :: ExpListTail -> [Exp]
expListTailToList ExpListTailEmpty = []
expListTailToList (ExpListTail e expTail) = e : expListTailToList expTail
