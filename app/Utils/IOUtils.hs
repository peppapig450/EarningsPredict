{-# LANGUAGE OverloadedStrings #-}

module Utils.IOUtils where

import System.Environment (lookupEnv)

getApiKey :: IO String
getApiKey = do
    maybeApiKey <- lookupEnv "API_KEY"
    case maybeApiKey of
        Just key -> return key
        Nothing  -> error "Missing API_KEY environment variable"