{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Network.HTTP.Simple
    ( parseRequest_, getResponseBody, getResponseStatusCode, httpLBS )
import Control.Monad (when, unless, forM_)
import System.Environment (lookupEnv)

-- Define data type for earnigns calendar json response string
data UpComingEarning = UpComingEarning {
    date :: String,
    symbol :: String,
    eps :: Maybe Double,
    epsEstimated :: Maybe Double,
    time :: Maybe String,
    revenue :: Maybe Int,
    revenueEstimated :: Maybe Float,
    fiscalDateEnding :: String,
    updatedFromDate :: String
} deriving (Show)

instance FromJSON UpComingEarning where
    parseJSON = withObject "UpComingEarning" $ \v -> UpComingEarning
        <$> v .: "date"
        <*> v .: "symbol"
        <*> v .:? "eps"
        <*> v .:? "epsEstimated"
        <*> v .:? "time"
        <*> v .:? "revenue"
        <*> v .:? "revenueEstimated"
        <*> v .: "fiscalDateEnding"
        <*> v .: "updatedFromDate"


apiKey :: IO String
apiKey = do
    maybeApiKey <- lookupEnv "API_KEY"
    case maybeApiKey of
        Just key -> return key
        Nothing  -> error "Missing API_KEY environment variable"


main :: IO ()
main = do
    -- BaseURL api
    let baseUrl = "https://financialmodelingprep.com/api/v3/earning_calendar"
    -- Define the dates
    let fromDate = "2024-05-10"
    let toDate = "2024-05-31"
    apiKeyValue <- apiKey
    -- Construct query parameters
    let queryParams = "?from=" <> fromDate <> "&to=" <> toDate <> "&apikey=" <> apiKeyValue
    -- Construct full request
    let requestUrl = baseUrl <> queryParams
    -- Make the HTTP request
    response <- httpLBS $ parseRequest_ requestUrl
    -- Get response status code
    let status = getResponseStatusCode response
    -- Check if the status code indicates success
    when (status == 200) $ do
        -- Parse the json response
        let earningsReport = eitherDecode (getResponseBody response) :: Either String [UpComingEarning]
        -- process parsed json
        case earningsReport of
            Right earnings -> do
                putStrLn "Earnings:"
                forM_ earnings $ \earning ->
                    putStrLn $ "Date: " ++ date earning ++ ", Symbol: " ++ symbol earning ++ ", EPS: " ++ show (eps earning) ++ ", EPS Estimated: " ++ show (epsEstimated earning) ++ ", Time: " ++ show (time earning) ++ ", Revenue: " ++ show (revenue earning) ++ ", Revenue Estimated: " ++ show (revenueEstimated earning) ++ ", Fiscal Date Ending: " ++ fiscalDateEnding earning ++ ", Updated From Date: " ++ updatedFromDate earning
            Left err -> putStrLn $ "Failed to parse JSON response: " ++ err
    -- If the status code indicates failure, print an error message
    unless (status == 200) $ putStrLn $ "HTTP request failed with status code: " ++ show status
