CREATE TABLE user_logins (
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins (user_id, login_date) VALUES
(1, '2026-01-01'),
(1, '2026-01-03'),
(2, '2026-01-02'),
(2, '2026-01-05'),
(3, '2026-01-01');



with prev AS (
  SELECT 
    user_id,
    login_date,
    RANK() OVER(PARTITION BY user_id ORDER BY login_date) AS rnk 
  FROM user_logins
)

SELECT 
  user_id,
  login_date as first_login_date
FROM prev
WHERE rnk = 1;
