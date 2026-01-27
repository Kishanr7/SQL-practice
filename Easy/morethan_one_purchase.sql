CREATE TABLE purchases (
  purchase_id INT,
  customer_id INT,
  order_date DATE,
  amount INT
);

INSERT INTO purchases (purchase_id, customer_id, order_date, amount) VALUES
(1, 1, '2026-01-10', 100),
(2, 1, '2026-01-15', 200),
(3, 2, '2026-01-18', 150),
(4, 3, '2026-01-05', 300),
(5, 3, '2026-01-20', 400);


SELECT customer_id
FROM purchases 
GROUP BY customer_id
HAVING COUNT(customer_id) > 1