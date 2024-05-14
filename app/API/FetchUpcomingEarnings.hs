{-# LANGUAGE OverloadedStrings #-}
module API.FetchUpcomingEarnings (fetchUpcomingEarnings) where

import Network.HTTP.Simple
    ( parseRequest_, getResponseBody, getResponseStatusCode, httpLBS )
import qualified Data.ByteString.Lazy as LBS

fetchUpcomingEarnings :: String -> String -> String -> IO (Either String LBS.ByteString)
fetchUpcomingEarnings fromDate toDate apiKey = do
    let baseUrl = "https://financialmodelingprep.com/api/v3/earning_calendar"
    let queryParams = "?from" <> fromDate <> "&to=" <> toDate <> "&apikey=" <> apiKey
    let requestUrl = baseUrl <> queryParams
    response <- httpLBS $ parseRequest_ requestUrl
    let status = getResponseStatusCode response
    if status == 200
        then return $ Right $ getResponseBody response
        else return $ Left $ "HTTP request failed with status code: " ++ show status
