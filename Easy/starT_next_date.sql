CREATE TABLE logins (
  user_id INT,
  login_date DATE
);

INSERT INTO logins VALUES
(1, '2026-02-01'),
(1, '2026-02-02'),
(1, '2026-02-04'),
(2, '2026-02-01'),
(2, '2026-02-03'),
(3, '2026-02-05'),
(3, '2026-02-06'),
(4, '2026-02-07');


WITH cte_1 AS (
    SELECT 
      user_id,
      login_date,
      LAG(login_date, 1) OVER(PARTITION BY user_id ORDER BY login_date) as prev_date
    FROM logins
),

cte_2 AS (
    SELECT
      user_id,
      login_date,
      prev_date,
      DATEDIFF(login_date, prev_date) as days_between_logins
    FROM cte_1
)

SELECT
    user_id,
    prev_date as start_date,
    login_date as next_date
FROM cte_2
WHERE days_between_logins = 1
