CREATE TABLE product_prices (
  product_id INT,
  price INT,
  effective_date DATE
);

CREATE TABLE orders (
  order_id INT,
  product_id INT,
  order_date DATE,
  quantity INT
);

INSERT INTO product_prices VALUES
(1, 100, '2026-01-01'),
(1, 120, '2026-01-15'),
(2, 200, '2026-01-01'),
(2, 180, '2026-01-20');

INSERT INTO orders VALUES
(1, 1, '2026-01-10', 2),
(2, 1, '2026-01-16', 1),
(3, 1, '2026-01-20', 3),
(4, 2, '2026-01-10', 1),
(5, 2, '2026-01-25', 2);

WITH cte_1 AS (
  SELECT
   product_id,
   price,
   effective_date,
   LAG(price, 1) OVER(PARTITION BY product_id ORDER BY effective_date) as prev_price
   FROM product_prices
),

cte_2 AS (
  SELECT 
    product_id,
    price,
    effective_date,
    prev_price,
    CASE 
      WHEN price > prev_price THEN 'INCREASED'
      WHEN price < prev_price THEN 'DECREASED'
      ELSE 'NO CHANGE'
    END AS price_change
  FROM cte_1
)

SELECT 
  c.product_id,
  MIN(o.order_date) as first_order_after_increase
FROM cte_2 c 
JOIN orders o 
  ON c.product_id = o.product_id 
  AND c.effective_date < o.order_date
WHERE c.price_change = 'INCREASED'
GROUP BY c.product_id