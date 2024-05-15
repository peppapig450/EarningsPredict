import fmpsdk
import json
import re
import os


def get_upcoming_earnings(api_key, from_date, to_date):
    earnings_data = fmpsdk.earning_calendar(
        apikey=api_key, from_date=from_date, to_date=to_date
    )

    filtered_symbols = []
    for earning in earnings_data:
        symbol = earning.get("symbol")
        # Filter if symbol exists, is a string, and doesn't end with country code extension
        if symbol and not re.search(r"\.[A-Z]*$", symbol):
            filtered_symbols.append(symbol)

    return filtered_symbols


def get_historical_earnings_data(api_key, filtered_symbols):
    historical_earnings_data = {}
    for symbol in filtered_symbols:
        historical_earnings = fmpsdk.historical_earning_calendar(
            apikey=api_key, symbol=symbol
        )
        print(f"{symbol}\n: {historical_earnings}")
        historical_earnings_data[symbol] = historical_earnings

    return historical_earnings_data


if __name__ == "__main__":
    fmp_api_key = os.get.env("fmp_api_key")

    upcoming_earnings_symbols = get_upcoming_earnings(
        fmp_api_key, "2024-05-16", "2024-05-18"
    )

    historical_earnings = get_historical_earnings_data(
        fmp_api_key, upcoming_earnings_symbols
    )

    with open("historical_data.json", "w") as file:
        json.dump(historical_earnings, file, indent=4)
