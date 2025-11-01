-- Customers
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  city VARCHAR(100)
);

INSERT INTO customers VALUES
(1,'Asha','Mumbai'),
(2,'Ravi','Delhi'),
(3,'Neha','Bengaluru'),
(4,'Kiran','Hyderabad'),
(5,'Zoya','Pune');

-- Categories
CREATE TABLE categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(100)
);

INSERT INTO categories VALUES
(1,'Electronics'),
(2,'Home'),
(3,'Books'),
(4,'Fashion');

-- Products
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category_id INT,
  list_price DECIMAL(12,2),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products VALUES
(101,'Phone X',1,50000),
(102,'Laptop Pro',1,90000),
(103,'Blender 500',2,4000),
(104,'Novel – “Data Tales”',3,500),
(105,'T-Shirt Classic',4,800);

-- Orders (one row per order)
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(201,1,'2025-10-01'),
(202,3,'2025-10-05'),
(203,1,'2025-10-18'),
(204,2,'2025-10-20'),
(205,3,'2025-10-21'),
(206,5,'2025-10-25');

-- Order items (one row per product in an order)
CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price DECIMAL(12,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(1,201,101,1,50000),           -- Asha buys Phone X
(2,202,103,2,3800),            -- Neha buys 2x Blender (discounted)
(3,202,104,1,500),             -- + a book
(4,203,102,1,90000),           -- Asha buys Laptop Pro
(5,204,104,3,500),             -- Ravi buys 3x book
(6,205,105,2,750),             -- Neha buys 2x T-shirt (discount)
(7,206,103,1,4000),            -- Zoya buys Blender at list
(8,206,104,2,450);             -- + 2x book (promo)

-- Payments (can be multiple per order, but here one each)
CREATE TABLE payments (
  payment_id INT PRIMARY KEY,
  order_id INT,
  paid_amount DECIMAL(12,2),
  payment_method VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments VALUES
(1,201,50000,'UPI'),
(2,202,8100,'Card'),   -- 2*3800 + 500 = 8100
(3,203,90000,'Card'),
(4,204,1500,'UPI'),
(5,205,1500,'UPI'),    -- 2*750 = 1500
(6,206,4900,'Card');   -- 4000 + 2*450 = 4900

-- Returns (partial returns allowed; refund may differ from unit_price*qty due to fees)
CREATE TABLE returns (
  return_id INT PRIMARY KEY,
  order_item_id INT,
  return_date DATE,
  returned_qty INT,
  refund_amount DECIMAL(12,2),
  FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id)
);

-- Asha returns nothing.
-- Neha returns 1 blender from order 202 (partial)
INSERT INTO returns VALUES
(1,2,'2025-10-08',1,3600);

-- Ravi returns 1 book from order 204
INSERT INTO returns VALUES
(2,5,'2025-10-23',1,500);

-- Zoya returns 1 book from order 206
INSERT INTO returns VALUES
(3,8,'2025-10-28',1,450);

SELECT * FROM customers;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM returns;


-- Oct 2025 lines with category & customer
WITH base AS (
  SELECT
    cat.category_name,
    cust.customer_name,
    oi.order_item_id,
    (oi.quantity * oi.unit_price) AS line_total
  FROM orders o
  JOIN order_items oi   ON oi.order_id = o.order_id
  JOIN products p       ON p.product_id = oi.product_id
  JOIN categories cat   ON cat.category_id = p.category_id
  JOIN customers cust   ON cust.customer_id = o.customer_id
  WHERE o.order_date >= DATE '2025-10-01'
    AND o.order_date <  DATE '2025-11-01'
),
net AS (
  SELECT
    b.category_name,
    b.customer_name,
    SUM(b.line_total) - COALESCE(SUM(r.refund_amount), 0) AS net_spend
  FROM base b
  LEFT JOIN returns r ON r.order_item_id = b.order_item_id
  GROUP BY b.category_name, b.customer_name
),
ranked AS (
  SELECT
    category_name,
    customer_name,
    net_spend,
    DENSE_RANK() OVER (
      PARTITION BY category_name
      ORDER BY net_spend DESC
    ) AS rank_in_category
  FROM net
)
SELECT category_name, customer_name, net_spend, rank_in_category
FROM ranked
WHERE net_spend > 0            -- exclude zero/negative if you want only spenders
  AND rank_in_category <= 2    -- top 2 per category (with ties)
ORDER BY category_name, rank_in_category, customer_name;
