import finnhub
import json
import os

apikey = os.get.env("finnhub_api_key")
finnhub_client = finnhub.Client(api_key="cp238p9r01qhquut3u7gcp238p9r01qhquut3u80")

upcoming_earnings = finnhub_client.earnings_calendar(
    _from="2024-05-15", to="2024-05-18", symbol="", international=False
)

symbols = set(earning["symbol"] for earning in upcoming_earnings["earningsCalendar"])
print(symbols)
