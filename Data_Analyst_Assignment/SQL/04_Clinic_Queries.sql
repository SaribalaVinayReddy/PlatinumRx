-- Q1: Revenue by sales channel for a given year.
SELECT
  sales_channel,
  SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY revenue DESC;

-- Q2: Top 10 most valuable customers for a given year.
SELECT
  c.uid,
  c.name,
  SUM(s.amount) AS total_spend
FROM clinic_sales s
JOIN customer c ON s.uid = c.uid
WHERE YEAR(s.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spend DESC
LIMIT 10;

-- Q3: Month-wise revenue, expense, profit, and status for a given year.
WITH monthly_revenue AS (
  SELECT
    DATE_FORMAT(datetime, '%Y-%m') AS month_key,
    SUM(amount) AS revenue
  FROM clinic_sales
  WHERE YEAR(datetime) = 2021
  GROUP BY DATE_FORMAT(datetime, '%Y-%m')
),
monthly_expense AS (
  SELECT
    DATE_FORMAT(datetime, '%Y-%m') AS month_key,
    SUM(amount) AS expense
  FROM expenses
  WHERE YEAR(datetime) = 2021
  GROUP BY DATE_FORMAT(datetime, '%Y-%m')
),
monthly_totals AS (
  SELECT month_key, revenue, 0 AS expense
  FROM monthly_revenue
  UNION ALL
  SELECT month_key, 0 AS revenue, expense
  FROM monthly_expense
)
SELECT
  month_key AS month,
  SUM(revenue) AS revenue,
  SUM(expense) AS expense,
  SUM(revenue) - SUM(expense) AS profit,
  CASE WHEN SUM(revenue) - SUM(expense) >= 0 THEN 'profitable' ELSE 'not-profitable' END AS status
FROM monthly_totals
GROUP BY month_key
ORDER BY month_key;

-- Q4: Most profitable clinic per city for a given month.
SET @target_month = '2021-11';

WITH monthly_revenue AS (
  SELECT cid, DATE_FORMAT(datetime, '%Y-%m') AS month_key, SUM(amount) AS revenue
  FROM clinic_sales
  GROUP BY cid, month_key
),
monthly_expense AS (
  SELECT cid, DATE_FORMAT(datetime, '%Y-%m') AS month_key, SUM(amount) AS expense
  FROM expenses
  GROUP BY cid, month_key
),
clinic_profit AS (
  SELECT
    cl.cid,
    cl.clinic_name,
    cl.city,
    COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
  FROM clinics cl
  LEFT JOIN monthly_revenue r ON cl.cid = r.cid AND r.month_key = @target_month
  LEFT JOIN monthly_expense e ON cl.cid = e.cid AND e.month_key = @target_month
)
SELECT city, cid, clinic_name, profit
FROM (
  SELECT
    cp.*,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY profit DESC) AS rn
  FROM clinic_profit cp
) t
WHERE rn = 1
ORDER BY city;

-- Q5: Second least profitable clinic per state for a given month.
SET @target_month = '2021-11';

WITH monthly_revenue AS (
  SELECT cid, DATE_FORMAT(datetime, '%Y-%m') AS month_key, SUM(amount) AS revenue
  FROM clinic_sales
  GROUP BY cid, month_key
),
monthly_expense AS (
  SELECT cid, DATE_FORMAT(datetime, '%Y-%m') AS month_key, SUM(amount) AS expense
  FROM expenses
  GROUP BY cid, month_key
),
clinic_profit AS (
  SELECT
    cl.cid,
    cl.clinic_name,
    cl.state,
    COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
  FROM clinics cl
  LEFT JOIN monthly_revenue r ON cl.cid = r.cid AND r.month_key = @target_month
  LEFT JOIN monthly_expense e ON cl.cid = e.cid AND e.month_key = @target_month
)
SELECT state, cid, clinic_name, profit
FROM (
  SELECT
    cp.*,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY profit ASC) AS rn
  FROM clinic_profit cp
) t
WHERE rn = 2
ORDER BY state;
