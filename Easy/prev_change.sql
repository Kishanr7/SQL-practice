CREATE TABLE daily_users (
    activity_date DATE,
    app_name      VARCHAR(50),
    active_users  INT
);

INSERT INTO daily_users VALUES
('2026-01-01', 'chat',   120),
('2026-01-02', 'chat',   150),
('2026-01-03', 'chat',   140),
('2026-01-04', 'chat',   160),

('2026-01-01', 'search', 300),
('2026-01-02', 'search', 300),
('2026-01-03', 'search', 320),
('2026-01-04', 'search', 310);



with prev AS (
  SELECT 
    app_name,
    activity_date,
    active_users,
    LAG(active_users, 1) OVER(PARTITION BY app_name ORDER BY activity_date) AS prev_day_users 
  FROM daily_users
)

SELECT 
  app_name,
  activity_date,
  active_users,
  prev_day_users,
  CASE 
    WHEN active_users > prev_day_users THEN 'UP'
    WHEN active_users < prev_day_users THEN 'DOWN'
    ELSE 'NO_CHANGE'
  END AS user_trend
FROM prev;