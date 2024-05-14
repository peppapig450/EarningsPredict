module Main where
import API
import DataParsing
import Utils



main :: IO ()
main = do

    -- Format the dates as strings
    fromDate <- getCurrentDatePlusOneDay
    toDate <- getCurrentDatePlusTwoDays
    apiKey <- getApiKey

    -- Fetch upcoming earnings data
    earningsAPIResult <- fetchUpcomingEarnings fromDate toDate apiKey

    -- Process the API result
    case earningsAPIResult of
        Right jsonData ->
            -- Parse earnings data
            case parseEarningsData jsonData of
                Right earnings -> do
                    putStrLn "Upcoming Earnings:"
                    mapM_ print earnings
                Left err -> putStrLn $ "Failed to parse earnings data: " ++ err
        Left err -> putStrLn $ "Failed to fetch upcoming earnings data: " ++ err