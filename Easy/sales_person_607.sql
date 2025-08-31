-- # Write your MySQL query statement below
WITH red_cte AS (
    SELECT 
        com_id
    FROM 
        company
    WHERE name = 'RED'
)
select distinct name
FROM salesperson 
WHERE sales_id NOT IN (
    SELECT 
        sales_id
    FROM
        orders o JOIN
        red_cte r ON o.com_id = r.com_id
)


