CREATE TABLE daily_metrics (
    metric_date DATE,
    service     VARCHAR(50),
    requests    INT
);

INSERT INTO daily_metrics VALUES
('2026-01-09', 'auth',   120),
('2026-01-10', 'auth',   150),
('2026-01-11', 'auth',   130),
('2026-01-12', 'auth',   180),
('2026-01-13', 'auth',   160),

('2026-01-09', 'orders', 300),
('2026-01-10', 'orders', 280),
('2026-01-11', 'orders', 310),
('2026-01-12', 'orders', 290),
('2026-01-13', 'orders', 330);


with prev AS (
  SELECT 
    service,
    metric_date,
    requests,
    AVG(requests) OVER(
          PARTITION BY service 
          ORDER BY metric_date
          ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_3day_requests 
  FROM daily_metrics
)

SELECT 
  service,
  metric_date,
  requests,
  avg_3day_requests,
  CASE 
    WHEN requests > avg_3day_requests THEN 'ABOVE_AVG'
    ELSE 'NORMAL'
  END AS 'request_flag'
FROM prev