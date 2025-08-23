WITH RankedCust as (
    SELECT 
        customer_id,
        region,
        sum(sales) as total_sales,
        RANK() OVER (PARTITION BY region ORDER BY sum(sales) DESC) as rank
    FROM orders
    GROUP BY customer_id, region
)

SELECT customer_id, region, total_sales
FROM RankedCust
WHERE rank <= 3