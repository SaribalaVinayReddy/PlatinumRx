-- Q1: For every user, get the user_id and the last booked room_no.
SELECT
  u.user_id,
  b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
  SELECT MAX(b2.booking_date)
  FROM bookings b2
  WHERE b2.user_id = u.user_id
);

-- Q2: Get booking_id and total billing amount of every booking created in November 2021.
SELECT
  b.booking_id,
  SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11
  AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id;

-- Q3: Get bill_id and bill amount of all bills raised in October 2021 with amount > 1000.
SELECT
  bc.bill_id,
  SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4: Determine the most ordered and least ordered item for each month of 2021.
WITH monthly_item_totals AS (
  SELECT
    DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
    i.item_name,
    SUM(bc.item_quantity) AS total_quantity
  FROM booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
  WHERE YEAR(bc.bill_date) = 2021
  GROUP BY bill_month, i.item_name
),
ranked AS (
  SELECT
    bill_month,
    item_name,
    total_quantity,
    ROW_NUMBER() OVER (PARTITION BY bill_month ORDER BY total_quantity DESC) AS rank_desc,
    ROW_NUMBER() OVER (PARTITION BY bill_month ORDER BY total_quantity ASC) AS rank_asc
  FROM monthly_item_totals
)
SELECT bill_month, 'Most Ordered' AS category, item_name, total_quantity
FROM ranked
WHERE rank_desc = 1
UNION ALL
SELECT bill_month, 'Least Ordered' AS category, item_name, total_quantity
FROM ranked
WHERE rank_asc = 1
ORDER BY bill_month, category;

-- Q5: Find customers with the second highest bill value for each month of 2021.
WITH bill_totals AS (
  SELECT
    bc.bill_id,
    DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
  FROM booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
  WHERE YEAR(bc.bill_date) = 2021
  GROUP BY bc.bill_id, bill_month
),
ranked_bills AS (
  SELECT
    bill_month,
    bill_id,
    bill_amount,
    DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY bill_amount DESC) AS rn
  FROM bill_totals
)
SELECT bill_month, bill_id, bill_amount
FROM ranked_bills
WHERE rn = 2
ORDER BY bill_month;
