CREATE TABLE store_sales (
    sale_date DATE,
    store_id  INT,
    amount    INT
);

INSERT INTO store_sales VALUES
('2026-01-15', 1, 500),
('2026-01-15', 1, 300),
('2026-01-15', 2, 700),
('2026-01-16', 1, 400),
('2026-01-16', 2, 600),
('2026-01-16', 2, 200);


with cte AS (
  SELECT 
    sale_date,
    store_id,
    SUM(amount) AS total_sales 
  FROM store_sales
  GROUP BY sale_date, store_id
)

SELECT *
FROM cte