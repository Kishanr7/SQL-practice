CREATE TABLE purchases (
  purchase_id INT,
  customer_id INT,
  purchase_date DATE,
  amount INT
);

INSERT INTO purchases VALUES
(1, 101, '2026-01-01', 500),
(2, 101, '2026-01-10', 300),
(3, 102, '2026-01-05', 200),
(4, 102, '2026-01-20', 400),
(5, 103, '2026-01-07', 150);

WITH cte_1 AS (
  SELECT
    customer_id,
    purchase_date,
    amount,
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY purchase_date) as rnk
  FROM purchases
),

cte_2 AS (
  SELECT 
    customer_id,
    purchase_date as first_purchase_date,
    amount
  FROM cte_1
  WHERE rnk = 1
  
),

cte_3 AS (
  SELECT 
    customer_id,
    purchase_date as second_purchase_date,
    amount
  FROM cte_1
  WHERE rnk = 2
)

SELECT 
  c2.customer_id,
  c2.first_purchase_date,
  c3.second_purchase_date,
  DATEDIFF(c3.second_purchase_date, c2.first_purchase_date) as days_between_purchases
from cte_2 c2 JOIN
cte_3 c3 on c2.customer_id = c3.customer_id

