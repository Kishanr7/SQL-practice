-- # Write your MySQL query statement below
with cte AS (
    select 
        *,
        rank() over (partition by customer_id order by order_date) as 'rn'
    from delivery
)

SELECT ROUND((COUNT(d1.customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM delivery)*100),2) as immediate_percentage
FROM cte d1 JOIN
delivery d2 on d1.order_date = d2.customer_pref_delivery_date and d1.customer_id = d2.customer_id
WHERE rn=1