CREATE TABLE user_logins (
    user_id    INT,
    login_date DATE
);

INSERT INTO user_logins VALUES
(1, '2026-01-15'),
(2, '2026-01-15'),
(1, '2026-01-15'),
(3, '2026-01-16'),
(2, '2026-01-16'),
(2, '2026-01-16'),
(4, '2026-01-17');


with cte AS (
  SELECT 
    login_date,
    COUNT(DISTINCT user_id) AS daily_active_users 
  FROM user_logins
  GROUP BY login_date
)

SELECT *
FROM cte