-- # FIRST Write your MySQL query statement below
SELECT 
    name as Customers
FROM customers
WHERE id not in (
    SELECT 
        o.customerId
    FROM customers c
    INNER JOIN orders o 
    ON c.id = o.customerId
)
    
-- # SECOND
SELECT 
    name as Customers
FROM customers c
LEFT JOIN orders o
ON c.id = o.customerId
WHERE o.customerId is NULL
