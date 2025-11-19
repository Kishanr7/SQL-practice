CREATE TABLE pageviews (
    user_id        INT,
    page_url       TEXT,
    view_ts        TIMESTAMP,
    device_type    TEXT
);

INSERT INTO pageviews (user_id, page_url, view_ts, device_type) VALUES
(101, '/home',      '2025-11-19 09:00:10', 'mobile'),
(101, '/products',  '2025-11-19 09:02:15', 'mobile'),
(101, '/cart',      '2025-11-19 09:05:00', 'mobile'),
(202, '/home',      '2025-11-19 09:10:00', 'desktop'),
(202, '/search',    '2025-11-19 09:12:20', 'desktop'),
(202, '/product/7', '2025-11-19 09:14:55', 'desktop'),
(303, '/home',      '2025-11-19 09:20:00', 'tablet');


WITH prev_ts AS (
  SELECT 
    user_id,
    view_ts,
    LAG(view_ts, 1) OVER(PARTITION BY user_id ORDER BY view_ts) AS prev_ts
  FROM pageviews
),

gap_analysis AS (
  SELECT
    user_id,
    view_ts,
    prev_ts,
    ROUND(TIMESTAMPDIFF(second, prev_ts, view_ts),1) AS gap_seconds
  FROM prev_ts
),

sessions AS (
  SELECT
  user_id,
  view_ts,
  prev_ts,
  gap_seconds,
  CASE 
    WHEN prev_ts IS NULL THEN 1              -- first event for this user
    WHEN gap_seconds > 300 THEN 1           -- gap > 5 mins = new session
    ELSE 0                                  -- still in same session
  END AS is_new_session
  FROM gap_analysis
),

ses_num AS (
  SELECT
  user_id,
  view_ts,
  prev_ts,
  gap_seconds,
  is_new_session,
  SUM(is_new_session) OVER(PARTITION BY user_id ORDER BY view_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS session_num
  FROM sessions
)
SELECT 
  user_id,
  session_num,
  MIN(view_ts) AS session_start,
  MAX(view_ts) AS session_end,
  ROUND(TIMESTAMPDIFF(second, MIN(view_ts), MAX(view_ts)),1) AS session_duration_seconds 
FROM ses_num
GROUP BY user_id, session_num
