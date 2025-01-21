{-# OPTIONS_GHC -w #-}
module Lang.Frontend.Parser.Parser (parser) where

import Lang.Frontend.Lexer.Lexer
import Lang.Syntax.Syntax
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,369) ([0,0,8,0,32,0,1024,0,4096,0,0,0,0,0,0,256,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,1024,0,0,0,0,0,0,0,0,0,0,16,0,0,2,0,0,0,0,0,0,0,0,0,512,0,0,0,16,0,0,4096,0,0,0,32768,0,0,0,0,0,0,31,0,16384,0,0,0,0,0,0,0,0,0,0,1024,0,0,256,0,0,0,0,0,256,0,0,1,0,0,0,0,0,62,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,256,0,0,0,0,0,496,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,4097,0,0,7696,32,32768,0,0,0,0,0,0,0,33,0,0,0,0,0,0,0,0,4,0,0,61568,256,0,4,0,512,16386,0,0,0,16,0,0,32768,2113,49672,131,0,0,0,16384,0,24576,528,61570,32,0,0,1,0,0,57600,513,0,8,0,16384,0,0,0,0,0,0,0,0,0,0,248,0,0,0,0,0,0,16384,1024,0,0,4192,33282,8432,0,0,2048,0,0,0,33816,8320,2108,0,0,61440,367,0,0,0,16386,0,0,0,0,0,0,0,0,0,0,0,0,0,15872,0,24576,528,61570,32,0,2096,16641,4216,0,6144,32900,15392,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,33,4,0,0,0,0,0,0,16384,24544,2,0,3072,16450,7696,4,0,8454,2080,527,0,33536,4112,1924,1,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,607,0,0,8192,12272,1,0,0,63552,151,0,0,0,0,0,0,16768,2056,33730,0,49152,1056,57604,65,0,4192,33282,8432,0,12288,264,30785,16,0,33816,8320,2108,0,3072,16450,7696,4,0,8454,2080,527,0,33536,4112,1924,1,32768,2113,49672,131,0,8384,1028,16865,0,0,0,0,0,0,2096,16641,4216,0,0,0,0,0,0,0,160,1,0,0,63552,151,0,0,0,1,0,0,0,4,0,0,49152,1056,57604,65,0,0,32644,9,0,0,0,0,0,0,0,57312,2,0,0,128,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,3848,16,16384,0,0,32768,2943,0,0,0,0,0,0,0,0,0,0,0,16908,4168,1054,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,4351,0,0,0,1920,8,0,0,49152,1027,0,0,0,6624,2,0,0,61440,268,0,0,0,0,0,0,0,10240,64,0,0,0,0,0,0,0,2560,16,0,33792,2055,0,32,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,512,0,0,0,0,19454,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,16,0,0,32776,1,0,0,0,0,0,0,0,2,0,0,33536,4112,1924,1,4096,8222,0,128,0,0,0,0,0,0,49152,2431,0,0,0,0,0,0,6144,32900,15392,8,0,0,2048,0,0,0,0,0,2,0,0,12289,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Program","DefList","Def","Data","Func","DecList","Decl","BType","Type","Param","ParamsTail","ParamsList","ReturnTypeList","ReturnTypeTail","CommandList","Command","Exp","ExpList","ExpListTail","Lvalue","LvaluesList","LvaluesListTail","Index","if","else","then","true","false","print","read","return","iterate","data","new","'='","'::'","':'","';'","'('","')'","'{'","'}'","'['","']'","'+'","'*'","'-'","'/'","'=='","'!='","'<'","'>'","'!'","'&&'","','","'.'","'%'","null","literalchar","int","float","typename","typebool","typeint","typefloat","typechar","identifier","%eof"]
        bit_start = st Prelude.* 71
        bit_end = (st Prelude.+ 1) Prelude.* 71
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..70]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (36) = happyShift action_6
action_0 (70) = happyShift action_7
action_0 (4) = happyGoto action_8
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 _ = happyReduce_3

action_1 (36) = happyShift action_6
action_1 (70) = happyShift action_7
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (36) = happyShift action_6
action_3 (70) = happyShift action_7
action_3 (5) = happyGoto action_11
action_3 (6) = happyGoto action_3
action_3 (7) = happyGoto action_4
action_3 (8) = happyGoto action_5
action_3 _ = happyReduce_3

action_4 _ = happyReduce_4

action_5 _ = happyReduce_5

action_6 (65) = happyShift action_10
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (42) = happyShift action_9
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (71) = happyAccept
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (70) = happyShift action_15
action_9 (13) = happyGoto action_13
action_9 (15) = happyGoto action_14
action_9 _ = happyReduce_22

action_10 (44) = happyShift action_12
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_2

action_12 (70) = happyShift action_22
action_12 (9) = happyGoto action_20
action_12 (10) = happyGoto action_21
action_12 _ = happyReduce_9

action_13 (58) = happyShift action_19
action_13 (14) = happyGoto action_18
action_13 _ = happyReduce_20

action_14 (43) = happyShift action_17
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (39) = happyShift action_16
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (65) = happyShift action_31
action_16 (66) = happyShift action_32
action_16 (67) = happyShift action_33
action_16 (68) = happyShift action_34
action_16 (69) = happyShift action_35
action_16 (11) = happyGoto action_29
action_16 (12) = happyGoto action_30
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (40) = happyShift action_28
action_17 (16) = happyGoto action_27
action_17 _ = happyReduce_24

action_18 _ = happyReduce_21

action_19 (70) = happyShift action_15
action_19 (13) = happyGoto action_26
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (45) = happyShift action_25
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (70) = happyShift action_22
action_21 (9) = happyGoto action_24
action_21 (10) = happyGoto action_21
action_21 _ = happyReduce_9

action_22 (39) = happyShift action_23
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (65) = happyShift action_31
action_23 (66) = happyShift action_32
action_23 (67) = happyShift action_33
action_23 (68) = happyShift action_34
action_23 (69) = happyShift action_35
action_23 (11) = happyGoto action_29
action_23 (12) = happyGoto action_40
action_23 _ = happyFail (happyExpListPerState 23)

action_24 _ = happyReduce_8

action_25 _ = happyReduce_6

action_26 (58) = happyShift action_19
action_26 (14) = happyGoto action_39
action_26 _ = happyReduce_20

action_27 (44) = happyShift action_38
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (65) = happyShift action_31
action_28 (66) = happyShift action_32
action_28 (67) = happyShift action_33
action_28 (68) = happyShift action_34
action_28 (69) = happyShift action_35
action_28 (11) = happyGoto action_29
action_28 (12) = happyGoto action_37
action_28 _ = happyFail (happyExpListPerState 28)

action_29 _ = happyReduce_16

action_30 (46) = happyShift action_36
action_30 _ = happyReduce_18

action_31 _ = happyReduce_15

action_32 _ = happyReduce_14

action_33 _ = happyReduce_11

action_34 _ = happyReduce_12

action_35 _ = happyReduce_13

action_36 (47) = happyShift action_54
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (46) = happyShift action_36
action_37 (58) = happyShift action_53
action_37 (17) = happyGoto action_52
action_37 _ = happyReduce_26

action_38 (27) = happyShift action_45
action_38 (32) = happyShift action_46
action_38 (33) = happyShift action_47
action_38 (34) = happyShift action_48
action_38 (35) = happyShift action_49
action_38 (44) = happyShift action_50
action_38 (70) = happyShift action_51
action_38 (18) = happyGoto action_42
action_38 (19) = happyGoto action_43
action_38 (23) = happyGoto action_44
action_38 _ = happyReduce_28

action_39 _ = happyReduce_19

action_40 (41) = happyShift action_41
action_40 (46) = happyShift action_36
action_40 _ = happyFail (happyExpListPerState 40)

action_41 _ = happyReduce_10

action_42 (45) = happyShift action_80
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (27) = happyShift action_45
action_43 (32) = happyShift action_46
action_43 (33) = happyShift action_47
action_43 (34) = happyShift action_48
action_43 (35) = happyShift action_49
action_43 (44) = happyShift action_50
action_43 (70) = happyShift action_51
action_43 (18) = happyGoto action_79
action_43 (19) = happyGoto action_43
action_43 (23) = happyGoto action_44
action_43 _ = happyReduce_28

action_44 (38) = happyShift action_76
action_44 (46) = happyShift action_77
action_44 (59) = happyShift action_78
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (42) = happyShift action_75
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (30) = happyShift action_61
action_46 (31) = happyShift action_62
action_46 (37) = happyShift action_63
action_46 (42) = happyShift action_64
action_46 (50) = happyShift action_65
action_46 (56) = happyShift action_66
action_46 (61) = happyShift action_67
action_46 (62) = happyShift action_68
action_46 (63) = happyShift action_69
action_46 (64) = happyShift action_70
action_46 (70) = happyShift action_71
action_46 (20) = happyGoto action_74
action_46 (23) = happyGoto action_60
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (70) = happyShift action_73
action_47 (23) = happyGoto action_72
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (30) = happyShift action_61
action_48 (31) = happyShift action_62
action_48 (37) = happyShift action_63
action_48 (42) = happyShift action_64
action_48 (50) = happyShift action_65
action_48 (56) = happyShift action_66
action_48 (61) = happyShift action_67
action_48 (62) = happyShift action_68
action_48 (63) = happyShift action_69
action_48 (64) = happyShift action_70
action_48 (70) = happyShift action_71
action_48 (20) = happyGoto action_59
action_48 (23) = happyGoto action_60
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (42) = happyShift action_58
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (27) = happyShift action_45
action_50 (32) = happyShift action_46
action_50 (33) = happyShift action_47
action_50 (34) = happyShift action_48
action_50 (35) = happyShift action_49
action_50 (44) = happyShift action_50
action_50 (70) = happyShift action_51
action_50 (18) = happyGoto action_57
action_50 (19) = happyGoto action_43
action_50 (23) = happyGoto action_44
action_50 _ = happyReduce_28

action_51 (42) = happyShift action_56
action_51 _ = happyReduce_64

action_52 _ = happyReduce_23

action_53 (65) = happyShift action_31
action_53 (66) = happyShift action_32
action_53 (67) = happyShift action_33
action_53 (68) = happyShift action_34
action_53 (69) = happyShift action_35
action_53 (11) = happyGoto action_29
action_53 (12) = happyGoto action_55
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_17

action_55 (46) = happyShift action_36
action_55 (58) = happyShift action_53
action_55 (17) = happyGoto action_108
action_55 _ = happyReduce_26

action_56 (30) = happyShift action_61
action_56 (31) = happyShift action_62
action_56 (37) = happyShift action_63
action_56 (42) = happyShift action_64
action_56 (50) = happyShift action_65
action_56 (56) = happyShift action_66
action_56 (61) = happyShift action_67
action_56 (62) = happyShift action_68
action_56 (63) = happyShift action_69
action_56 (64) = happyShift action_70
action_56 (70) = happyShift action_71
action_56 (20) = happyGoto action_106
action_56 (21) = happyGoto action_107
action_56 (23) = happyGoto action_60
action_56 _ = happyReduce_61

action_57 (45) = happyShift action_105
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (30) = happyShift action_61
action_58 (31) = happyShift action_62
action_58 (37) = happyShift action_63
action_58 (42) = happyShift action_64
action_58 (50) = happyShift action_65
action_58 (56) = happyShift action_66
action_58 (61) = happyShift action_67
action_58 (62) = happyShift action_68
action_58 (63) = happyShift action_69
action_58 (64) = happyShift action_70
action_58 (70) = happyShift action_71
action_58 (20) = happyGoto action_104
action_58 (23) = happyGoto action_60
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (48) = happyShift action_86
action_59 (49) = happyShift action_87
action_59 (50) = happyShift action_88
action_59 (51) = happyShift action_89
action_59 (52) = happyShift action_90
action_59 (53) = happyShift action_91
action_59 (54) = happyShift action_92
action_59 (55) = happyShift action_93
action_59 (57) = happyShift action_94
action_59 (58) = happyShift action_103
action_59 (60) = happyShift action_95
action_59 (22) = happyGoto action_102
action_59 _ = happyReduce_63

action_60 (46) = happyShift action_77
action_60 (59) = happyShift action_78
action_60 _ = happyReduce_43

action_61 _ = happyReduce_40

action_62 _ = happyReduce_41

action_63 (65) = happyShift action_31
action_63 (66) = happyShift action_32
action_63 (67) = happyShift action_33
action_63 (68) = happyShift action_34
action_63 (69) = happyShift action_35
action_63 (11) = happyGoto action_29
action_63 (12) = happyGoto action_101
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (30) = happyShift action_61
action_64 (31) = happyShift action_62
action_64 (37) = happyShift action_63
action_64 (42) = happyShift action_64
action_64 (50) = happyShift action_65
action_64 (56) = happyShift action_66
action_64 (61) = happyShift action_67
action_64 (62) = happyShift action_68
action_64 (63) = happyShift action_69
action_64 (64) = happyShift action_70
action_64 (70) = happyShift action_71
action_64 (20) = happyGoto action_100
action_64 (23) = happyGoto action_60
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (30) = happyShift action_61
action_65 (31) = happyShift action_62
action_65 (37) = happyShift action_63
action_65 (42) = happyShift action_64
action_65 (50) = happyShift action_65
action_65 (56) = happyShift action_66
action_65 (61) = happyShift action_67
action_65 (62) = happyShift action_68
action_65 (63) = happyShift action_69
action_65 (64) = happyShift action_70
action_65 (70) = happyShift action_71
action_65 (20) = happyGoto action_99
action_65 (23) = happyGoto action_60
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (30) = happyShift action_61
action_66 (31) = happyShift action_62
action_66 (37) = happyShift action_63
action_66 (42) = happyShift action_64
action_66 (50) = happyShift action_65
action_66 (56) = happyShift action_66
action_66 (61) = happyShift action_67
action_66 (62) = happyShift action_68
action_66 (63) = happyShift action_69
action_66 (64) = happyShift action_70
action_66 (70) = happyShift action_71
action_66 (20) = happyGoto action_98
action_66 (23) = happyGoto action_60
action_66 _ = happyFail (happyExpListPerState 66)

action_67 _ = happyReduce_44

action_68 _ = happyReduce_42

action_69 _ = happyReduce_38

action_70 _ = happyReduce_39

action_71 (42) = happyShift action_97
action_71 _ = happyReduce_64

action_72 (41) = happyShift action_96
action_72 (46) = happyShift action_77
action_72 (59) = happyShift action_78
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_64

action_74 (41) = happyShift action_85
action_74 (48) = happyShift action_86
action_74 (49) = happyShift action_87
action_74 (50) = happyShift action_88
action_74 (51) = happyShift action_89
action_74 (52) = happyShift action_90
action_74 (53) = happyShift action_91
action_74 (54) = happyShift action_92
action_74 (55) = happyShift action_93
action_74 (57) = happyShift action_94
action_74 (60) = happyShift action_95
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (30) = happyShift action_61
action_75 (31) = happyShift action_62
action_75 (37) = happyShift action_63
action_75 (42) = happyShift action_64
action_75 (50) = happyShift action_65
action_75 (56) = happyShift action_66
action_75 (61) = happyShift action_67
action_75 (62) = happyShift action_68
action_75 (63) = happyShift action_69
action_75 (64) = happyShift action_70
action_75 (70) = happyShift action_71
action_75 (20) = happyGoto action_84
action_75 (23) = happyGoto action_60
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (30) = happyShift action_61
action_76 (31) = happyShift action_62
action_76 (37) = happyShift action_63
action_76 (42) = happyShift action_64
action_76 (50) = happyShift action_65
action_76 (56) = happyShift action_66
action_76 (61) = happyShift action_67
action_76 (62) = happyShift action_68
action_76 (63) = happyShift action_69
action_76 (64) = happyShift action_70
action_76 (70) = happyShift action_71
action_76 (20) = happyGoto action_83
action_76 (23) = happyGoto action_60
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (30) = happyShift action_61
action_77 (31) = happyShift action_62
action_77 (37) = happyShift action_63
action_77 (42) = happyShift action_64
action_77 (50) = happyShift action_65
action_77 (56) = happyShift action_66
action_77 (61) = happyShift action_67
action_77 (62) = happyShift action_68
action_77 (63) = happyShift action_69
action_77 (64) = happyShift action_70
action_77 (70) = happyShift action_71
action_77 (20) = happyGoto action_82
action_77 (23) = happyGoto action_60
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (70) = happyShift action_81
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_27

action_80 _ = happyReduce_7

action_81 _ = happyReduce_66

action_82 (47) = happyShift action_130
action_82 (48) = happyShift action_86
action_82 (49) = happyShift action_87
action_82 (50) = happyShift action_88
action_82 (51) = happyShift action_89
action_82 (52) = happyShift action_90
action_82 (53) = happyShift action_91
action_82 (54) = happyShift action_92
action_82 (55) = happyShift action_93
action_82 (57) = happyShift action_94
action_82 (60) = happyShift action_95
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (41) = happyShift action_129
action_83 (48) = happyShift action_86
action_83 (49) = happyShift action_87
action_83 (50) = happyShift action_88
action_83 (51) = happyShift action_89
action_83 (52) = happyShift action_90
action_83 (53) = happyShift action_91
action_83 (54) = happyShift action_92
action_83 (55) = happyShift action_93
action_83 (57) = happyShift action_94
action_83 (60) = happyShift action_95
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (43) = happyShift action_128
action_84 (48) = happyShift action_86
action_84 (49) = happyShift action_87
action_84 (50) = happyShift action_88
action_84 (51) = happyShift action_89
action_84 (52) = happyShift action_90
action_84 (53) = happyShift action_91
action_84 (54) = happyShift action_92
action_84 (55) = happyShift action_93
action_84 (57) = happyShift action_94
action_84 (60) = happyShift action_95
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_34

action_86 (30) = happyShift action_61
action_86 (31) = happyShift action_62
action_86 (37) = happyShift action_63
action_86 (42) = happyShift action_64
action_86 (50) = happyShift action_65
action_86 (56) = happyShift action_66
action_86 (61) = happyShift action_67
action_86 (62) = happyShift action_68
action_86 (63) = happyShift action_69
action_86 (64) = happyShift action_70
action_86 (70) = happyShift action_71
action_86 (20) = happyGoto action_127
action_86 (23) = happyGoto action_60
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (30) = happyShift action_61
action_87 (31) = happyShift action_62
action_87 (37) = happyShift action_63
action_87 (42) = happyShift action_64
action_87 (50) = happyShift action_65
action_87 (56) = happyShift action_66
action_87 (61) = happyShift action_67
action_87 (62) = happyShift action_68
action_87 (63) = happyShift action_69
action_87 (64) = happyShift action_70
action_87 (70) = happyShift action_71
action_87 (20) = happyGoto action_126
action_87 (23) = happyGoto action_60
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (30) = happyShift action_61
action_88 (31) = happyShift action_62
action_88 (37) = happyShift action_63
action_88 (42) = happyShift action_64
action_88 (50) = happyShift action_65
action_88 (56) = happyShift action_66
action_88 (61) = happyShift action_67
action_88 (62) = happyShift action_68
action_88 (63) = happyShift action_69
action_88 (64) = happyShift action_70
action_88 (70) = happyShift action_71
action_88 (20) = happyGoto action_125
action_88 (23) = happyGoto action_60
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (30) = happyShift action_61
action_89 (31) = happyShift action_62
action_89 (37) = happyShift action_63
action_89 (42) = happyShift action_64
action_89 (50) = happyShift action_65
action_89 (56) = happyShift action_66
action_89 (61) = happyShift action_67
action_89 (62) = happyShift action_68
action_89 (63) = happyShift action_69
action_89 (64) = happyShift action_70
action_89 (70) = happyShift action_71
action_89 (20) = happyGoto action_124
action_89 (23) = happyGoto action_60
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (30) = happyShift action_61
action_90 (31) = happyShift action_62
action_90 (37) = happyShift action_63
action_90 (42) = happyShift action_64
action_90 (50) = happyShift action_65
action_90 (56) = happyShift action_66
action_90 (61) = happyShift action_67
action_90 (62) = happyShift action_68
action_90 (63) = happyShift action_69
action_90 (64) = happyShift action_70
action_90 (70) = happyShift action_71
action_90 (20) = happyGoto action_123
action_90 (23) = happyGoto action_60
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (30) = happyShift action_61
action_91 (31) = happyShift action_62
action_91 (37) = happyShift action_63
action_91 (42) = happyShift action_64
action_91 (50) = happyShift action_65
action_91 (56) = happyShift action_66
action_91 (61) = happyShift action_67
action_91 (62) = happyShift action_68
action_91 (63) = happyShift action_69
action_91 (64) = happyShift action_70
action_91 (70) = happyShift action_71
action_91 (20) = happyGoto action_122
action_91 (23) = happyGoto action_60
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (30) = happyShift action_61
action_92 (31) = happyShift action_62
action_92 (37) = happyShift action_63
action_92 (42) = happyShift action_64
action_92 (50) = happyShift action_65
action_92 (56) = happyShift action_66
action_92 (61) = happyShift action_67
action_92 (62) = happyShift action_68
action_92 (63) = happyShift action_69
action_92 (64) = happyShift action_70
action_92 (70) = happyShift action_71
action_92 (20) = happyGoto action_121
action_92 (23) = happyGoto action_60
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (30) = happyShift action_61
action_93 (31) = happyShift action_62
action_93 (37) = happyShift action_63
action_93 (42) = happyShift action_64
action_93 (50) = happyShift action_65
action_93 (56) = happyShift action_66
action_93 (61) = happyShift action_67
action_93 (62) = happyShift action_68
action_93 (63) = happyShift action_69
action_93 (64) = happyShift action_70
action_93 (70) = happyShift action_71
action_93 (20) = happyGoto action_120
action_93 (23) = happyGoto action_60
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (30) = happyShift action_61
action_94 (31) = happyShift action_62
action_94 (37) = happyShift action_63
action_94 (42) = happyShift action_64
action_94 (50) = happyShift action_65
action_94 (56) = happyShift action_66
action_94 (61) = happyShift action_67
action_94 (62) = happyShift action_68
action_94 (63) = happyShift action_69
action_94 (64) = happyShift action_70
action_94 (70) = happyShift action_71
action_94 (20) = happyGoto action_119
action_94 (23) = happyGoto action_60
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (30) = happyShift action_61
action_95 (31) = happyShift action_62
action_95 (37) = happyShift action_63
action_95 (42) = happyShift action_64
action_95 (50) = happyShift action_65
action_95 (56) = happyShift action_66
action_95 (61) = happyShift action_67
action_95 (62) = happyShift action_68
action_95 (63) = happyShift action_69
action_95 (64) = happyShift action_70
action_95 (70) = happyShift action_71
action_95 (20) = happyGoto action_118
action_95 (23) = happyGoto action_60
action_95 _ = happyFail (happyExpListPerState 95)

action_96 _ = happyReduce_33

action_97 (30) = happyShift action_61
action_97 (31) = happyShift action_62
action_97 (37) = happyShift action_63
action_97 (42) = happyShift action_64
action_97 (50) = happyShift action_65
action_97 (56) = happyShift action_66
action_97 (61) = happyShift action_67
action_97 (62) = happyShift action_68
action_97 (63) = happyShift action_69
action_97 (64) = happyShift action_70
action_97 (70) = happyShift action_71
action_97 (20) = happyGoto action_106
action_97 (21) = happyGoto action_117
action_97 (23) = happyGoto action_60
action_97 _ = happyReduce_61

action_98 _ = happyReduce_55

action_99 (49) = happyShift action_87
action_99 (51) = happyShift action_89
action_99 (60) = happyShift action_95
action_99 _ = happyReduce_56

action_100 (43) = happyShift action_116
action_100 (48) = happyShift action_86
action_100 (49) = happyShift action_87
action_100 (50) = happyShift action_88
action_100 (51) = happyShift action_89
action_100 (52) = happyShift action_90
action_100 (53) = happyShift action_91
action_100 (54) = happyShift action_92
action_100 (55) = happyShift action_93
action_100 (57) = happyShift action_94
action_100 (60) = happyShift action_95
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (46) = happyShift action_115
action_101 (26) = happyGoto action_114
action_101 _ = happyReduce_72

action_102 (41) = happyShift action_113
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (30) = happyShift action_61
action_103 (31) = happyShift action_62
action_103 (37) = happyShift action_63
action_103 (42) = happyShift action_64
action_103 (50) = happyShift action_65
action_103 (56) = happyShift action_66
action_103 (61) = happyShift action_67
action_103 (62) = happyShift action_68
action_103 (63) = happyShift action_69
action_103 (64) = happyShift action_70
action_103 (70) = happyShift action_71
action_103 (20) = happyGoto action_112
action_103 (23) = happyGoto action_60
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (43) = happyShift action_111
action_104 (48) = happyShift action_86
action_104 (49) = happyShift action_87
action_104 (50) = happyShift action_88
action_104 (51) = happyShift action_89
action_104 (52) = happyShift action_90
action_104 (53) = happyShift action_91
action_104 (54) = happyShift action_92
action_104 (55) = happyShift action_93
action_104 (57) = happyShift action_94
action_104 (60) = happyShift action_95
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_29

action_106 (48) = happyShift action_86
action_106 (49) = happyShift action_87
action_106 (50) = happyShift action_88
action_106 (51) = happyShift action_89
action_106 (52) = happyShift action_90
action_106 (53) = happyShift action_91
action_106 (54) = happyShift action_92
action_106 (55) = happyShift action_93
action_106 (57) = happyShift action_94
action_106 (58) = happyShift action_103
action_106 (60) = happyShift action_95
action_106 (22) = happyGoto action_110
action_106 _ = happyReduce_63

action_107 (43) = happyShift action_109
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_25

action_109 (54) = happyShift action_137
action_109 (24) = happyGoto action_136
action_109 _ = happyReduce_68

action_110 _ = happyReduce_60

action_111 (27) = happyShift action_45
action_111 (32) = happyShift action_46
action_111 (33) = happyShift action_47
action_111 (34) = happyShift action_48
action_111 (35) = happyShift action_49
action_111 (44) = happyShift action_50
action_111 (70) = happyShift action_51
action_111 (19) = happyGoto action_135
action_111 (23) = happyGoto action_44
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (48) = happyShift action_86
action_112 (49) = happyShift action_87
action_112 (50) = happyShift action_88
action_112 (51) = happyShift action_89
action_112 (52) = happyShift action_90
action_112 (53) = happyShift action_91
action_112 (54) = happyShift action_92
action_112 (55) = happyShift action_93
action_112 (57) = happyShift action_94
action_112 (58) = happyShift action_103
action_112 (60) = happyShift action_95
action_112 (22) = happyGoto action_134
action_112 _ = happyReduce_63

action_113 _ = happyReduce_35

action_114 _ = happyReduce_58

action_115 (30) = happyShift action_61
action_115 (31) = happyShift action_62
action_115 (37) = happyShift action_63
action_115 (42) = happyShift action_64
action_115 (47) = happyShift action_54
action_115 (50) = happyShift action_65
action_115 (56) = happyShift action_66
action_115 (61) = happyShift action_67
action_115 (62) = happyShift action_68
action_115 (63) = happyShift action_69
action_115 (64) = happyShift action_70
action_115 (70) = happyShift action_71
action_115 (20) = happyGoto action_133
action_115 (23) = happyGoto action_60
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_57

action_117 (43) = happyShift action_132
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_49

action_119 (48) = happyShift action_86
action_119 (49) = happyShift action_87
action_119 (50) = happyShift action_88
action_119 (51) = happyShift action_89
action_119 (52) = happyShift action_90
action_119 (53) = happyShift action_91
action_119 (54) = happyShift action_92
action_119 (55) = happyShift action_93
action_119 (60) = happyShift action_95
action_119 _ = happyReduce_54

action_120 (48) = happyShift action_86
action_120 (49) = happyShift action_87
action_120 (50) = happyShift action_88
action_120 (51) = happyShift action_89
action_120 (54) = happyFail []
action_120 (55) = happyFail []
action_120 (60) = happyShift action_95
action_120 _ = happyReduce_53

action_121 (48) = happyShift action_86
action_121 (49) = happyShift action_87
action_121 (50) = happyShift action_88
action_121 (51) = happyShift action_89
action_121 (54) = happyFail []
action_121 (55) = happyFail []
action_121 (60) = happyShift action_95
action_121 _ = happyReduce_52

action_122 (48) = happyShift action_86
action_122 (49) = happyShift action_87
action_122 (50) = happyShift action_88
action_122 (51) = happyShift action_89
action_122 (52) = happyFail []
action_122 (53) = happyFail []
action_122 (54) = happyShift action_92
action_122 (55) = happyShift action_93
action_122 (60) = happyShift action_95
action_122 _ = happyReduce_51

action_123 (48) = happyShift action_86
action_123 (49) = happyShift action_87
action_123 (50) = happyShift action_88
action_123 (51) = happyShift action_89
action_123 (52) = happyFail []
action_123 (53) = happyFail []
action_123 (54) = happyShift action_92
action_123 (55) = happyShift action_93
action_123 (60) = happyShift action_95
action_123 _ = happyReduce_50

action_124 _ = happyReduce_48

action_125 (49) = happyShift action_87
action_125 (51) = happyShift action_89
action_125 (60) = happyShift action_95
action_125 _ = happyReduce_47

action_126 _ = happyReduce_46

action_127 (49) = happyShift action_87
action_127 (51) = happyShift action_89
action_127 (60) = happyShift action_95
action_127 _ = happyReduce_45

action_128 (27) = happyShift action_45
action_128 (32) = happyShift action_46
action_128 (33) = happyShift action_47
action_128 (34) = happyShift action_48
action_128 (35) = happyShift action_49
action_128 (44) = happyShift action_50
action_128 (70) = happyShift action_51
action_128 (19) = happyGoto action_131
action_128 (23) = happyGoto action_44
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_36

action_130 _ = happyReduce_65

action_131 (27) = happyReduce_30
action_131 (28) = happyShift action_142
action_131 (32) = happyReduce_30
action_131 (33) = happyReduce_30
action_131 (34) = happyReduce_30
action_131 (35) = happyReduce_30
action_131 (44) = happyReduce_30
action_131 (45) = happyReduce_30
action_131 (70) = happyReduce_30
action_131 _ = happyReduce_30

action_132 (46) = happyShift action_141
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (47) = happyShift action_140
action_133 (48) = happyShift action_86
action_133 (49) = happyShift action_87
action_133 (50) = happyShift action_88
action_133 (51) = happyShift action_89
action_133 (52) = happyShift action_90
action_133 (53) = happyShift action_91
action_133 (54) = happyShift action_92
action_133 (55) = happyShift action_93
action_133 (57) = happyShift action_94
action_133 (60) = happyShift action_95
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_62

action_135 _ = happyReduce_32

action_136 (41) = happyShift action_139
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (70) = happyShift action_73
action_137 (23) = happyGoto action_138
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (46) = happyShift action_77
action_138 (58) = happyShift action_148
action_138 (59) = happyShift action_78
action_138 (25) = happyGoto action_147
action_138 _ = happyReduce_70

action_139 _ = happyReduce_37

action_140 (46) = happyShift action_146
action_140 (26) = happyGoto action_145
action_140 _ = happyReduce_72

action_141 (30) = happyShift action_61
action_141 (31) = happyShift action_62
action_141 (37) = happyShift action_63
action_141 (42) = happyShift action_64
action_141 (50) = happyShift action_65
action_141 (56) = happyShift action_66
action_141 (61) = happyShift action_67
action_141 (62) = happyShift action_68
action_141 (63) = happyShift action_69
action_141 (64) = happyShift action_70
action_141 (70) = happyShift action_71
action_141 (20) = happyGoto action_144
action_141 (23) = happyGoto action_60
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (27) = happyShift action_45
action_142 (32) = happyShift action_46
action_142 (33) = happyShift action_47
action_142 (34) = happyShift action_48
action_142 (35) = happyShift action_49
action_142 (44) = happyShift action_50
action_142 (70) = happyShift action_51
action_142 (19) = happyGoto action_143
action_142 (23) = happyGoto action_44
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_31

action_144 (47) = happyShift action_151
action_144 (48) = happyShift action_86
action_144 (49) = happyShift action_87
action_144 (50) = happyShift action_88
action_144 (51) = happyShift action_89
action_144 (52) = happyShift action_90
action_144 (53) = happyShift action_91
action_144 (54) = happyShift action_92
action_144 (55) = happyShift action_93
action_144 (57) = happyShift action_94
action_144 (60) = happyShift action_95
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_71

action_146 (30) = happyShift action_61
action_146 (31) = happyShift action_62
action_146 (37) = happyShift action_63
action_146 (42) = happyShift action_64
action_146 (50) = happyShift action_65
action_146 (56) = happyShift action_66
action_146 (61) = happyShift action_67
action_146 (62) = happyShift action_68
action_146 (63) = happyShift action_69
action_146 (64) = happyShift action_70
action_146 (70) = happyShift action_71
action_146 (20) = happyGoto action_133
action_146 (23) = happyGoto action_60
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (55) = happyShift action_150
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (70) = happyShift action_73
action_148 (23) = happyGoto action_149
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (46) = happyShift action_77
action_149 (58) = happyShift action_148
action_149 (59) = happyShift action_78
action_149 (25) = happyGoto action_152
action_149 _ = happyReduce_70

action_150 _ = happyReduce_67

action_151 _ = happyReduce_59

action_152 _ = happyReduce_69

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Program happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (DefList happy_var_1 happy_var_2
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_0  5 happyReduction_3
happyReduction_3  =  HappyAbsSyn5
		 (DefListEmpty
	)

happyReduce_4 = happySpecReduce_1  6 happyReduction_4
happyReduction_4 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (DefData happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  6 happyReduction_5
happyReduction_5 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (DefFunc happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happyReduce 5 7 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TTTypeName happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Data happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 8 8 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn18  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdentifier happy_var_1))) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Func happy_var_1 happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_2  9 happyReduction_8
happyReduction_8 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (DecList happy_var_1 happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0  9 happyReduction_9
happyReduction_9  =  HappyAbsSyn9
		 (DeclEmpty
	)

happyReduce_10 = happyReduce 4 10 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdentifier happy_var_1))) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Decl happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_11 = happySpecReduce_1  11 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn11
		 (TTypeInt
	)

happyReduce_12 = happySpecReduce_1  11 happyReduction_12
happyReduction_12 _
	 =  HappyAbsSyn11
		 (TTypeFloat
	)

happyReduce_13 = happySpecReduce_1  11 happyReduction_13
happyReduction_13 _
	 =  HappyAbsSyn11
		 (TTypeChar
	)

happyReduce_14 = happySpecReduce_1  11 happyReduction_14
happyReduction_14 _
	 =  HappyAbsSyn11
		 (TTypeBool
	)

happyReduce_15 = happySpecReduce_1  11 happyReduction_15
happyReduction_15 (HappyTerminal (Token _ (TTTypeName happy_var_1)))
	 =  HappyAbsSyn11
		 (TTypeName happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  12 happyReduction_16
happyReduction_16 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (BaseType happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  12 happyReduction_17
happyReduction_17 _
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (TArray happy_var_1
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  13 happyReduction_18
happyReduction_18 (HappyAbsSyn12  happy_var_3)
	_
	(HappyTerminal (Token _ (TIdentifier happy_var_1)))
	 =  HappyAbsSyn13
		 (Param happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  14 happyReduction_19
happyReduction_19 (HappyAbsSyn14  happy_var_3)
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (ParamsTail happy_var_2 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_0  14 happyReduction_20
happyReduction_20  =  HappyAbsSyn14
		 (ParamsTailEmpty
	)

happyReduce_21 = happySpecReduce_2  15 happyReduction_21
happyReduction_21 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (ParamsList happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_0  15 happyReduction_22
happyReduction_22  =  HappyAbsSyn15
		 (ParamsListEmpty
	)

happyReduce_23 = happySpecReduce_3  16 happyReduction_23
happyReduction_23 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (ReturnTypeList happy_var_2 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_0  16 happyReduction_24
happyReduction_24  =  HappyAbsSyn16
		 (ReturnTypeListEmpty
	)

happyReduce_25 = happySpecReduce_3  17 happyReduction_25
happyReduction_25 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (ReturnTypeTail happy_var_2 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_0  17 happyReduction_26
happyReduction_26  =  HappyAbsSyn17
		 (ReturnTypeTailEmpty
	)

happyReduce_27 = happySpecReduce_2  18 happyReduction_27
happyReduction_27 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (CommandList happy_var_1 happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_0  18 happyReduction_28
happyReduction_28  =  HappyAbsSyn18
		 (CommandListEmpty
	)

happyReduce_29 = happySpecReduce_3  19 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (CBlock happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happyReduce 5 19 happyReduction_30
happyReduction_30 ((HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (CIf happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 7 19 happyReduction_31
happyReduction_31 ((HappyAbsSyn19  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (CIfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 5 19 happyReduction_32
happyReduction_32 ((HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (CIterate happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_3  19 happyReduction_33
happyReduction_33 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (CRead happy_var_2
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  19 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (CPrint happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happyReduce 4 19 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (CReturn happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 4 19 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (CLvalueAssign happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_37 = happyReduce 6 19 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdentifier happy_var_1))) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (CCall happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_1  20 happyReduction_38
happyReduction_38 (HappyTerminal (Token _ (TInteger happy_var_1)))
	 =  HappyAbsSyn20
		 (EInt happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  20 happyReduction_39
happyReduction_39 (HappyTerminal (Token _ (TTFloat happy_var_1)))
	 =  HappyAbsSyn20
		 (EFloat happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  20 happyReduction_40
happyReduction_40 _
	 =  HappyAbsSyn20
		 (ETrue
	)

happyReduce_41 = happySpecReduce_1  20 happyReduction_41
happyReduction_41 _
	 =  HappyAbsSyn20
		 (EFalse
	)

happyReduce_42 = happySpecReduce_1  20 happyReduction_42
happyReduction_42 (HappyTerminal (Token _ (TLiteralChar happy_var_1)))
	 =  HappyAbsSyn20
		 (ELiteralChar happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  20 happyReduction_43
happyReduction_43 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn20
		 (ELvalue happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  20 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn20
		 (ENull
	)

happyReduce_45 = happySpecReduce_3  20 happyReduction_45
happyReduction_45 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EPlus happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  20 happyReduction_46
happyReduction_46 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (ETimes happy_var_1 happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  20 happyReduction_47
happyReduction_47 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EMinus happy_var_1 happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  20 happyReduction_48
happyReduction_48 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EDivide happy_var_1 happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  20 happyReduction_49
happyReduction_49 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EMod happy_var_1 happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  20 happyReduction_50
happyReduction_50 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EEqual happy_var_1 happy_var_3
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  20 happyReduction_51
happyReduction_51 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (ENEqual happy_var_1 happy_var_3
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  20 happyReduction_52
happyReduction_52 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (ELT happy_var_1 happy_var_3
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  20 happyReduction_53
happyReduction_53 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EGT happy_var_1 happy_var_3
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  20 happyReduction_54
happyReduction_54 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EAnd happy_var_1 happy_var_3
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_2  20 happyReduction_55
happyReduction_55 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (ENot happy_var_2
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_2  20 happyReduction_56
happyReduction_56 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (EMinusExp happy_var_2
	)
happyReduction_56 _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  20 happyReduction_57
happyReduction_57 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (EParen happy_var_2
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  20 happyReduction_58
happyReduction_58 (HappyAbsSyn26  happy_var_3)
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (ENew happy_var_2 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happyReduce 7 20 happyReduction_59
happyReduction_59 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdentifier happy_var_1))) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (ECall happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_60 = happySpecReduce_2  21 happyReduction_60
happyReduction_60 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (ExpList happy_var_1 happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_0  21 happyReduction_61
happyReduction_61  =  HappyAbsSyn21
		 (ExpListEmpty
	)

happyReduce_62 = happySpecReduce_3  22 happyReduction_62
happyReduction_62 (HappyAbsSyn22  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (ExpListTail happy_var_2 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  22 happyReduction_63
happyReduction_63  =  HappyAbsSyn22
		 (ExpListTailEmpty
	)

happyReduce_64 = happySpecReduce_1  23 happyReduction_64
happyReduction_64 (HappyTerminal (Token _ (TIdentifier happy_var_1)))
	 =  HappyAbsSyn23
		 (LvalueId happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happyReduce 4 23 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (LvalueArray happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_3  23 happyReduction_66
happyReduction_66 (HappyTerminal (Token _ (TIdentifier happy_var_3)))
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (LvalueDot happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happyReduce 4 24 happyReduction_67
happyReduction_67 (_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	(HappyAbsSyn23  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (LvaluesList happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_68 = happySpecReduce_0  24 happyReduction_68
happyReduction_68  =  HappyAbsSyn24
		 (LvaluesListEmpty
	)

happyReduce_69 = happySpecReduce_3  25 happyReduction_69
happyReduction_69 (HappyAbsSyn25  happy_var_3)
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn25
		 (LvaluesListTail happy_var_2 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_0  25 happyReduction_70
happyReduction_70  =  HappyAbsSyn25
		 (LvaluesListTailEmpty
	)

happyReduce_71 = happyReduce 4 26 happyReduction_71
happyReduction_71 ((HappyAbsSyn26  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Index happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_72 = happySpecReduce_0  26 happyReduction_72
happyReduction_72  =  HappyAbsSyn26
		 (IndexEmpty
	)

happyNewToken action sts stk [] =
	action 71 71 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token _ TIf -> cont 27;
	Token _ TElse -> cont 28;
	Token _ TThen -> cont 29;
	Token _ TTrue -> cont 30;
	Token _ TFalse -> cont 31;
	Token _ TPrint -> cont 32;
	Token _ TRead -> cont 33;
	Token _ TReturn -> cont 34;
	Token _ TIterate -> cont 35;
	Token _ TData -> cont 36;
	Token _ TNew -> cont 37;
	Token _ TAssign -> cont 38;
	Token _ TDoubleColon -> cont 39;
	Token _ TColon -> cont 40;
	Token _ TSemiColon -> cont 41;
	Token _ TLParen -> cont 42;
	Token _ TRParen -> cont 43;
	Token _ TLBrace -> cont 44;
	Token _ TRBrace -> cont 45;
	Token _ TLBracket -> cont 46;
	Token _ TRBracket -> cont 47;
	Token _ TPlus -> cont 48;
	Token _ TTimes -> cont 49;
	Token _ TMinus -> cont 50;
	Token _ TDiv -> cont 51;
	Token _ TEq -> cont 52;
	Token _ TNeq -> cont 53;
	Token _ TLt -> cont 54;
	Token _ TGt -> cont 55;
	Token _ TNot -> cont 56;
	Token _ TAnd -> cont 57;
	Token _ TComma -> cont 58;
	Token _ TDot -> cont 59;
	Token _ TMod -> cont 60;
	Token _ TNull -> cont 61;
	Token _ (TLiteralChar happy_dollar_dollar) -> cont 62;
	Token _ (TInteger happy_dollar_dollar) -> cont 63;
	Token _ (TTFloat happy_dollar_dollar) -> cont 64;
	Token _ (TTTypeName happy_dollar_dollar) -> cont 65;
	Token _ TTTypeBool -> cont 66;
	Token _ TTTypeInt -> cont 67;
	Token _ TTTypeFloat -> cont 68;
	Token _ TTTypeChar -> cont 69;
	Token _ (TIdentifier happy_dollar_dollar) -> cont 70;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 71 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parser tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
