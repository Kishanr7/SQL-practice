WITH cte AS ( 
  SELECT 
    user_id, 
    event_ts, 
    amount, 
    COALESCE(
        SUM(amount) OVER(
            PARTITION BY user_id 
            ORDER BY event_ts 
            -- Window frame to exclude current row: 10s preceding up to 0s preceding
            RANGE BETWEEN INTERVAL '10' SECOND PRECEDING AND CURRENT ROW
        ), 0
    ) AS rolling_sum_10s_including
  FROM transactions 
),

10s AS (
  SELECT
    user_id,
    event_ts,
    amount,
    rolling_sum_10s_including,
    COALESCE((rolling_sum_10s_including - amount),0) AS rolling_sum_10s 
  FROM cte
)

SELECT 
  user_id,
  event_ts,
  amount,
  rolling_sum_10s,
  CASE 
    WHEN amount > 2 * rolling_sum_10s THEN 'YES'
    ELSE 'NO'
  END AS is_spike
FROM 10s;