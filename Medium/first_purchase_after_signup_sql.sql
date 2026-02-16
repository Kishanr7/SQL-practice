CREATE TABLE users (
  user_id INT,
  signup_date DATE
);

INSERT INTO users VALUES
(1, '2026-01-01'),
(2, '2026-01-05'),
(3, '2026-01-10'),
(4, '2026-01-15');

CREATE TABLE purchases (
  purchase_id INT,
  user_id INT,
  purchase_date DATE,
  amount DECIMAL(10,2)
);

INSERT INTO purchases VALUES
(1, 1, '2026-01-02', 100.00),
(2, 1, '2026-01-10', 150.00),
(3, 2, '2026-01-07', 200.00),
(4, 2, '2026-01-20', 250.00),
(5, 3, '2026-01-25', 300.00);


WITH cte_1 AS (
  SELECT 
    u.user_id,
    u.signup_date,
    p.purchase_id,
    p.purchase_date,
    p.amount
  FROM users u LEFT JOIN purchases p on u.user_id = p.user_id
  AND u.signup_date < p.purchase_date
),

cte_2 AS (
  SELECT
    user_id,
    signup_date,
    purchase_id,
    purchase_date,
    amount,
    DATEDIFF(purchase_date, signup_date) as days_to_first_purchase
  FROM cte_1
),

cte_3 AS (
  SELECT 
    user_id,
    signup_date,
    purchase_date,
    amount,
    days_to_first_purchase,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY purchase_date) as rnk
  FROM cte_2
)

SELECT 
  user_id,
  signup_date,
  purchase_date as first_purchase_date,
  days_to_first_purchase
FROM cte_3
WHERE rnk = 1
ORDER BY user_id