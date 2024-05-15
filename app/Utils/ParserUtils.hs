module Utils.ParserUtils where

import Text.Megaparsec
import Text.Megaparsec.Char
import Data.Void (Void)

type Parser = Parsec Void String

getInternationalStockSymbols :: Parser String
getInternationalStockSymbols = do
    firstPart <- some (alphaNumChar <|> char '-')
    _ <- char '.'
    secondPart <- some alphaNumChar
    return (firstPart ++ "." ++ secondPart)