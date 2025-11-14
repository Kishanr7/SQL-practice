SELECT 
  user_id,
  event_ts,
  event_type,
  payload_size,
  AVG(payload_size) OVER(PARTITION BY user_id ORDER BY event_ts ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM events;