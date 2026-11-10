# Portfolio Risk & Performance Dashboard

A Python-based portfolio analytics project focused on portfolio performance measurement, market risk, diversification, historical stress testing, and benchmark analysis.

## 1. Project Objective

The objective of this project is to evaluate the performance and risk characteristics of a diversified equity portfolio using historical market data.

The project follows an institutional-style portfolio risk management workflow:

**Market Data → Portfolio Returns → Performance Measurement → Risk Analysis → VaR Backtesting → Stress Testing → Benchmark Analysis**

## 2. Portfolio Composition

The portfolio consists of nine large eurozone companies, equally weighted for the analysis. Every holding is listed and traded in **EUR**.

| Company | Ticker | Exchange | Sector |
|---|---|---|---|
| ASML Holding | ASML.AS | Euronext Amsterdam | Semiconductor equipment |
| BNP Paribas | BNP.PA | Euronext Paris | Banking |
| LVMH | MC.PA | Euronext Paris | Luxury goods |
| Siemens | SIE.DE | Xetra (Frankfurt) | Industrial technology |
| Airbus | AIR.PA | Euronext Paris | Aerospace |
| L'Oréal | OR.PA | Euronext Paris | Consumer goods |
| Sanofi | SAN.PA | Euronext Paris | Pharmaceuticals |
| SAP | SAP.DE | Xetra (Frankfurt) | Software |
| Allianz | ALV.DE | Xetra (Frankfurt) | Insurance |

The portfolio is analysed from the perspective of an **unhedged euro-based investor holding EUR-denominated equities**. Because all holdings and the benchmark are priced in EUR, returns contain no exchange-rate effect and no currency conversion is needed.

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
- Comparison against the EURO STOXX 50 (Net Return, EUR)
- Portfolio beta
- Cumulative growth comparison
- Relative historical performance

## 4. Dashboard Highlights

The dashboard presents key portfolio performance and risk indicators, including annualized return, annualized volatility, Sharpe ratio, maximum drawdown, historical VaR, CVaR, and supporting visualizations.

The dashboard reports the following results for the portfolio's historical sample (2 January 2019 to 30 December 2025):

> **Note:** the results below and the dashboard screenshots will be updated after the notebooks have been run on the new EUR-denominated European portfolio. The screenshots currently show the previous version of the portfolio.

| Metric | Result |
|---|---:|
| Annualized return | To be updated |
| Annualized volatility | To be updated |
| Sharpe ratio | To be updated |
| Maximum drawdown | To be updated |
| 95% Historical VaR (1-day) | To be updated |
| 95% CVaR / Expected Shortfall | To be updated |

### VaR Backtesting

The 95% historical VaR backtest counts the days on which the portfolio's return was worse than the VaR threshold and compares this exception rate with the expected rate of 5%. Because the threshold is estimated from the same sample (an in-sample test), the exception rate is close to 5% by construction; it does not, by itself, establish that the VaR model is reliable under all market conditions.

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

- **Data.** Daily adjusted closing prices from Yahoo Finance (`yfinance`), 2 January 2019 to 30 December 2025. Adjusted prices reflect dividends (reinvested gross of withholding tax on the ex-dividend date) and stock splits. Notebook 1 checks that every ticker is traded in EUR, covers the whole period, and lists each stock's largest daily moves so they can be checked against known events (such as the Siemens Energy spin-off in September 2020).
- **Base currency.** EUR. All holdings and the benchmark are priced in EUR, so no currency conversion is applied and returns have no exchange-rate component.
- **Dates and missing values.** The dates are the union of the trading days of Euronext Paris, Euronext Amsterdam and Xetra. A missing price on an exchange holiday is filled with the previous day's price. The benchmark is aligned to exactly the same dates and filled in the same way. Prices are never filled backwards, to avoid look-ahead bias.
- The portfolio is constructed using equal weights across the nine holdings, applied to each day's returns (the portfolio is rebalanced to equal weights daily, with no transaction costs).
- Annualized return is the mean daily return × 252; annualized volatility is the daily standard deviation × √252.
- **Risk-free rate.** The Sharpe ratio uses a constant risk-free rate of 1.05% per year: a full-period approximation equal to the simple average of the annual €STR (euro short-term rate) averages for 2019–2025. €STR began on 2 October 2019, so the 2019 figure covers October–December only. Sharpe ratio = (annualized return − 1.05%) ÷ annualized volatility, which is equivalent to subtracting 1.05% ÷ 252 from every daily return.
- **Benchmark.** The Xtrackers EURO STOXX 50 UCITS ETF 1C (`XESC.DE`, Xetra, EUR), an accumulating fund that tracks the EURO STOXX 50 Net Return index. It is used as an investable proxy for the index. All nine holdings are members of the EURO STOXX 50.
- Historical VaR estimates the loss threshold at the 95% confidence level; CVaR estimates the average loss beyond that threshold.
- VaR backtesting compares observed portfolio losses against the estimated VaR threshold.
- Component Contribution to Risk measures each holding's contribution to total portfolio volatility.
- Beta measures the portfolio's historical sensitivity to EURO STOXX 50 returns over aligned observations.

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
│   ├── adj_close.csv      # stock prices in EUR (created by Notebook 1)
│   └── benchmark.csv      # EURO STOXX 50 benchmark prices in EUR (created by Notebook 1)
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
2. Run `notebooks/01_Download_Data.ipynb` to download the data and create the files in `data/`.
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
- Benchmark: the benchmark is an ETF, so its return is reduced by its 0.09% annual fee and may differ slightly from the index itself. It follows the **net** return index, in which dividends are reinvested after withholding tax, whereas the stocks' adjusted prices reinvest dividends **gross**. The portfolio's relative performance is therefore slightly flattered, by roughly the withholding tax on the benchmark's dividends.
- Concentration: the portfolio holds nine stocks from three countries (France, Germany, the Netherlands), so its results are specific to these companies and to the eurozone large-cap market.
- Risk-free rate: the constant 1.05% is a full-period approximation of €STR, whose annual average ranged from about −0.57% to 3.64% over 2019–2025.

## 10. Disclaimer

This project is for educational and analytical purposes only. It does not constitute investment advice or a recommendation to buy or sell securities.