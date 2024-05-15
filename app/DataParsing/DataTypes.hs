{-# LANGUAGE OverloadedStrings #-}
module DataParsing.DataTypes where

import Data.Aeson
-- TODO: data types go here put data processing in other submodule

data UpComingEarning = UpComingEarning {
    date :: String,
    symbol :: String,
    time :: Maybe String,
    fiscalDateEnding :: String,
    updatedFromDate :: String
} deriving (Show)

instance FromJSON UpComingEarning where
    parseJSON = withObject "UpComingEarning" $ \v -> UpComingEarning
        <$> v .:  "date"
        <*> v .:  "symbol"
        <*> v .:? "time"
        <*> v .: "fiscalDateEnding"
        <*> v .: "updatedFromDate"