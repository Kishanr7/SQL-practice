CREATE TABLE daily_orders (
    customer_id   INT,
    order_date    DATE,
    order_amount  DECIMAL(10,2)
);

INSERT INTO daily_orders (customer_id, order_date, order_amount) VALUES
(101, '2025-11-15',  500.00),
(101, '2025-11-16',  0.00),
(101, '2025-11-17', 250.00),
(101, '2025-11-18', 300.00),
(101, '2025-11-19',  0.00),
(101, '2025-11-20', 450.00),
(101, '2025-11-21', 700.00),

(202, '2025-11-15', 100.00),
(202, '2025-11-16', 150.00),
(202, '2025-11-17',   0.00),
(202, '2025-11-18', 200.00),
(202, '2025-11-19', 300.00),
(202, '2025-11-20',  50.00),
(202, '2025-11-21', 400.00);


SELECT * FROM daily_orders;

WITH seven_day_revenue_cte AS ( 
  SELECT 
    customer_id, 
    order_date, 
    order_amount, 
    COALESCE(
        SUM(order_amount) OVER(
            PARTITION BY customer_id 
            ORDER BY order_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 0
    ) AS seven_day_revenue
  FROM daily_orders 
)
SELECT 
  customer_id,
  order_date,
  order_amount,
  seven_day_revenue,
  COALESCE((seven_day_revenue / 7),0) AS seven_day_avg_revenue 
FROM seven_day_revenue_cte;