-- Algorithm Explanation:
-- Problem: Calculate the average selling price for each product based on units sold within specific price periods
-- 
-- Issues with Original Code:
-- 1. Used INNER JOIN which excludes products with no sales
-- 2. total_units CTE ignores date ranges and sums ALL units ever sold
-- 3. Incorrect grouping in total_price CTE
-- 4. No handling for products that exist in prices but have no sales
--
-- Corrected Approach:
-- 1. Use LEFT JOIN to include all products from prices table
-- 2. Filter sales to only those within the price date range using JOIN condition
-- 3. Calculate weighted average: SUM(price * units) / SUM(units) for each product
-- 4. Handle products with no sales by returning 0 as average price

SELECT 
    p.product_id,
    -- Calculate weighted average price or return 0 if no sales
    COALESCE(
        ROUND(
            SUM(p.price * u.units) / NULLIF(SUM(u.units), 0), -- Weighted average calculation
            2
        ), 
        0 -- Default to 0 if no sales within price period
    ) as average_price
FROM 
    prices p
    -- LEFT JOIN ensures all products appear in result, even with no sales
    LEFT JOIN unitssold u ON p.product_id = u.product_id 
        -- Critical: Only include sales within the price period
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id -- Group by product to get one row per product
ORDER BY 
    p.product_id;

-- Key Changes Explained:
-- 1. LEFT JOIN: Keeps all products from prices table, even those with no sales
-- 2. Date filtering in JOIN: Only considers sales within each product's price period
-- 3. COALESCE: Returns 0 when no sales exist (handles NULL division result)
-- 4. NULLIF: Prevents division by zero error when SUM(u.units) = 0
-- 5. Single query: Eliminates complex CTE structure for better performance
-- 6. Weighted average: SUM(price * units) / SUM(units) gives correct average selling price
