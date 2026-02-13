CREATE TABLE purchases (
  user_id INT,
  purchase_date DATE,
  amount DECIMAL(10,2)
);

INSERT INTO purchases VALUES
(1, '2026-01-01', 100.00),
(1, '2026-01-05', 150.00),
(1, '2026-01-20', 200.00),
(2, '2026-01-02', 80.00),
(2, '2026-01-10', 120.00),
(3, '2026-01-03', 50.00),
(3, '2026-01-06', 75.00),
(4, '2026-01-04', 60.00);

WITH cte_1 AS (
    SELECT 
      user_id,
      purchase_date,
      amount,
      ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY purchase_date) as rnk
    FROM purchases
),

cte_2 AS (
    SELECT
        user_id,
        purchase_date as first_purchase_date,
        amount,
        rnk
    FROM cte_1
    WHERE rnk = 1
),


cte_3 AS (
    SELECT
        user_id,
        purchase_date as second_purchase_date,
        amount,
        rnk
    FROM cte_1
    WHERE rnk = 2
),

cte_4 AS (
  SELECT 
    c2.user_id,
    c2.first_purchase_date,
    c3.second_purchase_date,
    DATEDIFF(c3.second_purchase_date, c2.first_purchase_date) as days_between_purchases
  from cte_2 c2 LEFT JOIN
  cte_3 c3 on c2.user_id = c3.user_id
)


SELECT
    user_id,
    first_purchase_date,
    CASE 
      WHEN days_between_purchases <=7 THEN second_purchase_date
    END as second_purchase_date,
    CASE
      WHEN days_between_purchases <=7 THEN 1
      ELSE 0
    END As made_second_purchase_within_7_days
FROM cte_4