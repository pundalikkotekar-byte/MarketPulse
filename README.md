# MarketPulse – E-Commerce Business & Customer Intelligence

An end-to-end Data Analytics project exploring e-commerce sales, customer behaviour, product performance and delivery operations using Python, PostgreSQL and Power BI.

## Project Overview

MarketPulse transforms raw e-commerce data into actionable business insights through data cleaning, exploratory analysis, advanced SQL queries, RFM customer segmentation and interactive Power BI dashboards.

The project uses the Brazilian Olist E-Commerce dataset.

## Business Objectives

- Analyze revenue and sales performance.
- Identify top-performing product categories and sellers.
- Understand customer purchasing behaviour.
- Identify repeat customers and customer segments.
- Evaluate delivery performance.
- Analyze customer reviews and satisfaction.

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data cleaning and analysis |
| Pandas & NumPy | Data manipulation |
| Matplotlib & Seaborn | Exploratory data visualization |
| PostgreSQL | Database management and SQL analysis |
| SQL | Business queries and analytical views |
| Power BI | Interactive dashboards |
| DAX | KPI calculations and measures |
| Git & GitHub | Version control and project hosting |

## Project Workflow

1. Data Collection
2. Data Cleaning and Preprocessing
3. Exploratory Data Analysis
4. Business Performance Analysis
5. Customer RFM Segmentation
6. PostgreSQL Database Integration
7. Advanced SQL Analysis
8. Power BI Dashboard Development

## Key Business Insights

### Customer Intelligence
- Total unique customers analyzed: 93,357
- Repeat customers: 2,801
- Repeat customer rate: 3.0%
- One-time customers: 90,556

### RFM Segmentation

| Customer Segment | Customers |
|---|---:|
| Hibernating Customers | 45,420 |
| Recent Customers | 45,136 |
| Loyal Customers | 1,402 |
| At Risk | 1,258 |
| Champions | 141 |

### Sales and Operations
- Delivered orders: 96,478
- Delivered item units: 110,197
- Average delivery time: approximately 12.56 days
- Average review score: approximately 4.09 / 5

*Figures are based on the analyzed dataset. Revenue and delivery metrics use their respective definitions in the analysis.*

## Power BI Dashboards

### 1. Sales & Business Overview

![Sales Dashboard](screenshots/dashboard-1-sales.png)

### 2. Customer Intelligence

![Customer Dashboard](screenshots/dashboard-2-customers.png)

### 3. Product & Operations Performance

![Operations Dashboard](screenshots/dashboard-3-operations.png)



## Dataset

Brazilian E-Commerce Public Dataset by Olist.

The dataset contains information about customers, orders, order items, payments, products, sellers, reviews, geolocation and product categories.

## Important Metric Definitions

- **Product Revenue:** Sum of item prices for delivered orders.
- **Payment Value:** Recorded customer payment value, which can include freight.
- **Repeat Customer Rate:** Customers with more than one delivered purchase divided by total analyzed customers.
- **RFM:** Recency, Frequency and Monetary customer segmentation.

RFM recency is calculated relative to the latest observed purchase date in the dataset, not the current date.

## Project Structure

```text
MarketPulse/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│
├── sql/
│
├── reports/
│   └── MarketPulse_Dashboard.pbix
│
├── README.md
└── .gitignore
```

## Future Improvements

- Automate data ingestion and transformation.
- Build scheduled ETL pipelines.
- Add cloud data storage.
- Implement automated data quality checks.
- Develop advanced customer retention analysis.

## Author

**Pranav Kotekar**

Data Analytics | Python | SQL | PostgreSQL | Power BI

---

*MarketPulse – Turning E-Commerce Data into Business Intelligence.*