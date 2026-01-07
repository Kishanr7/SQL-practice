CREATE TABLE user_logins (
    user_id     INT,
    login_date  DATE
);

INSERT INTO user_logins VALUES
(1, '2026-01-01'),
(1, '2026-01-02'),
(1, '2026-01-04'),
(1, '2026-01-05'),
(1, '2026-01-06'),

(2, '2026-01-01'),
(2, '2026-01-03'),
(2, '2026-01-04'),
(2, '2026-01-05');


with prev AS (
  SELECT 
    user_id,
    login_date,
    LAG(login_date, 1) OVER(PARTITION BY user_id ORDER BY login_date) AS prev_login_date 
  FROM user_logins
),

brk_flg AS (
  SELECT 
    user_id,
    login_date,
    prev_login_date,
    datediff(day, prev_login_date, login_date) as gap_days,
    CASE 
      WHEN prev_login_date IS NULL THEN 1
      WHEN datediff(day, prev_login_date, login_date) > 1 THEN 1
      ELSE 0
    END AS break_flag
  FROM prev
)

SELECT 
  user_id,
  login_date,
  SUM(break_flag) OVER(PARTITION BY user_id ORDER BY login_date) AS streak_group
FROM 
brk_flg;
