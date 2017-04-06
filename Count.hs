{-# LANGUAGE FlexibleContexts #-}
module Count where

import Control.Monad.State
import Data.Map (Map)
import qualified Data.Map as Map
import System.IO
import Text.ParserCombinators.UU
import Text.ParserCombinators.UU.Utils
import Text.ParserCombinators.UU.BasicInstances

type Name = String
type Number = Int

data Register = Constant Int | Variable Int
	deriving (Eq, Show)

fromRegister :: Register -> Int
fromRegister (Constant n) = n
fromRegister (Variable n) = n

data OutputType = AsNumber | AsCharacter
	deriving (Eq, Show)

data Statement
	= Assignment Name Number
	| DeclareConstant Name Number
	| Comment String
	| Print [Name] OutputType
	deriving (Eq, Show)

ahahah :: Parser String
ahahah = pToken ", ah, ah, ah!"

parseNumber :: Parser Number
parseNumber = pNatural
parseName :: Parser Name
parseName = pSome pLetter

parseAssignment :: Parser Statement
parseAssignment = flip Assignment <$> parseNumber <*> parseName <* ahahah
parseDeclConstant :: Parser Statement
parseDeclConstant = constant <$> parseNumber <* pToken "!" <*> parseNumber <*> parseName <* ahahah
	where constant num1 num2 name | num1 /= num2 = error "Don't forget to count, user!"
	                              | otherwise = DeclareConstant name num1
parsePrint :: Parser Statement
parsePrint = Print <$ pToken "I love to count " <*> pListSep (pToken ";") parseName <*> parseOutputType
parseOutputType :: Parser OutputType
parseOutputType
	= AsNumber <$ pToken "!"
	<|> AsCharacter <$ ahahah

parseStatement :: Parser Statement
parseStatement = parsePrint <|> parseDeclConstant <|> parseAssignment

parseProgram :: Parser [Statement]
parseProgram = pToken "Ah hello there, it is I, the count.\n" *>
	pListSep (pToken "\n") parseStatement <*
	pMaybe (pToken "\n")

type Execute m a = StateT (Map Name Register) m a

executeStmt :: Statement -> Execute IO ()
executeStmt (Assignment name nr) = do
	-- TODO: error if it's constant
	modify (Map.insert name (Variable nr))
executeStmt (DeclareConstant name nr) = do
	-- TODO: error if it's already defined
	modify (Map.insert name (Constant nr))
executeStmt (Comment _) = pure ()
executeStmt (Print names AsCharacter) = do
	regs <- get
	lift $ mapM_ (putChar . toEnum . fromRegister . (regs Map.!)) names
executeStmt (Print names AsNumber) = do
	regs <- get
	lift $ mapM_ (putStr . show . fromRegister . (regs Map.!)) names

executeProgram :: [Statement] -> Execute IO ()
executeProgram = mapM_ executeStmt

run :: FilePath -> IO ()
run file = do
	contents <- readFile file
	let program = parse (parseProgram <* pEnd) (createStr (LineColPos 0 0 0) contents)
	runStateT (executeProgram program) Map.empty
	pure ()
