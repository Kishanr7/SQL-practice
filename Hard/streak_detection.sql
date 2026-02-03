CREATE TABLE user_logins (
  user_id INT,
  login_date DATE
);

INSERT INTO user_logins VALUES
(1, '2026-01-01'),
(1, '2026-01-02'),
(1, '2026-01-04'),
(1, '2026-01-05'),
(2, '2026-01-01'),
(2, '2026-01-03'),
(2, '2026-01-04'),
(3, '2026-01-02');

WITH cte_1 AS (
  SELECT
   user_id,
   login_date,
   LAG(login_date, 1) OVER(PARTITION BY user_id ORDER BY login_date) as prev_login_date
   FROM user_logins
),

cte_2 AS (
  SELECT 
    user_id,
    login_date,
    prev_login_date,
    DATEDIFF(login_date, prev_login_date) as gap_days
  FROM cte_1
),

cte_3 AS (
  SELECT 
    *,
    CASE 
      WHEN gap_days > 1 THEN 1 
      WHEN gap_days IS NULL THEN 1 
      ELSE 0 
    END AS flg
  FROM cte_2
),

cte_4 AS (
  SELECT 
    *,
    SUM(flg) OVER(PARTITION BY user_id ORDER BY login_date) as session_id
  FROM cte_3
),

cte_5 AS (
  SELECT 
    user_id,
    min(login_date) as streak_start_date
  FROM cte_4
  GROUP BY user_id,session_id
  HAVING count(session_id) > 1
)

SELECT
  user_id,
  min(streak_start_date) as streak_start_date
FROM cte_5
GROUP BY user_id



