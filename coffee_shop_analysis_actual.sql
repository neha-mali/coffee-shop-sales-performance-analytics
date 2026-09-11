-- ============================================================
-- Coffee Shop Sales Analysis
-- PostgreSQL
-- Table: coffee_sales
-- ============================================================

-- 1. Preview data and calculate revenue
SELECT
    *,
    transaction_qty * unit_price AS revenue
FROM coffee_sales
LIMIT 10;


-- 2. Store-level KPIs
SELECT
    store_location,
    SUM(transaction_qty * unit_price) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(transaction_qty) AS total_units_sold,
    ROUND(
        SUM(transaction_qty * unit_price) / COUNT(DISTINCT transaction_id),
        2
    ) AS avg_order_value
FROM coffee_sales
GROUP BY store_location
ORDER BY total_revenue DESC;


-- 3. Monthly revenue
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM coffee_sales
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month;


-- 4. Month-over-month revenue growth
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS month,
        SUM(transaction_qty * unit_price) AS total_revenue
    FROM coffee_sales
    GROUP BY DATE_TRUNC('month', transaction_date)
)

SELECT
    month,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        (
            total_revenue
            - LAG(total_revenue) OVER (ORDER BY month)
        )
        / LAG(total_revenue) OVER (ORDER BY month)
        * 100,
        2
    ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY month;


-- 5. Revenue and transactions by day of week
SELECT
    TO_CHAR(transaction_date, 'Day') AS day_of_week,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_sales
GROUP BY
    TO_CHAR(transaction_date, 'Day'),
    EXTRACT(DOW FROM transaction_date)
ORDER BY EXTRACT(DOW FROM transaction_date);


-- 6. Revenue and transactions by hour of day
SELECT
    EXTRACT(HOUR FROM transaction_time) AS hour_of_day,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_sales
GROUP BY EXTRACT(HOUR FROM transaction_time)
ORDER BY hour_of_day;


-- 7. Product category performance
SELECT
    product_category,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_sales
GROUP BY product_category
ORDER BY total_revenue DESC;


-- 8. Top 10 product types by revenue
SELECT
    product_type,
    product_category,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_sales
GROUP BY product_type, product_category
ORDER BY total_revenue DESC
LIMIT 10;


-- 9. Product category performance by store
SELECT
    store_location,
    product_category,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold
FROM coffee_sales
GROUP BY
    store_location,
    product_category
ORDER BY
    store_location,
    total_revenue DESC;


-- 10. Rank stores by revenue
WITH store_revenue AS (
    SELECT
        store_location,
        SUM(transaction_qty * unit_price) AS total_revenue
    FROM coffee_sales
    GROUP BY store_location
)

SELECT
    store_location,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM store_revenue
ORDER BY revenue_rank;


-- 11. Weekday vs weekend totals
SELECT
    CASE
        WHEN EXTRACT(DOW FROM transaction_date) IN (0, 6)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(transaction_qty) AS total_units_sold

FROM coffee_sales

GROUP BY
    CASE
        WHEN EXTRACT(DOW FROM transaction_date) IN (0, 6)
            THEN 'Weekend'
        ELSE 'Weekday'
    END

ORDER BY total_revenue DESC;


-- 12. Average daily revenue: weekday vs weekend
WITH daily_sales AS (
    SELECT
        transaction_date,
        CASE
            WHEN EXTRACT(DOW FROM transaction_date) IN (0, 6)
                THEN 'Weekend'
            ELSE 'Weekday'
        END AS day_type,
        SUM(transaction_qty * unit_price) AS daily_revenue
    FROM coffee_sales
    GROUP BY
        transaction_date,
        CASE
            WHEN EXTRACT(DOW FROM transaction_date) IN (0, 6)
                THEN 'Weekend'
            ELSE 'Weekday'
        END
)

SELECT
    day_type,
    ROUND(AVG(daily_revenue), 2) AS avg_daily_revenue
FROM daily_sales
GROUP BY day_type
ORDER BY avg_daily_revenue DESC;
