CREATE TABLE transactions (
  transaction_id INT,
  user_id INT,
  txn_date DATE,
  amount INT
);

INSERT INTO transactions VALUES
(1, 1, '2026-01-25', 100),
(2, 2, '2026-01-25', 300),
(3, 3, '2026-01-25', 300),
(4, 1, '2026-01-26', 200),
(5, 2, '2026-01-26', 150),
(6, 3, '2026-01-26', 400);

with cte_1 AS (
  SELECT 
    txn_date,
    user_id,
    SUM(amount) AS total_amount
  FROM transactions
  GROUP BY txn_date, user_id
),

cte_2 AS (
  SELECT
    txn_date,
    user_id,
    total_amount,
    RANK() OVER(PARTITION BY txn_date ORDER BY total_amount DESC) AS rnk
  FROM cte_1
)

SELECT 
  txn_date,
  user_id,
  total_amount
FROM cte_2
WHERE rnk = 1