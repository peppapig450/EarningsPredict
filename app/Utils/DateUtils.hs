{-# LANGUAGE OverloadedStrings #-}
module Utils.DateUtils where

import Data.Time.Clock
import Data.Time.Calendar
import Data.Time.Format

-- Function to format a date
formatDate :: Day -> String
formatDate = formatTime defaultTimeLocale "%Y-%m-%d"

-- Function to get the current date
getCurrentDateString :: IO String
getCurrentDateString = formatDate . utctDay <$> getCurrentTime

-- Function to get the current date + 1 month
getCurrentDatePlusOneMonthString :: IO String
getCurrentDatePlusOneMonthString = do
    today <- utctDay <$> getCurrentTime
    let plusOneDate = addGregorianMonthsClip 1 today
    return $ formatDate plusOneDate

getCurrentDatePlusOneDay :: IO String
getCurrentDatePlusOneDay = do
    today <- utctDay <$> getCurrentTime
    let plusOneDate = addDays 1 today
    return $ formatDate plusOneDate

getCurrentDatePlusTwoDays :: IO String
getCurrentDatePlusTwoDays = do
    today <- utctDay <$> getCurrentTime
    let plusOneDate = addDays 2 today
    return $ formatDate plusOneDate