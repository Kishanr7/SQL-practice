CREATE TABLE purchases (
    customer_id INT,
    order_id    INT,
    order_date  DATE,
    amount      INT
);

INSERT INTO purchases VALUES
(1, 301, '2026-01-10', 500),
(1, 302, '2026-01-15', 700),
(2, 303, '2026-01-18', 300),
(3, 304, '2026-01-05', 400),
(4, 305, '2026-01-20', 250);

SELECT DISTINCT p.customer_id
FROM purchases p
WHERE NOT EXISTS (
  SELECT 1
  FROM purchases x
  WHERE x.customer_id = p.customer_id
    AND x.order_date BETWEEN DATE '2026-01-16' AND DATE '2026-01-22'
);


