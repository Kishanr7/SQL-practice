WITH grouped AS (
  SELECT 
    user_id,
    event_date,
    SUM(payload_size) AS total_payload,
    DENSE_RANK() OVER(PARTITION BY event_date ORDER BY SUM(payload_size) DESC) AS rnk
  FROM 
    events 
  GROUP BY user_id, event_date
)

SELECT
  user_id,
  event_date,
  total_payload,
  rnk
FROM grouped
WHERE rnk <= 2;