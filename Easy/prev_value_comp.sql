CREATE TABLE daily_balance (
    txn_id     INT,
    account_id INT,
    txn_date   DATE,
    balance    INT
);

INSERT INTO daily_balance VALUES
(1, 1001, '2025-12-10', 1000),
(2, 1001, '2025-12-11', 1200),
(3, 1001, '2025-12-12', 1100),
(4, 1001, '2025-12-13', 1500),

(5, 2002, '2025-12-10', 800),
(6, 2002, '2025-12-11', 800),
(7, 2002, '2025-12-12', 900),
(8, 2002, '2025-12-13', 700);


with prev AS (
  SELECT 
    txn_id,
    account_id,
    txn_date,
    balance,
    LAG(balance, 1) OVER(PARTITION BY account_id ORDER BY txn_date) AS prev_balance 
  FROM daily_balance
)

SELECT 
  account_id,
  txn_date,
  balance,
  prev_balance,
  CASE 
    WHEN balance > prev_balance THEN 'INCREASED'
    WHEN balance < prev_balance THEN 'DECREASED'
    ELSE 'NO_CHANGE'
  END AS balance_trend
FROM prev;