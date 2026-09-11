# ☕ Coffee Shop Multi-Location Sales & Performance Analytics

## Project Overview

This project analyzes **149,116 coffee shop transactions** across **3 NYC locations** using **PostgreSQL, Python, Power Query, and Power BI**.

The goal is to understand store performance, revenue trends, peak sales periods, product demand, and opportunities to improve average order value and cross-selling.

## Business Questions

- Which store generates the most revenue?
- How does revenue change over time?
- Which days and hours generate the strongest sales?
- Which products and categories drive revenue?
- How does Average Order Value vary by location?
- Where are the biggest upsell, cross-sell, and promotional opportunities?

## Dashboard Preview

![Coffee Shop Sales Dashboard](dashboard/coffee_shop_dashboard.png)


## Tools Used

- **PostgreSQL / SQL**
  - KPI calculations
  - Aggregations
  - CTEs
  - Window functions
  - `LAG()`
  - Date and time analysis

- **Python**
  - Pandas
  - Matplotlib
  - Exploratory data analysis
  - Revenue validation
  - Product contribution analysis

- **Power Query**
  - Data transformation
  - Date/time helper columns
  - Revenue calculation

- **Power BI**
  - KPI cards
  - Revenue trends
  - Store comparison
  - Product analysis
  - Interactive filters

## Dataset

- **Source:** Maven Analytics Coffee Shop Sales Dataset
- **Transactions:** 149,116
- **Locations:** 3
  - Astoria
  - Hell's Kitchen
  - Lower Manhattan
- **Date Range:** January 1, 2023 – June 30, 2023

### Main Fields

- `transaction_id`
- `transaction_date`
- `transaction_time`
- `transaction_qty`
- `store_id`
- `store_location`
- `product_id`
- `unit_price`
- `product_category`
- `product_type`
- `product_detail`

### Calculated Revenue

```text
Revenue = transaction_qty × unit_price
```

## Dashboard KPIs

- **Total Revenue:** $698.81K
- **Total Transactions:** 149K
- **Average Order Value:** $4.69
- **Total Units Sold:** 214K
- **Unique Products Sold:** 80

## Key Insights

- Hell's Kitchen generates the highest overall revenue.
- Astoria has the lowest Average Order Value at **$4.59**, compared with **$4.81** at Lower Manhattan.
- The AOV gap creates roughly a **$0.22 upsell or bundle opportunity per transaction** in Astoria.
- Revenue is strongest during the **8–10 AM** sales window.
- Revenue drops sharply after **10 AM** and again after **6 PM**, suggesting afternoon and evening promotion opportunities.
- Coffee contributes the largest share of revenue across all three locations.
- Bakery, Chocolate, and Merchandise contribute a smaller share of revenue, creating cross-sell opportunities.
- Revenue remains relatively stable across days of the week.
- Monthly revenue increased from approximately **$82K in January** to **$166K in June**.

## SQL Analysis

The SQL analysis includes:

- Overall KPI calculations
- Store-level revenue analysis
- Average Order Value by location
- Monthly revenue trend
- Month-over-month growth
- Revenue by day of week
- Revenue by hour
- Product category revenue
- Top 10 products by revenue
- Revenue mix by location and category
- Highest and lowest revenue days


## Python Analysis

Python was used to:

- Validate SQL revenue totals
- Analyze daily revenue trends
- Compare store performance
- Identify highest and lowest revenue days
- Analyze product revenue contribution
- Create product Pareto analysis
- Visualize daily revenue patterns


## Power BI Dashboard

The final dashboard includes:

- Total Revenue KPI
- Total Transactions KPI
- Average Order Value KPI
- Total Units Sold KPI
- Unique Products KPI
- Revenue by Location
- Revenue Share by Location
- Revenue by Day of Week
- Revenue Trend Over Time
- Revenue by Hour of Day
- Average Order Value by Location
- Revenue Mix by Location and Category
- Top 10 Products by Revenue
- Date and Location filters


## Project Outcome

- Built an end-to-end analytics workflow using SQL, Python, Power Query, and Power BI.
- Analyzed multi-location store performance and product demand.
- Identified revenue trends, sales peaks, and AOV gaps.
- Created a one-page executive dashboard focused on actionable business insights.
