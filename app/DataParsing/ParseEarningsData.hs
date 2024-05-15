{-# LANGUAGE OverloadedStrings #-}
module DataParsing.ParseEarningsData (parseEarningsData) where

import Data.Aeson
import DataParsing.DataTypes (UpComingEarning(..))
import qualified Data.ByteString.Lazy as LBS
import Utils.ParserUtils
import Data.Aeson.Types (parseEither)
import Text.Megaparsec (parse)

-- Function to parse JSON data into a list of UpComingEarning records
parseEarningsData :: LBS.ByteString -> Either String [UpComingEarning]
parseEarningsData jsonData = case eitherDecode jsonData of
    Right jsonList -> Right $ foldr filterEarnings [] (jsonList :: [Value])

    Left err -> Left $ "Failed to parse JSON Response: " ++ err

-- Function to filter and parse a single JSON object into an UpComingEarning record
filterEarnings :: Value -> [UpComingEarning] -> [UpComingEarning]
filterEarnings value acc = case parseSingleEarning value of
    Right (Just earning) ->  earning: acc
    _ -> acc

parseSingleEarning :: Value -> Either String (Maybe UpComingEarning)
parseSingleEarning = parseEither $ withObject "UpComingEarning" $ \v -> do
    date <- v .: "date"
    symbol <- v .: "symbol"
    time <- v .:? "time"
    fiscalDateEnding <- v .: "fiscalDateEnding"
    updatedFromDate <- v .: "updatedFromDate"
    let earning = UpComingEarning date symbol time fiscalDateEnding updatedFromDate
    -- Filter out the international stock symbols
    case parse getInternationalStockSymbols "" symbol of
        Left _ -> return (Just earning) -- only append US stock symbols
        Right _ -> return Nothing