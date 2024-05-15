# Data To Collect:

## Upcoming Earnings:
- Gather list of symbols with upcoming earnings announcements.

## Historical Price Data:
- Gather historical price data for each symbol leading up to previous earnings announcements.

## Fundamental Metrics:
+ **Collect fundamental metrics for each company, such as:**
    - Earnings per share (EPS)
    -  Revenue growth rate
    - Profit margin
    - Price-to-earnings (P/E) ratio
    - Debt-to-equity ratio
    - Return on equity (ROE)
    - Dividend yield

## Analyst Estimates and Recommendations:
+ **Retrieve analyst estimates and recommendations for each company, including:**
    - Consensus earnings estimates for the upcoming earnings announcement
    - Average price targets from analysts
    - Buy/sell/hold recommendations from analysts

## Market Sentiment Indicators:
+ **Gather data on market sentiment indicators, such as:**
    - Short interest ratio (the percentage of shares held short by investors)
    - Put/call ratio (the ratio of put options to call options traded)
    - Social media sentiment analysis (sentiment expressed on platforms like Twitter, Reddit, etc.)

## Industry and Sector Data:
+ **Consider collecting data specific to the industry or sector in which each company operates, such as:**
    - Industry-specific performance metrics
    - Sector-wide trends and news

## Company News and Events:
- Look for recent news articles, press releases, or significant events related to each company, as these can impact stock prices.

## Volatility and Trading Volume:
- Analyze historical volatility and trading volume for each symbol, as high volatility or trading volume can indicate increased market interest or uncertainty.

## Earnings Call Transcripts:
- After the earnings announcement, gather transcripts or summaries of the earnings calls for each company to understand management's commentary and guidance.
---

```mermaid
erDiagram
    EarningsSymbol {
        symbol VARCHAR
        PRIMARY KEY symbol
    }
    HistoricalPriceData {
        symbol VARCHAR
        date DATE
        price DECIMAL
        PRIMARY KEY (symbol, date)
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    FundamentalMetrics {
        symbol VARCHAR
        eps DECIMAL
        revenueGrowthRate DECIMAL
        profitMargin DECIMAL
        peRatio DECIMAL
        debtToEquityRatio DECIMAL
        roe DECIMAL
        dividendYield DECIMAL
        PRIMARY KEY symbol
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    AnalystEstimates {
        symbol VARCHAR
        earningsEstimate DECIMAL
        averagePriceTarget DECIMAL
        recommendation VARCHAR
        PRIMARY KEY symbol
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    MarketSentimentIndicators {
        symbol VARCHAR
        shortInterestRatio DECIMAL
        putCallRatio DECIMAL
        socialMediaSentiment VARCHAR
        PRIMARY KEY symbol
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    IndustrySectorData {
        symbol VARCHAR
        industrySpecificMetrics VARCHAR
        sectorTrends VARCHAR
        PRIMARY KEY symbol
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    CompanyNewsEvents {
        symbol VARCHAR
        newsEventText TEXT
        PRIMARY KEY (symbol, newsEventText)
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    VolatilityTradingVolume {
        symbol VARCHAR
        volatility DECIMAL
        tradingVolume DECIMAL
        PRIMARY KEY symbol
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
    EarningsCallTranscripts {
        symbol VARCHAR
        transcriptText TEXT
        PRIMARY KEY (symbol, transcriptText)
        FOREIGN KEY (symbol) REFERENCES EarningsSymbol(symbol)
    }
```