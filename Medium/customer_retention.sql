CREATE TABLE user_logins (
  user_id INT,
  login_date DATE
);

INSERT INTO user_logins VALUES
(1, '2026-02-01'),
(1, '2026-02-02'),
(1, '2026-02-05'),
(2, '2026-02-01'),
(2, '2026-02-03'),
(2, '2026-02-04'),
(3, '2026-02-02'),
(3, '2026-02-03'),
(4, '2026-02-01');

WITH base_dates AS (
    SELECT DISTINCT login_date
    FROM user_logins
),

next_day_pairs AS (
    SELECT
        user_id,
        login_date,
        LEAD(login_date) OVER (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS next_date
    FROM user_logins
),

retained AS (
    SELECT
        login_date,
        COUNT(user_id) AS retained_users_count
    FROM next_day_pairs
    WHERE DATEDIFF(next_date, login_date) = 1
    GROUP BY login_date
)

SELECT
    b.login_date,
    COALESCE(r.retained_users_count, 0) AS retained_users_count
FROM base_dates b
LEFT JOIN retained r
    ON b.login_date = r.login_date
ORDER BY b.login_date;