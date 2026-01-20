CREATE TABLE user_logins (
    user_id    INT,
    login_date DATE
);

INSERT INTO user_logins VALUES
(1, '2026-01-01'),
(1, '2026-01-02'),
(1, '2026-01-03'),
(1, '2026-01-05'),
(2, '2026-01-01'),
(2, '2026-01-03'),
(2, '2026-01-04'),
(2, '2026-01-05'),
(3, '2026-01-02'),
(3, '2026-01-03'),
(3, '2026-01-04'),
(3, '2026-01-06'),
(4, '2026-01-01');



with cte_1 AS (
  SELECT
    user_id,
    login_date,
    LAG(login_date, 1) OVER(PARTITION BY user_id ORDER BY login_date) AS prev_login_date 
  FROM user_logins
),

cte_2 AS (
  SELECT
    user_id,
    login_date,
    prev_login_date,
    CASE 
      WHEN DATEDIFF(login_date, prev_login_date) > 1 THEN 1
      WHEN prev_login_date IS NULL THEN 1
      ELSE 0
    END AS break_flg
  FROM cte_1
),

cte_3 AS (
  SELECT
    user_id,
    login_date,
    prev_login_date,
    break_flg,
    SUM(break_flg) OVER(PARTITION BY user_id ORDER BY login_date) AS session_id
  FROM cte_2
),

cte_4 AS (
  SELECT 
    user_id,
    session_id,
    COUNT(session_id) as max_streak_per_session
  FROM cte_3
  GROUP BY user_id, session_id
)

SELECT 
  user_id,
  MAX(max_streak_per_session) as streak_length
FROM cte_4
GROUP BY user_id
HAVING streak_length >= 3
