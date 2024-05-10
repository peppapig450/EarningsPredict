{-# LANGUAGE OverloadedStrings #-}
module DataParsing.ParseEarningsData (parseEarningsData) where

import Data.Aeson
import DataParsing.DataTypes (UpComingEarning)
import qualified Data.ByteString.Lazy as LBS

-- Function to parse JSON data into a list of UpComingEarning records
parseEarningsData :: LBS.ByteString -> Either String [UpComingEarning]
parseEarningsData jsonData = case eitherDecode jsonData of
    Right earnings -> Right earnings
    Left err -> Left $ "Failed to parse JSON Response: " ++ err