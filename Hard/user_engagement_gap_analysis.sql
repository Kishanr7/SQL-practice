WITH lag_time AS (
  SELECT 
    event_id,
    user_id,
    event_ts,
    platform,
    LAG(event_ts,1) OVER(PARTITION BY user_id ORDER BY event_ts) AS prev_event_ts
  FROM user_activity
),

gap_analysis AS (
  SELECT
    user_id,
    ROUND(AVG(TIMESTAMPDIFF(minute, prev_event_ts, event_ts)),1) AS avg_gap_mins 
  FROM lag_time
  GROUP BY user_id
),

ranked AS (
  SELECT
    user_id,
    platform,
    RANK() OVER(PARTITION BY user_id ORDER BY COUNT(platform) DESC) AS rnk
  FROM user_activity
  GROUP BY user_id, platform
)

SELECT 
  ga.user_id, 
  ga.avg_gap_mins,
  r.platform as top_platform
FROM gap_analysis ga JOIN
ranked r ON ga.user_id = r.user_id
WHERE rnk = 1