module Main where
import API
import DataParsing
import System.Environment (lookupEnv)

-- Define data type for earnigns calendar json response string

apiKey :: IO String
apiKey = do
    maybeApiKey <- lookupEnv "API_KEY"
    case maybeApiKey of
        Just key -> return key
        Nothing  -> error "Missing API_KEY environment variable"


main :: IO ()
main = do
    -- Define the dates
    let fromDate = "2024-05-10"
    let toDate = "2024-05-31"

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