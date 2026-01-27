CREATE TABLE purchases (
  customer_id INT,
  order_date DATE,
  amount INT
);

INSERT INTO purchases (customer_id, order_date, amount) VALUES
(1, '2026-01-10', 100),
(1, '2026-01-20', 200),
(2, '2026-01-18', 150),
(3, '2026-01-05', 300);

SELECT DISTINCT p.customer_id
FROM purchases p
WHERE NOT EXISTS (
  SELECT 1
  FROM purchases x
  WHERE x.customer_id = p.customer_id
    AND x.order_date BETWEEN DATE '2026-01-16' AND DATE '2026-01-22'
);


