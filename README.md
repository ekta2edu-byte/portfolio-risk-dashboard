# Portfolio Risk & Performance Dashboard

A Python-based portfolio analytics project focused on portfolio performance measurement, market risk, diversification, historical stress testing, and benchmark analysis.

## 1. Project Objective

The objective of this project is to evaluate the performance and risk characteristics of a diversified equity portfolio using historical market data.

The project follows an institutional-style portfolio risk management workflow:

**Market Data → Portfolio Returns → Performance Measurement → Risk Analysis → VaR Backtesting → Stress Testing → Benchmark Analysis**

## 2. Portfolio Composition

The portfolio consists of nine US and European equities, equally weighted for the analysis.

| Company | Ticker |
|---|---|
| Apple | AAPL |
| ASML | ASML |
| BNP Paribas | BNP.PA |
| LVMH | MC.PA |
| Microsoft | MSFT |
| NVIDIA | NVDA |
| Novo Nordisk | NVO |
| Shell | SHEL |
| Siemens | SIE.DE |

All figures are expressed in **EUR**, from the perspective of an unhedged euro-based investor. Six holdings are priced in US dollars (AAPL, MSFT, NVDA, and ASML, Novo Nordisk and Shell through their US listings) and are converted to EUR. BNP Paribas, LVMH and Siemens are already priced in EUR.

## 3. Key Analysis

### Portfolio Performance
- Daily asset and portfolio returns
- Annualized return and volatility
- Sharpe ratio
- Cumulative portfolio growth
- Maximum drawdown
- Rolling annualized volatility
- Best and worst trading days

### Market Risk
- Correlation analysis and covariance matrix
- Portfolio volatility
- Historical Value at Risk (VaR) at the 95% confidence level
- Conditional Value at Risk (CVaR / Expected Shortfall)
- Historical VaR backtesting
- Component Contribution to Risk (CCtR)

### Historical Stress Testing
- COVID-19 stress-period analysis
- Portfolio drawdown during the stress period
- Annualized volatility during the stress period
- Comparison with pre-COVID volatility

### Benchmark Analysis
- Comparison against the S&P 500 Total Return index, in EUR
- Portfolio beta
- Cumulative growth comparison
- Relative historical performance

## 4. Dashboard Highlights

The dashboard presents key portfolio performance and risk indicators, including annualized return, annualized volatility, Sharpe ratio, maximum drawdown, historical VaR, CVaR, and supporting visualizations.

The current dashboard reports the following results for the portfolio's historical sample:

> **Note:** the figures and screenshots in this section were calculated before the EUR conversion (local-currency returns and a 2.25% risk-free rate). They will be updated after the notebooks are re-run with EUR-based data.

| Metric | Result |
|---|---:|
| Annualized return | 28.49% |
| Annualized volatility | 22.66% |
| Sharpe ratio | 1.16 |
| Maximum drawdown | -36.56% |
| 95% Historical VaR (1-day) | 2.08% |
| 95% CVaR / Expected Shortfall | 3.31% |

### VaR Backtesting

The historical 95% VaR backtest recorded 91 exceptions, corresponding to an observed exception rate of 5.03%, compared with the expected rate of 5.00%. This indicates that the observed exception frequency was close to the nominal rate over the historical sample. It does not, by itself, establish that the VaR model is reliable under all market conditions.

*These are historical sample results, not forecasts or guarantees of future performance.*

### Dashboard Preview

#### 1. Portfolio Overview
![Portfolio Overview](images/portfolio_overview.png)

#### 2. VaR Backtesting and Risk Contribution
![VaR Backtesting and Risk Contribution](images/var_backtest_risk_contribution.png)

#### 3. COVID-19 Stress Testing
![COVID-19 Stress Test](images/covid_stress_test.png)

#### 4. Benchmark Analysis
![Benchmark Analysis](images/benchmark_analysis.png)

## 5. Methodology

- Historical adjusted closing prices are used to calculate daily asset returns.
- **Base currency (EUR).** USD prices are converted to EUR with the daily EUR/USD exchange rate (`EURUSD=X`, US dollars per euro): price in EUR = price in USD ÷ EUR/USD. Returns therefore include the currency effect experienced by an unhedged euro-based investor.
- **Dates and missing values.** The portfolio uses the union of US and European trading days. Missing stock prices on market holidays are filled with the previous day's price. The exchange rate and the benchmark are aligned to exactly the same dates and filled forward in the same way; values are never filled backwards, to avoid look-ahead bias.
- The portfolio is constructed using equal weights across the nine holdings.
- Annualized volatility is calculated using daily return volatility and 252 trading days.
- The Sharpe ratio uses a 1.05% annual risk-free rate: a constant full-period approximation equal to the simple average of the annual €STR (euro short-term rate) averages for 2019–2025. €STR began on 2 October 2019, so the 2019 figure covers October–December only.
- **Benchmark.** The S&P 500 Total Return index (`^SP500TR`, dividends reinvested gross of withholding tax), converted to EUR with the same exchange rate and on the same dates as the portfolio. This matches the stocks' adjusted closing prices, which also reinvest gross dividends.
- Historical VaR estimates the loss threshold at the 95% confidence level; CVaR estimates the average loss beyond that threshold.
- VaR backtesting compares observed portfolio losses against the estimated VaR threshold.
- Component Contribution to Risk measures each holding's contribution to total portfolio volatility.
- Beta measures the portfolio's historical sensitivity to S&P 500 Total Return (EUR) returns over aligned observations.

## 6. Technology Stack

- Python
- Pandas
- NumPy
- yfinance
- Streamlit
- Plotly
- Jupyter Notebook

## 7. Project Structure

```text
Portfolio_Risk_Dashboard/
├── data/
│   ├── adj_close.csv          # prices in EUR (used by the analysis)
│   ├── adj_close_local.csv    # prices in local currency (USD or EUR)
│   ├── eurusd.csv             # EUR/USD exchange rate
│   └── sp500tr_eur.csv        # S&P 500 Total Return benchmark in EUR
├── images/
├── notebooks/
│   ├── 01_Download_Data.ipynb
│   ├── 02_Portfolio_Returns.ipynb
│   └── 03_Risk_Analysis.ipynb
├── reports/
├── src/
│   ├── dashboard.py
│   ├── Open_Dashboard.command
│   └── pages/
├── README.md
└── requirements.txt
```

## 8. How to Run the Dashboard

1. Install Python and the packages listed in `requirements.txt`.
2. Run `notebooks/01_Download_Data.ipynb` once to create the EUR price, exchange-rate and benchmark files in `data/`.
3. Open a terminal in the project's `src` directory.
4. Run:

   ```bash
   python -m streamlit run dashboard.py
   ```

5. Open the local URL displayed in the terminal, usually `http://localhost:8501`.

Keep the terminal session running while using the dashboard.

## 9. Limitations

- The analysis is based on historical market data; past performance does not predict future results.
- Historical VaR and CVaR depend on the selected sample and may not capture all extreme market events.
- The portfolio uses equal weights, and results depend on the portfolio construction and rebalancing assumptions implemented in the code.
- Benchmark comparisons depend on the selected S&P 500 data series and its return methodology.
- Currency: returns are unhedged. The daily EUR/USD rate is not taken at exactly the same moment as the US and European closing prices, which adds small day-to-day timing noise but does not bias returns over longer periods.
- Dividends: both the stock prices and the benchmark reinvest dividends gross of withholding tax, so both slightly overstate what a taxed euro investor would actually receive.
- Risk-free rate: the constant 1.05% is a full-period approximation of €STR, which varied from about −0.57% to 3.64% (annual averages) over 2019–2025.

## 10. Disclaimer

This project is for educational and analytical purposes only. It does not constitute investment advice or a recommendation to buy or sell securities.