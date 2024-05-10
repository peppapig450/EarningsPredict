{-# LANGUAGE OverloadedStrings #-}
module DataParsing.DataTypes where

import Data.Aeson
-- TODO: data types go here put data processing in other submodule

data UpComingEarning = UpComingEarning {
    date :: String,
    symbol :: String,
    eps :: Maybe Double,
    epsEstimated :: Maybe Double,
    time :: Maybe String,
    revenue :: Maybe Float,
    revenueEstimated :: Maybe Float,
    fiscalDateEnding :: String,
    updatedFromDate :: String
} deriving (Show)

instance FromJSON UpComingEarning where
    parseJSON = withObject "UpComingEarning" $ \v -> UpComingEarning
        <$> v .:  "date"
        <*> v .:  "symbol"
        <*> v .:? "eps"
        <*> v .:? "epsEstimated"
        <*> v .:? "time"
        <*> v .:? "revenue"
        <*> v .:? "revenueEstimated"
        <*> v .: "fiscalDateEnding"
        <*> v .: "updatedFromDate"
