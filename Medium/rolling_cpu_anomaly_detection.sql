CREATE TABLE service_metrics (
    event_ts      TIMESTAMP,
    event_date    DATE GENERATED ALWAYS AS (CAST(event_ts AS DATE)) STORED,
    service       VARCHAR(50),
    cpu_percent   DECIMAL(5,2)
);

INSERT INTO service_metrics (event_ts, service, cpu_percent) VALUES
('2025-11-20 09:00:00', 'auth',   45.2),
('2025-11-20 09:00:05', 'auth',   47.8),
('2025-11-20 09:00:10', 'auth',   80.5),
('2025-11-20 09:00:20', 'auth',   82.1),

('2025-11-20 09:00:00', 'orders', 35.0),
('2025-11-20 09:00:07', 'orders', 40.2),
('2025-11-20 09:00:12', 'orders', 42.5),
('2025-11-20 09:00:25', 'orders', 91.0);

WITH cte AS (
  SELECT
    service,
    event_ts,
    cpu_percent,
    AVG(cpu_percent) OVER(PARTITION BY service ORDER BY event_ts RANGE BETWEEN INTERVAL '15' SECOND PRECEDING AND CURRENT ROW) AS rolling_avg_15s
  FROM service_metrics
)

SELECT 
  event_ts,
  service,
  cpu_percent,
  rolling_avg_15s,
  CASE 
    WHEN cpu_percent > (rolling_avg_15s * 1.5) THEN 'YES'
    ELSE 'NO'
  END AS 'is_anomaly'
FROM cte;